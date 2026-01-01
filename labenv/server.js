const express = require('express');
const app = express();
const http = require('http').createServer(app);
const io = require('socket.io')(http);
const pty = require('node-pty');
const os = require('os');
const fs = require('fs');
const path = require('path');

const entrypointPath = path.join(__dirname, 'scripts', 'entrypoint');
const entrypoint = fs.existsSync(entrypointPath) ? entrypointPath : os.userInfo().shell;

// Serve static files
app.use(express.static('public'));
app.use(express.static('workshop'));
app.use(express.json());

// Serve node_modules for frontend libraries
app.use('/node_modules', express.static('node_modules'));

// API to handle clipboard from terminal
app.post('/clipboard', (req, res) => {
    const { data } = req.body;
    if (data) {
        try {
            const text = Buffer.from(data, 'base64').toString('utf-8');
            io.emit('clipboard-copy', { text });
            res.json({ success: true });
        } catch (e) {
            console.error('Clipboard decode error:', e);
            res.status(500).json({ error: 'Decode failed' });
        }
    } else {
        res.status(400).json({ error: 'Invalid request' });
    }
});

// API to list slides
app.get('/api/slides', (req, res) => {
    const slidesDir = path.join(__dirname, 'workshop');
    if (!fs.existsSync(slidesDir)) {
        return res.json([]);
    }
    const files = fs.readdirSync(slidesDir).filter(f => f.endsWith('.md'));
    res.json(files);
});

// API to get slide content
app.get('/api/slides/:filename', (req, res) => {
    const filepath = path.join(__dirname, 'workshop', req.params.filename);
    if (fs.existsSync(filepath)) {
        res.send(fs.readFileSync(filepath, 'utf8'));
    } else {
        res.status(404).send('Not found');
    }
});

// Socket.io for Terminal
io.on('connection', (socket) => {
    console.log('Client connected');
    const terminals = new Map();

    socket.on('create-terminal', (termId, callback) => {
        const ptyProcess = pty.spawn(entrypoint, [], {
            name: 'xterm-color',
            cols: 80,
            rows: 30,
            cwd: process.env.HOME,
            env: process.env
        });

        terminals.set(termId, ptyProcess);

        ptyProcess.onData((data) => {
            socket.emit('terminal-output', { termId, data });
        });

        ptyProcess.onExit(() => {
            socket.emit('terminal-exit', { termId });
            terminals.delete(termId);
        });

        if (callback) callback();
    });

    socket.on('terminal-input', ({ termId, data }) => {
        const term = terminals.get(termId);
        if (term) term.write(data);
    });

    socket.on('terminal-resize', ({ termId, cols, rows }) => {
        const term = terminals.get(termId);
        if (term) term.resize(cols, rows);
    });

    socket.on('close-terminal', ({ termId }) => {
        const term = terminals.get(termId);
        if (term) {
            term.kill();
            terminals.delete(termId);
        }
    });

    socket.on('disconnect', () => {
        console.log('Client disconnected');
        terminals.forEach(term => term.kill());
        terminals.clear();
    });
});

const PORT = process.env.PORT || 3000;
http.listen(PORT, () => {
    console.log(`Server running on http://localhost:${PORT}`);
});

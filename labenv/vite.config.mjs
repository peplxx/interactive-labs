import { defineConfig } from 'vite';
import path from 'path';

export default defineConfig({
  build: {
    outDir: 'public/assets',
    emptyOutDir: true,
    lib: {
      entry: path.resolve(__dirname, 'editor.js'),
      name: 'Editor',
      fileName: 'editor',
      formats: ['es']
    }
  },
  publicDir: false
});

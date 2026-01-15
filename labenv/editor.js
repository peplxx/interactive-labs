import {
    CodeBlockLanguageSelector,
    EmojiSelector,
    ImageEditTool,
    ImageResizeBar,
    ImageToolBar,
    InlineFormatToolbar,
    Muya,
    ParagraphFrontButton,
    ParagraphFrontMenu,
    ParagraphQuickInsertMenu,
    PreviewToolBar,
    TableColumnToolbar,
    TableDragBar,
    TableRowColumMenu,
    en,
} from '@muyajs/core';

Muya.use(EmojiSelector);
Muya.use(InlineFormatToolbar);
Muya.use(ImageToolBar);
Muya.use(ImageResizeBar);
Muya.use(ImageEditTool);
Muya.use(CodeBlockLanguageSelector);
Muya.use(ParagraphFrontButton);
Muya.use(ParagraphFrontMenu);
Muya.use(TableColumnToolbar);
Muya.use(ParagraphQuickInsertMenu);
Muya.use(TableDragBar);
Muya.use(TableRowColumMenu);
Muya.use(PreviewToolBar);

import '@muyajs/core/lib/core.css';

// Initialize the editor when DOM is ready
document.addEventListener('DOMContentLoaded', async () => {
    const container = document.querySelector('#editor');
    
    if (!container) {
        console.error('Editor container not found');
        return;
    }

    let markdown = '# Report Goes Here\n\nStart writing...';
    try {
        const response = await fetch('/README.md');
        if (response.ok) {
            markdown = await response.text();
        }
    } catch (error) {
        console.warn('Failed to load README.md, using default content.', error);
    }

    // Create Muya instance
    const muya = new Muya(container, {
        markdown: markdown,
        spellcheck: true,
        autofocus: true,
    });

    // Set default locale to English
    muya.locale(en);

    // Initialize the editor
    muya.init();

    const saveContent = async (content) => {
        try {
            await fetch('/api/save', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ content, filename: 'README.md' })
            });
            console.log('Auto-saved to README.md');
        } catch (err) {
            console.error('Auto-save failed:', err);
        }
    };

    let timeoutId;
    muya.on('json-change', () => {
        const markdown = muya.getMarkdown();
        if (timeoutId) clearTimeout(timeoutId);
        timeoutId = setTimeout(() => saveContent(markdown), 1000);
    });
});

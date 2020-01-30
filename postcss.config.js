module.exports = {
    plugins: {
        '@fullhuman/postcss-purgecss': {
            content: ['layouts/**/*.html', 'content/**/*.md'],
            fontFace: true
        }
    }
};
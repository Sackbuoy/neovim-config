require('render-markdown').setup({
    render_modes = { 'n', 'c' },

    -- Minimal headings: inline icons, no backgrounds
    heading = {
        position = 'inline',
        sign = true,
        icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
        width = 'full',
        border = false,
        backgrounds = {}
    },

    -- Subtle code blocks: language info only
    code = {
        style = 'language',
        sign = false,
        left_pad = 1,
        right_pad = 1
    }
})

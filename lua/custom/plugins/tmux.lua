return {
    'alexghergh/nvim-tmux-navigation',
    config = function()
        local nvim_tmux = require('nvim-tmux-navigation')
        nvim_tmux.setup {
            disable_when_zoomed = true
        }
        
        vim.keymap.set('n', "<C-Left>", nvim_tmux.NvimTmuxNavigateLeft)
        vim.keymap.set('n', "<C-Down>", nvim_tmux.NvimTmuxNavigateDown)
        vim.keymap.set('n', "<C-Up>", nvim_tmux.NvimTmuxNavigateUp)
        vim.keymap.set('n', "<C-Right>", nvim_tmux.NvimTmuxNavigateRight)
    end
}

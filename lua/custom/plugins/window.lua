return {
    {
        'mrjones2014/smart-splits.nvim',
        event = "VeryLazy",
        config = function()
            -- Better window creation with same keybinds you would have used in tmux
            -- vim.keymap.set('n', '<C-w>|', ':vsplit<CR>', { desc = 'Split window vertically' })
            -- vim.keymap.set('n', '<C-w>-', ':split<CR>', { desc = 'Split window horizontally' })
            vim.keymap.set('n', '<leader>w|', ':vsplit<CR>', { desc = 'Split window vertically' })
            vim.keymap.set('n', '<leader>w-', ':split<CR>', { desc = 'Split window horizontally' })
            vim.keymap.set('n', '<leader>wq', ':q', { desc = 'Split window horizontally' })

            -- Set better split defaults
            vim.opt.splitbelow = true
            vim.opt.splitright = true

            local smart_splits = require('smart-splits')

            -- Keymaps for resizing splits
            vim.keymap.set('n', '<A-Left>', smart_splits.resize_left)
            vim.keymap.set('n', '<A-Down>', smart_splits.resize_down)
            vim.keymap.set('n', '<A-Up>', smart_splits.resize_up)
            vim.keymap.set('n', '<A-Right>', smart_splits.resize_right)

            -- Moving between splits
            vim.keymap.set('n', '<C-Left>', smart_splits.move_cursor_left)
            vim.keymap.set('n', '<C-Down>', smart_splits.move_cursor_down)
            vim.keymap.set('n', '<C-Up>', smart_splits.move_cursor_up)
            vim.keymap.set('n', '<C-Right>', smart_splits.move_cursor_right)

            -- Quick window commands
            vim.keymap.set('n', '<C-w>z', '<C-w>|<C-w>_', { desc = 'Zoom window' })
            vim.keymap.set('n', '<C-w>=', '<C-w>=', { desc = 'Equal window size' })
        end
    }
}

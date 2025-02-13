local M = {}

function M.setup()
    -- Better window navigation
    -- vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Navigate to left window' })
    -- vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Navigate to bottom window' })
    -- vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Navigate to top window' })
    -- vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Navigate to right window' })
    --
    -- Window management
    vim.keymap.set('n', '<leader>sv', ':vsplit<CR>', { desc = 'Split window vertically' })
    vim.keymap.set('n', '<leader>sh', ':split<CR>', { desc = 'Split window horizontally' })
    vim.keymap.set('n', '<leader>sx', ':close<CR>', { desc = 'Close current split' })

    -- Buffer navigation
    -- vim.keymap.set('n', '<S-h>', ':bprevious<CR>', { desc = 'Previous buffer' })
    -- vim.keymap.set('n', '<S-l>', ':bnext<CR>', { desc = 'Next buffer' })
    -- vim.keymap.set('n', '<leader>bd', ':bdelete<CR>', { desc = 'Close current buffer' })

    -- Better indenting
    vim.keymap.set('v', '<', '<gv', { desc = 'Indent left and reselect' })
    vim.keymap.set('v', '>', '>gv', { desc = 'Indent right and reselect' })

    -- Move selected text up and down
    -- Might be an idea to edit these to <A-j> and <A-k> for alt rather than shift!
    vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
    vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

    -- Center screen when moving
    vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down and center' })
    vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up and center' })
    vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next search result and center' })
    vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous search result and center' })

    -- Custom keymaps
    vim.keymap.set("n", "<leader>cls", "0d$", { desc = "Clear lines contents" })              -- Clears current line of all text
    vim.keymap.set("n", "<leader>nl", "yyp0d$", { desc = "New empty line - no insert mode" }) -- Adds a new empty line below the current, but auto escapes the insert mode

    vim.keymap.set("n", "<Esc>", ":noh<CR>", { silent = true })                               -- Allows you to hit escape to stop looking at highlighted text after searching

    vim.keymap.set("x", "p", "pgvy", {desc = "Rebinds the paste to ensure the copied data remains in the clipboard"})

    -- Parrot ai keybinds
    vim.keymap.set({'n', 'v'}, '<leader>ac', ':PrtChatNew<CR>', { desc = 'Create a new parrot ai chat window' })
    vim.keymap.set({'n', 'v'}, '<leader>ap', ':PrtChatNew popup<CR>', { desc = 'Create a new parrot ai chat popup' })
    vim.keymap.set({'n', 'v'}, '<leader>ai', ':PrtImplement<CR>', { desc = 'Parrot ai implement comment as prompt' })
    vim.keymap.set({'n', 'v'}, '<leader>aa', ':PrtAsk<CR>', { desc = 'Parrot ai ask question' })
end

return M

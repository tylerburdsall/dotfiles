local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
map('n', 'ff', '<Cmd>Telescope find_files<cr>', opts)
map('n', 'fg', '<Cmd>Telescope live_grep<cr>', opts)
map('n', 'fb', '<Cmd>Telescope buffers<cr>', opts)
map('n', 'fh', '<Cmd>Telescope help_tags<cr>', opts)


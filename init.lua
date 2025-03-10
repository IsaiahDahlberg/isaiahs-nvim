require "paq" {
    "savq/paq-nvim";
    "OmniSharp/omnisharp-vim";
    "Hoffs/omnisharp-extended-lsp.nvim";
    "preservim/nerdtree";
    "dense-analysis/ale";
    "BurntSushi/ripgrep";
    "nvim-lua/plenary.nvim";
    {"nvim-telescope/telescope.nvim", branch="0.1.x"};
    "prabirshrestha/asyncomplete.vim";
    "mhinz/vim-signify";
    {"neoclide/coc.nvim", branch="release"};
    "EdenEast/nightfox.nvim",
    "folke/trouble.nvim"
}


local wo = vim.wo
local g = vim.g
local opt = vim.opt

vim.o.number = true
vim.o.relativenumber = true
g.OmniSharp_server_use_net6 = 1
opt.wrap = false -- no text wrap
opt.backup = false -- no annoying backup file
-- everything in utf-8
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

vim.cmd([[
	set listchars=tab:>·,trail:~,extends:>,precedes:<,space:·
	set list
	" 4 spaces indentation
	set tabstop=4 softtabstop=0 expandtab shiftwidth=4
	" Deal with unwanted white spaces (show them in red)
	highlight ExtraWhitespace ctermbg=red guibg=red
	match ExtraWhitespace /\s\+$/
	autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
	autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
	autocmd InsertLeave * match ExtraWhitespace /\s\+$/
	autocmd BufWinLeave * call clearmatches()
]])

vim.cmd('command NT NERDTree');
vim.cmd('command FT Telescope live_grep');

require('nightfox').setup({
    options = {
        transparent = true,     -- Disable setting background
    }
})

vim.cmd("colorscheme carbonfox");

vim.keymap.set("n", "<leader>iu", function()
  vim.lsp.buf.code_action({
    context = { only = { "source.addMissingImports" } },
    apply = true,
  })
end, { desc = "Add missing imports" })

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

require('telescope').setup {
  defaults = {
    mappings = {
      i = { -- Insert mode mappings
        ["<C-t>"] = function(prompt_bufnr)
          local action = require('telescope.actions')
          action.select_tab(prompt_bufnr) -- Opens the selected file in a new tab
        end,
      },
      n = { -- Normal mode mappings
        ["<C-t>"] = function(prompt_bufnr)
          local action = require('telescope.actions')
          action.select_tab(prompt_bufnr)
        end,
      },
    },
  },
}

require("trouble").setup {
  signs = {
    error = "✘",
    warning = "▲",
    hint = "⚑",
    information = "»",
  },
  use_diagnostic_signs = true, -- Use LSP diagnostic signs
}

vim.keymap.set("n", "<leader>tf", function()
  require("trouble").open("diagnostics") -- Opens diagnostics view
  require("trouble").focus()             -- Focuses the Trouble window
end, { desc = "Open and focus Trouble diagnostics" })

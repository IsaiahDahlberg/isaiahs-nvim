require "paq" {
    "savq/paq-nvim";
    "OmniSharp/omnisharp-vim";
    "preservim/nerdtree";
    "dense-analysis/ale";
    "BurntSushi/ripgrep";
    "nvim-lua/plenary.nvim";
    {"nvim-telescope/telescope.nvim", branch="0.1.x"};
    "prabirshrestha/asyncomplete.vim";
    "mhinz/vim-signify";
    {"neoclide/coc.nvim", branch="release"};
    "EdenEast/nightfox.nvim"
}


local wo = vim.wo
local g = vim.g
local opt = vim.opt

wo.number = true -- show line numbers
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
vim.cmd('command FN Telescope find_files');
vim.cmd('command FT Telescope live_grep');

require('nightfox').setup({
    options = {
        transparent = true,     -- Disable setting background
    }
})

vim.cmd("colorscheme carbonfox");



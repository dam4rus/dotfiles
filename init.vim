call plug#begin()
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'neovim/nvim-lspconfig'
Plug 'ray-x/go.nvim'
Plug 'ray-x/guihua.lua'  
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.4' }
Plug 'kdheepak/lazygit.nvim'
Plug 'edolphin-ydf/goimpl.nvim'
Plug 'simrat39/rust-tools.nvim'
Plug 'meain/vim-jsontogo'
Plug 'numToStr/Comment.nvim'
Plug 'airblade/vim-gitgutter'
call plug#end()

colorscheme torte
set listchars+=leadmultispace:>···
set list
set tabstop=4
set shiftwidth=4
lua require('config')

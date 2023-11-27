call plug#begin()
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'neovim/nvim-lspconfig'
Plug 'ray-x/go.nvim'
Plug 'ray-x/guihua.lua'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.4' }
Plug 'kdheepak/lazygit.nvim'
Plug 'edolphin-ydf/goimpl.nvim'
Plug 'simrat39/rust-tools.nvim'
Plug 'meain/vim-jsontogo'
Plug 'numToStr/Comment.nvim'
Plug 'aspeddro/gitui.nvim'
Plug 'airblade/vim-gitgutter'
" Plug 'NTBBloodbath/galaxyline.nvim'
Plug 'nvim-lualine/lualine.nvim'
" Plug 'crispgm/nvim-tabline'
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
Plug 'RRethy/vim-illuminate'
" Plug 'martinsione/darkplus.nvim'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'akinsho/git-conflict.nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'nvim-neorg/neorg'
Plug 'folke/which-key.nvim'
Plug 'ldelossa/litee.nvim'
Plug 'ldelossa/gh.nvim'
Plug 'b0o/schemastore.nvim'
call plug#end()

" colorscheme darkplus
colorscheme catppuccin
lua require('config')
set listchars+=leadmultispace:>···
set list
set tabstop=4
set shiftwidth=4
set number
set title

" aunmenu PopUp.How-to\ disable\ mouse
menu PopUp.-2- <Nop>
menu PopUp.Find\ References <leader>fr
menu PopUp.Find\ Implementations <leader>fi

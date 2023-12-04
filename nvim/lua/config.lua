local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

vim.opt.clipboard = 'unnamedplus'

require("lazy").setup({
	{
		'nvim-treesitter/nvim-treesitter',
		build = ":TSUpdate"
	},
	'hrsh7th/cmp-nvim-lsp',
	'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-vsnip',
    'hrsh7th/vim-vsnip',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'neovim/nvim-lspconfig',
	{
		"ray-x/go.nvim",
		dependencies = {  -- optional packages
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {
			disable_defaults = false,
			gofmt = "gofmt"
		},
		event = {"CmdlineEnter"},
		ft = {"go", 'gomod'},
	},
	{
		'leoluz/nvim-dap-go',
		opts = {},
		ft = {"go"},
	},
    'nvim-tree/nvim-web-devicons',
	{
		'nvim-tree/nvim-tree.lua',
		opts = {
			view = {
				width = 40,
			},
		},
	},
	{ 'junegunn/fzf', dir = '~/.fzf', build = "./install --all" },
    'junegunn/fzf.vim',
    'nvim-lua/plenary.nvim',
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.4',
		dependencies = {
			'nvim-lua/plenary.nvim',
		},
		opts = {
			defaults = {
				layout_strategy = "flex",
				layout_config = {
					width = 0.90,
					height = 0.95,
					horizontal = {
						preview_width = 0.5,
					},
				},
			}
		},
	},
    'edolphin-ydf/goimpl.nvim',
	{
		'simrat39/rust-tools.nvim',
		dependencies = {
			'neovim/nvim-lspconfig',
			'nvim-lua/plenary.nvim',
			'mfussenegger/nvim-dap',
		},
		opts = {},
		event = {"CmdlineEnter"},
		ft = {"rust"},
	},
    'meain/vim-jsontogo',
	{
		'numToStr/Comment.nvim',
		opts = {},
	},
	{
		'aspeddro/gitui.nvim',
		opts = {},
	},
    'airblade/vim-gitgutter',
    'nvim-lualine/lualine.nvim',
	{ 'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons' },
    'RRethy/vim-illuminate',
	{
		'catppuccin/nvim',
		name = "catppuccin",
		priority = 1000,
	},
	{
		'akinsho/git-conflict.nvim',
		opts = {},
	},
    'mfussenegger/nvim-dap',
	{
		'rcarriga/nvim-dap-ui',
		dependencies = {
			'mfussenegger/nvim-dap',
		},
	},
	{
		"nvim-neorg/neorg",
		-- lazy-load on filetype
		ft = "norg",
		-- options for neorg. This will automatically call `require("neorg").setup(opts)`
		opts = {
			load = {
				["core.defaults"] = {}, -- Loads default behaviour
				["core.concealer"] = {}, -- Adds pretty icons to your documents
				["core.dirman"] = { -- Manages Neorg workspaces
					config = {
						workspaces = {
							notes = "~/notes",
						},
						index = "index.norg",
					},
				},
				["core.autocommands"] = {},
				["core.integrations.treesitter"] = {},
			},
		},
	},
	{
		'folke/which-key.nvim',
		opts = {},
	},
	'ldelossa/litee.nvim',
	'ldelossa/gh.nvim',
    'b0o/schemastore.nvim',
    'kevinhwang91/promise-async',
    'kevinhwang91/nvim-ufo',
	{
		'rmagatti/auto-session',
		opts = {
			pre_save_cmds = {
				function ()
					local nvim_tree = require('nvim-tree.api')
					nvim_tree.tree.close()
				end
			},
			post_save_cmds = {
				function ()
					local nvim_tree = require('nvim-tree.api')
					nvim_tree.tree.open({ path = vim.fn.getcwd() })
				end
			},
			cwd_change_handling = {
				post_cwd_changed_hook = function()
					local nvim_tree = require('nvim-tree.api')
					nvim_tree.tree.open({ path = vim.fn.getcwd() })
				end
			},
		},
	},
	"williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
})

require('nvim-treesitter.configs').setup({
	highlight = {
		enable = true,
		disable = { "c", "rust" },
	},
})

-- setup cmp
local cmp = require('cmp')
cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
			-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
			-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
		end,
	},
	window = {
		-- completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'nvim_lsp_signature_help' },
		{ name = 'vsnip' }, -- For vsnip users.
		-- { name = 'luasnip' }, -- For luasnip users.
		-- { name = 'ultisnips' }, -- For ultisnips users.
		-- { name = 'snippy' }, -- For snippy users.
	}, {
		{ name = 'buffer' },
	})
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
	sources = cmp.config.sources({
		{ name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
	}, {
		{ name = 'buffer' },
	})
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	})
})

-- Setup LSPs
local lspconfig = require("lspconfig")
lspconfig.gopls.setup({
	settings = {
        gopls = {
            env = {
                GOFLAGS = "-tags=integration"
            }
        }
    }
})
lspconfig.lua_ls.setup({
	settings = {
		Lua = {
			diagnostics = {
				globals = { 'vim' }
			}
		}
	}
})
lspconfig.bashls.setup({})
lspconfig.jsonls.setup({})
local schemastore = require('schemastore')
lspconfig.yamlls.setup({
	settings = {
		schemaStore = {
        	-- You must disable built-in schemaStore support if you want to use
        	-- this plugin and its advanced options like `ignore`.
        	enable = false,
        	-- Avoid TypeError: Cannot read properties of undefined (reading 'length')
        	url = "",
      	},
      	schemas = schemastore.yaml.schemas({
			select = {
				'Helm Chart.yaml',
				'Helm Chart.lock',
				'GitHub Action',
				'GitHub Workflow',
				'GitHub Workflow Template Properties',
			},
		}),
		validate = { enable = true },
	}
})
lspconfig.dockerls.setup({})
lspconfig.terraformls.setup({})

-- Setup DAP
require('dap-go').setup()

-- Setup auto format for terraform files
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = {"*.tf", "*.tfvars"},
	callback = function ()
		 vim.lsp.buf.format()
	end
})
-- Run gofmt + goimport on save
local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.go",
	callback = function()
		require('go.format').goimport()
	end,
	group = format_sync_grp,
})

-- Set formatter for json files
vim.api.nvim_create_autocmd("FileType", {
	pattern = "json",
	command = "setlocal formatprg=jq",
})

-- Setup telescope
local builtin = require("telescope.builtin")

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
require("mason").setup()
require("mason-lspconfig").setup()

vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }

		-- Make the windows bordered
		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
			vim.lsp.handlers.hover, {
				border = "rounded",
			}
		)
		vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
			vim.lsp.handlers.signature_help, {
				border = "rounded",
				close_events = { "CursorMoved", "BufHidden" },
			}
		)
		-- Key mappings
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
		vim.keymap.set({ 'n', 'i' }, '<C-k>', vim.lsp.buf.signature_help, opts)
		vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set('n', '<space>wl', function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
		vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
		vim.keymap.set('n', '<space>f', function()
			vim.lsp.buf.format { async = true }
		end, opts)
		vim.keymap.set('n', '<leader>im', [[<cmd>lua require'telescope'.extensions.goimpl.goimpl{}<CR>]],
			{ noremap = true, silent = true })

		vim.keymap.set("n", "gr", builtin.lsp_references, {})
		vim.keymap.set("n", "gi", builtin.lsp_implementations, {})
		vim.keymap.set('n', '<space>D', builtin.lsp_type_definitions, opts)
		vim.keymap.set("n", "gd", builtin.lsp_definitions, {})
		vim.keymap.set("n", "<leader>fd", builtin.lsp_document_symbols, {})
		vim.keymap.set("n", "<leader>fw", builtin.lsp_dynamic_workspace_symbols, {})
		vim.keymap.set("n", "<space>d", builtin.diagnostics, {})

		-- Go specific mappings
		local goiferr = require("go.iferr")
		local goreftool = require('go.reftool')
		vim.keymap.set('n', '<leader>ie', goiferr.run, {})
		vim.keymap.set('n', '<leader>is', goreftool.fillstruct, {})
	end,
})

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fi', builtin.grep_string, {})
vim.keymap.set('n', '<leader>fr', builtin.resume, {})

require('litee.lib').setup()
require('litee.gh').setup()

-- setup UFO
vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

require('ufo').setup({
    provider_selector = function(bufnr, filetype, buftype)
		if filetype == "rust" then
			return {'lsp', 'indent'}
		end
        return {'treesitter', 'indent'}
    end
})

-- setup neorg
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  pattern = {"*.norg"},
  command = "set conceallevel=3"
})
-- empty setup using defaults
vim.keymap.set({'n', 'v'}, '<leader><Tab>', "[[<cmd>NvimTreeToggle<CR>]]")

require('lualine').setup({
	options = {
		component_separators = '',
		section_separators = '',
	},
	sections = {
		lualine_a = {'mode'},
		lualine_b = {
			{
				'filetype',
				icon_only = true,
			},
			{
				'filename',
				path = 1,
				symbols = {
					modified = '󰙏',
				},
			},
		},
		lualine_c = {
			{
				'branch',
				icon = '',
			},
			'diagnostics',
		},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {'location'},
	},
})

local mocha = require("catppuccin.palettes").get_palette "mocha"
-- Setup bufferline
local bufferline = require("bufferline")
bufferline.setup {
    highlights = require("catppuccin.groups.integrations.bufferline").get {
        styles = { "italic", "bold" },
        custom = {
            all = {
                fill = { bg = "#000000" },
            },
            mocha = {
                background = { fg = mocha.text },
            },
        },
    },
}
vim.keymap.set('n', '[b', function()
	bufferline.cycle(-1)
end)
vim.keymap.set('n', ']b', function()
	bufferline.cycle(1)
end)
vim.keymap.set('n', '[mb', function()
	bufferline.move_to(1)
end)
vim.keymap.set('n', ']mb', function()
	bufferline.move_to(-1)
end)

vim.api.nvim_set_hl(0, "NvimTreeStatusLine", { bg = mocha.base })
vim.api.nvim_set_hl(0, "NvimTreeStatuslineNc", { fg = mocha.base, bg = mocha.base })

-- Setup mappings
vim.keymap.set({'n', 'v'}, '<C-Up>', '<C-U>')
vim.keymap.set({'n', 'v'}, '<C-Down>', '<C-D>')
vim.keymap.set({'n', 'v'}, '<C-Right>', 'w')
vim.keymap.set({'n', 'v'}, '<C-Left>', 'b')
vim.keymap.set({'n', 'v'}, '<C-S-Right>', 'W')
vim.keymap.set({'n', 'v'}, '<C-S-Left>', 'B')
vim.keymap.set({'n', 'v'}, '<Home>', '^')
vim.keymap.set({'n', 'v'}, '<leader>p', '"0p')
vim.keymap.set({'n', 'v'}, '<leader>P', '"0P')

-- DAP mappings
vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F12>', function() require('dap').step_into() end)
vim.keymap.set('n', '<C-F12>', function() require('dap').step_out() end)
vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
	require('dap.ui.widgets').hover()
end)
vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function()
	require('dap.ui.widgets').preview()
end)
vim.keymap.set('n', '<Leader>df', function()
	local widgets = require('dap.ui.widgets')
	widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<Leader>ds', function()
	local widgets = require('dap.ui.widgets')
	widgets.centered_float(widgets.scopes)
end)

-- which-key registrations
local wk = require('which-key')
wk.register({
	b = "toggle breakpoint",
	B = "set breakpoint",
	d = {
		r = "open repl",
		l = "run last",
		h = "dap hover",
		p = "dap preview",
		f = "dap frames",
		s = "dap scopes",
	},
	f = {
		f = "find files",
		g = "find grep",
		b = "buffers",
		h = "help tags",
		i = "grep word",
		r = "resume telescope",
		d = "document symbols",
		w = "workspace symbols",
	},
	i = {
		e = "Go: iferr",
		s = "Go: fill struct",
	},
}, { prefix = '<leader>'})
wk.register({
	[']'] = {
		b = "next buffer in tabline",
		d = "next diagnostic",
	},
	['['] = {
		b = "prev buffer in tabline",
		d = "prev diagnostic",
	},
	['<space>'] = {
		f = "format buffer",
		e = "open floating diagnostic",
		q = "set location list",
		D = "type definition",
		d = "workspace diagnostics",
		r = {
			n = "rename",
		},
		w = {
			a = "add workspace folder",
			r = "remove workspace folder",
			l = "list workspace folders",
		}
	}
})

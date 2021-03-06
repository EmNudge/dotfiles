
require'packer'.startup(function(use)
    use 'wbthomason/packer.nvim'
    -- colorscheme
    use {
	'EdenEast/nightfox.nvim',
	config = function() vim.cmd 'colorscheme nightfox' end,
    }

    -- lsp
    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'
    -- completions
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/nvim-cmp'
    -- adds symbols to nvm-cmp
    use 'onsails/lspkind.nvim'

    -- git integration
    use {
	'lewis6991/gitsigns.nvim',
	config = function() require'gitsigns'.setup() end,
    }

    -- treesitter
    use 'nvim-treesitter/nvim-treesitter'
    -- NOTE: is this needed?
    use 'nvim-treesitter/nvim-treesitter-refactor'

    -- git UI inside nvim
    use 'kdheepak/lazygit.nvim'

    -- file menu
    use {
	'kyazdani42/nvim-tree.lua',
	requires = 'kyazdani42/nvim-web-devicons',
	config = function() require'nvim-tree'.setup {
	    view = {
		hide_root_folder = true,
	    }
	} end,
    }

    use {
	'folke/trouble.nvim',
	requires = 'kyazdani42/nvim-web-devicons',
	config = function() require'trouble'.setup() end,
    }

    -- indentation markers (vertical lines)
    use {
	'lukas-reineke/indent-blankline.nvim',
	config = function()
	    vim.opt.list = true
	    vim.opt.listchars:append('space:⋅')

	    require'indent_blankline'.setup {
		show_end_of_line = true,
		space_char_blankline = ' ',
	    }
	end,
    }

    -- telescope general purpose finder
    use {
	'nvim-telescope/telescope.nvim',
	requires = {
	    'nvim-lua/popup.nvim',
	    'nvim-lua/plenary.nvim'
	},
	config = function() require'telescope'.setup() end,
    }

    use {
	'nvim-telescope/telescope-fzf-native.nvim',
	run = 'make'
    }

    -- prettify code
    use 'sbdchd/neoformat'

    -- terminal in vim
    use {
	'akinsho/toggleterm.nvim',
	tag = 'v2.*',
	config = function() require'toggleterm'.setup() end,
    }

    -- tabs
    use {
	'akinsho/bufferline.nvim',
	tag = 'v2.*',
	requires = 'kyazdani42/nvim-web-devicons',
	config = function() require'bufferline'.setup {
	    options = {
		offsets = {
		    {
			filetype = "NvimTree",
			text = function()
			    return vim.fn.getcwd():gsub(os.getenv('HOME'), '~')
			end,
			highlight = "directory",
			text_align = "left"
		    },
		},
	    }
	} end,
    }

    -- closing tabs (tiny bit cleaner)
    use 'ojroques/nvim-bufdel'

    -- statusline
    use {
	'hoob3rt/lualine.nvim',
	requires = {
	    'kyazdani42/nvim-web-devicons',
	    opt = true
	},
	config = function() require'lualine'.setup {
	    options = {
		globalstatus = true
	    }
	} end,
    }

    -- language support for svelte
    use 'evanleck/vim-svelte'

    -- display/menu for nvim command by itself
    use 'glepnir/dashboard-nvim'

    -- comment lines more easily
    use {
	'terrortylor/nvim-comment',
	config = function() require'nvim_comment'.setup() end,
    }

    use 'mg979/vim-visual-multi'

    use {
	'folke/which-key.nvim',
	config = function() require'which-key'.setup {} end,
    }
end)

local compileGroup = vim.api.nvim_create_augroup('AutoCompile', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
    group = compileGroup,
    pattern = 'plugins.lua',
    command = 'source <afile> | PackerCompile',
})

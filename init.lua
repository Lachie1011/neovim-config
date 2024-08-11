local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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

-- Vim tabbing
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Installing plugins
require("lazy").setup({
    {
		'nvim-telescope/telescope.nvim', tag = '0.1.6',
         dependencies = { 
			'nvim-lua/plenary.nvim' 
		}
    },
    {
		"nvim-neo-tree/neo-tree.nvim", branch = "v3.x",
    	dependencies = {
      	    "nvim-lua/plenary.nvim",
      	    "MunifTanjim/nui.nvim",
        },
		filesystem = {
			filtered_items = {
			hide_dotfiles = false,
			hide_gitignored = false
			}
		}
    },
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function () 
		  local configs = require("nvim-treesitter.configs")
	
		  configs.setup({
			  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html", "python" },
			  sync_install = false,
			  highlight = { enable = true },
			  indent = { enable = true },  
			})
		end
	},
    { 
		"catppuccin/nvim", 
		name = "catppuccin",
		priority = 1000,
		integrations = {
			nvimtree = true,
			telescope = true
		},
		opts = {
			flavour = "mocha", 
		}
    }
})

-- Setting up keybindings
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

vim.keymap.set('n', '<leader>n', '<Cmd>Neotree toggle<CR>')

-- Setting colourscheme
vim.cmd.colorscheme "catppuccin"

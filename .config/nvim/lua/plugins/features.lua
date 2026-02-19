return {
	{
		"lambdalisue/suda.vim",
		config = function()
			vim.api.nvim_create_user_command("W", "SudaWrite", {})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = {
					"cpp",
					"css",
					"cmake",
					"python",
					"dockerfile",
					"bash",
					"yaml",
					"go",
					"gosum",
					"gomod",
					"c",
					"lua",
					"vim",
					"query",
					"hyprlang",
					"jq",
					"make",
					"toml",
					"tmux",
					"markdown_inline",
					"rust",
					"ssh_config",
					"sql",
					"strace",
					"diff",
					"csv",
					"git_config",
					"gitcommit",
					"gitignore",
					"git_rebase",
					"json",
				},

				-- Install parsers synchronously (only applied to `ensure_installed`)
				sync_install = false,

				-- Automatically install missing parsers when entering buffer
				-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
				auto_install = true,

				-- List of parsers to ignore installing (or "all")

				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	---@type LazySpec
	{
		"mikavilpas/yazi.nvim",
		event = "VeryLazy",
		dependencies = {
			"folke/snacks.nvim",
		},
		keys = {
			{
				"<leader>e",
				mode = { "n", "v" },
				"<cmd>Yazi<cr>",
				desc = "Open yazi at the current file",
			},
			{
				-- Open in the current working directory
				"<leader>cw",
				"<cmd>Yazi cwd<cr>",
				desc = "Open the file manager in nvim's working directory",
			},
			{
				"<c-up>",
				"<cmd>Yazi toggle<cr>",
				desc = "Resume the last yazi session",
			},
		},
		---@type YaziConfig | {}
		opts = {
			-- if you want to open yazi instead of netrw, see below for more info
			open_for_directories = false,
			keymaps = {
				show_help = "<f1>",
			},
		},
		-- 👇 if you use `open_for_directories=true`, this is recommended
		init = function()
			-- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
			-- vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1
		end,
	},
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			indent = { enabled = true },
			scroll = { enabled = true },
			quickfile = { enabled = true },
			bigfile = { enabled = true },
			dim = { enabled = true },
			toggle = { enabled = true },
			words = { enabled = true },
			lazygit = { enabled = true },
		},
		keys = {
			{
				"<leader>sc",
				function()
					Snacks.picker.colorschemes()
				end,
				desc = "Colorschemes",
			},
			{
				"]]",
				function()
					Snacks.words.jump(vim.v.count1)
				end,
				desc = "Next Reference",
				mode = { "n", "t" },
			},
			{
				"[[",
				function()
					Snacks.words.jump(-vim.v.count1)
				end,
				desc = "Prev Reference",
				mode = { "n", "t" },
			},
			{
				"<leader>lg",
				function()
					Snacks.lazygit()
				end,
				desc = "Lazygit",
			},
		},
		init = function()
			vim.api.nvim_create_autocmd("User", {
				pattern = "VeryLazy",
				callback = function()
					-- Setup some globals for debugging (lazy-loaded)
					_G.dd = function(...)
						Snacks.debug.inspect(...)
					end
					_G.bt = function()
						Snacks.debug.backtrace()
					end
					vim.print = _G.dd -- Override print to use snacks for `:=` command

					-- Create some toggle mappings
					Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
					Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
					Snacks.toggle.diagnostics():map("<leader>ud")
					Snacks.toggle.inlay_hints():map("<leader>uh")
					Snacks.toggle.indent():map("<leader>ug")
					Snacks.toggle.dim():map("<leader>sd")
				end,
			})
		end,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({
				defaults = {
					mappings = {
						i = {
							["<C-j>"] = "move_selection_next",
							["<C-k>"] = "move_selection_previous",
						},
					},
				},
			})
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
			vim.keymap.set("n", "<leader>fw", builtin.grep_string, {})
			vim.keymap.set("n", "<leader>/", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
			vim.keymap.set("n", "<leader>of", builtin.oldfiles, {})
			vim.keymap.set("n", "<leader>cs", builtin.colorscheme, {})
			vim.keymap.set("n", "<leader>qf", builtin.quickfix, {})
			vim.keymap.set("n", "<leader>km", builtin.keymaps, {})
			vim.keymap.set("n", "<leader>di", builtin.diagnostics, {})
			vim.keymap.set("n", "<leader>sh", builtin.search_history, {})
			vim.keymap.set("n", "<leader>mp", builtin.man_pages, {})
			vim.keymap.set("n", "<leader>ft", builtin.filetypes, {})
			vim.keymap.set("n", "<leader>ts", builtin.treesitter, {})
			vim.keymap.set("n", "<leader>pl", builtin.planets, {})
			vim.keymap.set("n", "<leader>bi", builtin.builtin, {})
			vim.keymap.set("n", "<leader>re", builtin.reloader, {})
		end,
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local harpoon = require("harpoon")

			-- REQUIRED
			harpoon:setup()
			-- REQUIRED

			vim.keymap.set({ "n", "v" }, "<leader>a", function()
				harpoon:list():add()
			end)
			vim.keymap.set({ "n", "v" }, "<leader>ha", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end)

			vim.keymap.set({ "n", "v" }, "<leader>1", function()
				harpoon:list():select(1)
			end)
			vim.keymap.set({ "n", "v" }, "<leader>2", function()
				harpoon:list():select(2)
			end)
			vim.keymap.set({ "n", "v" }, "<leader>3", function()
				harpoon:list():select(3)
			end)
			vim.keymap.set({ "n", "v" }, "<leader>4", function()
				harpoon:list():select(4)
			end)

			-- Toggle previous & next buffers stored within Harpoon list
			vim.keymap.set({ "n", "v" }, "<leader>j", function()
				harpoon:list():prev()
			end)
			vim.keymap.set({ "n", "v" }, "<leader>k", function()
				harpoon:list():next()
			end)

			vim.cmd("highlight! HarpoonInactive guibg=NONE guifg=#63698c")
			vim.cmd("highlight! HarpoonActive guibg=NONE guifg=white")
			vim.cmd("highlight! HarpoonNumberActive guibg=NONE guifg=#7aa2f7")
			vim.cmd("highlight! HarpoonNumberInactive guibg=NONE guifg=#7aa2f7")
			vim.cmd("highlight! TabLineFill guibg=NONE guifg=white")
		end,
	},
	{
		"jasonpanosso/harpoon-tabline.nvim",
		dependencies = { "ThePrimeagen/harpoon" },
		config = function()
			require("harpoon-tabline"):setup()
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	{
		"kndndrj/nvim-dbee",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		build = function()
			-- Install tries to automatically detect the install method.
			-- if it fails, try calling it with one of these parameters:
			--    "curl", "wget", "bitsadmin", "go"
			require("dbee").install()
		end,
		config = function()
			require("dbee").setup(vim.keymap.set("n", "<leader>db", "<cmd>Dbee<CR>", { noremap = true, silent = true }))
		end,
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {},
        -- stylua: ignore
        keys = {
            { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
            { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
            { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
            { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
        },
	},
	{
		"zk-org/zk-nvim",
		config = function()
			require("zk").setup({
				-- Can be "telescope", "fzf", "fzf_lua", "minipick", "snacks_picker",
				-- or select" (`vim.ui.select`).
				picker = "telescope",

				lsp = {
					-- `config` is passed to `vim.lsp.start(config)`
					config = {
						name = "zk",
						cmd = { "zk", "lsp" },
						filetypes = { "markdown" },
						-- on_attach = ...
						-- etc, see `:h vim.lsp.start()`
					},

					-- automatically attach buffers in a zk notebook that match the given filetypes
					auto_attach = {
						enabled = true,
					},
				},
			})
			local opts = { noremap = true, silent = false }

			-- Create a new note after asking for its title.
			vim.api.nvim_set_keymap("n", "<leader>zn", "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", opts)

			-- Open notes.
			vim.api.nvim_set_keymap("n", "<leader>zo", "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", opts)
			-- Open notes associated with the selected tags.
			vim.api.nvim_set_keymap("n", "<leader>zt", "<Cmd>ZkTags<CR>", opts)

			-- Search for the notes matching a given query.
			vim.api.nvim_set_keymap(
				"n",
				"<leader>zf",
				"<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>",
				opts
			)
			-- Search for the notes matching the current visual selection.
			vim.api.nvim_set_keymap("v", "<leader>zf", ":'<,'>ZkMatch<CR>", opts)
			vim.api.nvim_set_keymap("n", "<leader>zl", ":ZkInsertLink<CR>", opts)
		end,
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" }, -- if you use the mini.nvim suite
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' }, -- if you use standalone mini plugins
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {},
		config = function()
			require("render-markdown").setup({
				render_modes = true,
				completions = { lsp = { enabled = true } },
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = {},
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
					rust = { "rustfmt", lsp_format = "fallback" },
					javascript = { "prettierd", "prettier", stop_after_first = true },
					go = { "goimports", "gofumpt" },
				},
				format_on_save = {
					-- These options will be passed to conform.format()
					timeout_ms = 500,
					lsp_format = "fallback",
				},
			})
			vim.keymap.set("n", "gq", function()
				require("conform").format()
			end)
		end,
	},
	{
		"mfussenegger/nvim-lint",
		opts = {},
		config = function()
			require("lint").linters_by_ft = {
				python = { "ruff" },
				go = { "golangci_lint" },
			}
			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},
}

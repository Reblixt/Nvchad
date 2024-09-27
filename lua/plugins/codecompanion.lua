return {
	"olimorris/codecompanion.nvim",
	-- enabled = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"hrsh7th/nvim-cmp", -- Optional: For using slash commands and variables in the chat buffer
		"nvim-telescope/telescope.nvim", -- Optional: For using slash commands
		{ "stevearc/dressing.nvim", opts = {} }, -- Optional: Improves the default Neovim UI
	},
	event = "BufRead",
	-- opts = {
	-- 	strategies = {
	-- 		chat = {
	-- 			adapter = "copilot",
	-- 		},
	-- 	},
	-- },
	config = function()
		require("codecompanion").setup({
			strategies = {
				chat = {
					adapter = "ollama",
				},
				inline = {
					adapter = "ollama",
				},
				agent = {
					adapter = "ollama",
				},
			},
			adapters = {
				deepseek = function()
					return require("codecompanion.adapters").extend("ollama", {
						name = "deepseek", -- Give this adapter a different name to differentiate it from the default ollama adapter
						schema = {
							model = {
								-- default = "llama3.1:8b",
								default = "deepseek-coder-v2:16b",
								-- default = "qwen2.5:14b",
							},
							num_ctx = {
								default = 16384,
							},
							num_predict = {
								default = -1,
							},
						},
					})
				end,
				--     				qwen = function()
				-- 	return require("codecompanion.adapters").extend("ollama", {
				-- 		name = "qwen", -- Give this adapter a different name to differentiate it from the default ollama adapter
				-- 		schema = {
				-- 			model = {
				-- 				-- default = "llama3.1:8b",
				-- 				-- default = "deepseek-coder-v2:16b",
				-- 				default = "qwen2.5:14b",
				-- 			},
				-- 			num_ctx = {
				-- 				default = 16384,
				-- 			},
				-- 			num_predict = {
				-- 				default = -1,
				-- 			},
				-- 		},
				-- 	})
				-- end,
			},
		})
	end,
	vim.api.nvim_set_keymap("n", "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true }),
	vim.api.nvim_set_keymap("v", "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true }),
	vim.api.nvim_set_keymap("n", "<leader>a", "<cmd>CodeCompanionChat<cr>", { noremap = true, silent = true }),
	vim.api.nvim_set_keymap(
		"v",
		"<leader>a",
		"<cmd>CodeCompanionAdd<cr> <cmd>CodeCompanionChat<cr>",
		{ noremap = true, silent = true, desc = "Add selection to CodeCompanion" }
	),
	vim.api.nvim_set_keymap("v", "ga", "<cmd>CodeCompanionAdd<cr>", { noremap = true, silent = true }),

	-- Expand 'cc' into 'CodeCompanion' in the command line
	vim.cmd([[cab cc CodeCompanion]]),
	-- config = true,
}
return function(mappings)
	mappings()
	require("telescope").setup({
		pickers = {
			find_files = {
				hidden = true,
			},
		},
		defaults = {
			border = true,
			borderchars = {
				results = { " ", " ", " ", " ", " ", " ", " ", " " },
				prompt = { " ", " ", " ", " ", " ", " ", " ", " " },
				preview = { " ", " ", " ", " ", " ", " ", " ", " " },
			},
			layout_strategy = "vertical",
			layout_config = {
				preview_cutoff = 0,
				height = 999,
				width = 999,
			},
			mappings = {
				i = {
					["<esc>"] = require("telescope.actions").close,
					["<c-q>"] = require("telescope.actions").close,
				},
			},
		},
	})
end

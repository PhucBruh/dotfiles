require("yatline"):setup({
	header_line = {},

	theme = {
		section_separator = {
			open = "",
			close = "",
		},
		inverse_separator = {
			open = "",
			close = "",
		},
		part_separator = {
			open = "",
			close = "",
		},
		style_a = {
			fg = "#16181a",
			bg_mode = {
				normal = "#5ef1ff", -- MiniStatuslineModeNormal
				select = "#ff5ef1", -- Visual
				un_set = "#5ea1ff", -- Other
			},
		},

		style_b = {
			fg = "#ffffff",
			bg = "#253547", -- CursorLine
		},

		style_c = {
			fg = "#7b8496",
			bg = "#16181a", -- Normal
		},

		permissions_t_fg = "#5ea1ff",
		permissions_r_fg = "#f1ff5e",
		permissions_w_fg = "#ff6e5e",
		permissions_x_fg = "#5eff6c",
		permissions_s_fg = "#ffffff",

		selected = { icon = "󰻭", fg = "#f1ff5e" },
		copied = { icon = "", fg = "#5eff6c" },
		cut = { icon = "", fg = "#ff6e5e" },

		files = { icon = "", fg = "#5ea1ff" },
		filtereds = { icon = "", fg = "#bd5eff" },

		total = { icon = "󰮍", fg = "#f1ff5e" },
		success = { icon = "", fg = "#5eff6c" },
		failed = { icon = "", fg = "#ff6e5e" },
	},
})

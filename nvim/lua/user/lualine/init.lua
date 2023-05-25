local status, lualine = pcall(require, "lualine")
if not status then
	return
end

local cpn = require("user.lualine.components")
local config = require("user.lualine.config")

local function setup()
  local theme = require("user.lualine.highlights").custom(config.options)
	lualine.setup({
		options = {
			theme = theme,
			icons_enabled = true,
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			disabled_filetypes = {
				statusline = { "dashboard", "lazy", "alpha" },
			},
			ignore_focus = {},
			always_divide_middle = true,
			globalstatus = true,
			refresh = {
				statusline = 1000,
				tabline = 1000,
				-- winbar = 100,
			},
		},
		sections = {
			lualine_a = { cpn.branch },
			lualine_b = { cpn.diagnostics },
			lualine_c = {},
			lualine_x = { cpn.diff },
			lualine_y = { cpn.position, cpn.filetype },
			lualine_z = { cpn.spaces, cpn.mode },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { "filename" },
			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
		},
		tabline = {},
		extensions = {},
	})
end

config.setup()
setup()

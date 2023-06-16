local M = {
	"goolord/alpha-nvim",
	event = "VimEnter",
	dependencies = { "nvim-tree/nvim-web-devicons" },
}

function M.config()
	local status_ok, alpha = pcall(require, "alpha")
	if not status_ok then
		return
	end

	local dashboard = require("alpha.themes.dashboard")

	dashboard.section.header.val = {
		-- [[    _   ___      __        _    ________  ___]],
		-- [[   / | / (_)____/ /____  _| |  / /  _/  |/  /]],
		-- [[  /  |/ / / ___/ //_/ / / / | / // // /|_/ / ]],
		-- [[ / /|  / / /__/ ,< / /_/ /| |/ // // /  / /  ]],
		-- [[/_/ |_/_/\___/_/|_|\__, / |___/___/_/  /_/   ]],
		-- [[                  /____/                     ]],
		[[  _   _ _      _        __     _____ __  __ ]],
		[[ | \ | (_) ___| | ___   \ \   / /_ _|  \/  |]],
		[[ |  \| | |/ __| |/ / | | \ \ / / | || |\/| |]],
		[[ | |\  | | (__|   <| |_| |\ V /  | || |  | |]],
		[[ |_| \_|_|\___|_|\_\\__, | \_/  |___|_|  |_|]],
		[[                    |___/                   ]],
	}

	dashboard.section.buttons.val = {
		dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
		dashboard.button("e", " " .. " New file", ":ene <BAR> startinsert <CR>"),
		dashboard.button("r", "󰄉 " .. " Recent files", ":Telescope oldfiles <CR>"),
		dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
		dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
		dashboard.button("q", " " .. " Quit", ":qa<CR>"),
	}

	dashboard.section.footer.val = "@NMeuleman"

	alpha.setup(dashboard.opts)
end

return M

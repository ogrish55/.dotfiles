return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = function(_, opts)
		return {
			defaults = {
				fzf_colors = true,
				file_icons = true,
				winopts = {
					width = 0.8,
					height = 0.8,
					preview = {
						vertical = "down:65%",
						hidden = false,
						layout = "vertical",
						delay = 5,
						winopts = { number = false },
					},
				},
			},
			keymap = {
				builtin = {
					true,
					["<Esc>"] = "hide",
				},
				fzf = {
					true,
					["ctrl-q"] = "select-all+accept",
					-- ["ctrl-d"] = "half-page-down",
					-- ["ctrl-u"] = "half-page-up",
				},
			},
			fzf_opts = {
				["--margin"] = "0,0",
				["--layout"] = "reverse",
				["--cycle"] = true,
			},
			oldfiles = {
				formatter = { "path.filename_first", 2 }, -- enables pasting whole file paths
				cwd_only = true,
				stat_file = true,
				fzf_opts = {
					["--exact"] = true,
				},
			},
			files = {
				formatter = { "path.filename_first", 2 }, -- enables pasting whole file paths
				hls = {
					file_part = "Directory",
				},
				fzf_opts = {
					["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-files-history",
					["--exact"] = true,
				},
				-- actions = {
				-- 	["ctrl-q"] = actions.file_sel_to_qf,
				-- },
			},
			buffers = {
				sort_lastused = true,
				cwd_only = true,
				formatter = "path.filename_first",
				fzf_opts = {
					["--exact"] = true,
					-- ["--with-nth"] = "3", -- Only show filename
					["--with-nth"] = "3..", -- Show filename and path
				},
			},
			grep = {
				-- debug = true,
				fzf_opts = {
					["--exact"] = true,
					["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-grep-history",
				},
				-- rg_opts = "-uu --column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e -F",
				rg_opts = table.concat({
					"-uu ",
					"--hidden ",
					"--column ",
					"--line-number ",
					"--no-heading ",
					"--color=always ",
					"--smart-case ",
					"--max-columns=4096 ",
					"-e ",
					"-F ",
					"-g !dev/ ",
					"-g !vendor/**/tests/ ",
					"-g !vendor/composer/ ",
					"-g !sync/ ",
					"-g !lib/ ",
					"-g !.idea/ ",
					"-g !setup/ ",
					"-g !.wexo/app/ ",
					"-g !.wexo/**/*.sql ",
					"-g !.wexo/restore/ ",
					"-g !.wexo/.local/ ",
					"-g !generated/ ",
					"-g !pub/ ",
					"-g !var/ ",
					"-g !logs/ ",
					"-g !CHANGELOG.md ",
					"-g !node_modules/ ",
					"-g !dist/ ",
					"-g !.git/ ",
					"-g !public/ ",
					"-g !yarn.lock ",
					"-g !composer.lock ",
				}),
				-- actions = {
				-- 	["ctrl-h"] = {
				-- 		fn = function(_, opts)
				-- 			actions.toggle_flag(
				-- 				_,
				-- 				vim.tbl_extend("force", opts, {
				-- 					toggle_flag = table.concat({
				-- 						"-u",
				-- 					}),
				-- 				})
				-- 			)
				-- 		end,
				-- 		desc = "toggle flags",
				-- 		header = function(o)
				-- 			local flag = o.toggle_ignore_vendor_flag or "-u"
				-- 			local fzf = require("fzf-lua")
				-- 			if o.cmd and o.cmd:match(fzf.utils.lua_regex_escape(flag)) then
				-- 				return "Enable git ignore"
				-- 			else
				-- 				return "Disable git ignore"
				-- 			end
				-- 		end,
				-- 	},
				-- 	-- files = {
				-- 	-- 	true,
				-- 	-- 	["ctrl-q"] = actions.file_sel_to_qf,
				-- 	-- }
				-- 	-- :FzfLua live_grep hls.file_part=Error hls.dir_part=FzfLuaCursorLine
				-- 	-- actions inherit from 'actions.files' and merge
				-- 	-- this action toggles between 'grep' and 'live_grep'
				-- 	-- ["ctrl-g"] = { actions.grep_lgrep },
				-- 	-- uncomment to enable '.gitignore' toggle for grep
				-- 	-- ["ctrl-r"] = actions.toggle_ignore,
				-- },
			},
		}
	end,
}

return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function(_, opts)
		local actions = require("fzf-lua").actions
		local utils = require("fzf-lua").utils
		local path = require("fzf-lua").path
		local myFormatter = {
			enrich = function(o, v)
				o.fzf_opts = vim.tbl_extend("keep", o.fzf_opts or {}, { ["--tabstop"] = 1 })
				if tonumber(v) == 2 then
					o.fzf_opts = vim.tbl_extend("keep", o.fzf_opts or {}, {
						["--ellipsis"] = " ",
						["--no-hscroll"] = true,
					})
				end
				return o
			end,
			_to = function(o, v)
				local _, hl_dir = utils.ansi_from_hl(o.hls.dir_part, "foo")
				local _, hl_file = utils.ansi_from_hl(o.hls.file_part, "foo")
				local _, hl_ignore = utils.ansi_from_hl(o.hls.ignore, "foo")
				local v2 = tonumber(v) ~= 2 and "" or [[, "\xc2\xa0" .. string.rep(" ", 200) .. s]]
				return ([[
						return function(s, _, m)
							local _path, _utils = m.path, m.utils
							local _hl_dir = "%s"
							local _hl_file = "%s"
							local _hl_ignore = "%s"
							local tail = _path.tail(s)
							local parent = _path.parent(s)
							local ignore = false
							if s ~= nil and s ~= "" then
								if s:match("^dev") or s:match("^vendor") or s:match("^var") or s:match("^node_modules") or s:match("^generated") or s:match("^pub") then
									ignore = true
								end
							end
							if ignore then
								tail = _hl_ignore .. tail .. _utils.ansi_escseq.clear
							elseif #_hl_file > 0 then
								tail = _hl_file .. tail .. _utils.ansi_escseq.clear
							end
							if parent then
								parent = _path.remove_trailing(parent)
								if ignore then
									parent = _hl_ignore .. parent .. _utils.ansi_escseq.clear
								elseif #_hl_dir > 0 then
									parent = _hl_dir .. parent .. _utils.ansi_escseq.clear
								end
								return tail .. "\t" .. parent %s
							else
								return tail %s
							end
						end
					]]):format(hl_dir or "", hl_file or "", hl_ignore or "", v2, v2)
			end,
			from = function(s, _)
				s = s:gsub("\xc2\xa0     .*$", "")
				local parts = utils.strsplit(s, utils.nbsp)
				local last = parts[#parts]
				local filename, rest = last:match("^([^:]-)\t(.+)$")
				if filename and rest then
					local parent
					if utils.__IS_WINDOWS and path.is_absolute(rest) then
						parent = rest:sub(1, 2) .. (#rest > 2 and rest:sub(3):match("^[^:]+") or "")
					else
						parent = rest:match("^[^:]+")
					end
					local fullpath = path.join({ parent, filename })
					parts[#parts] = fullpath .. rest:sub(#parent + 1)
					return table.concat(parts, utils.nbsp)
				else
					return s
				end
			end,
		}

		require("fzf-lua").setup({
			formatters = {
				git = {
					gitignore = myFormatter,
				},
			},

			defaults = {
				hls = {
					-- file_part = "Directory",
					file_part = "BlinkCmpLabelMatch",
					dir_part = "BlinkCmpLabelMatch",
					ignore = "Comment",
				},
				fzf_colors = true,
				-- formatter = { myFormatter },
				formatter = { "git.gitignore", 2 },
				-- formatter = { "path.filename_first", 2 },
				file_icons = true,
				winopts = {
					width = 0.9,
					height = 0.85,
					preview = {
						vertical = "down:65%",
						hidden = false,
						layout = "horizontal",
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
				},
			},
			fzf_opts = {
				["--margin"] = "0,0",
				["--layout"] = "reverse",
				["--exact"] = true,
				["--cycle"] = true,
			},
			lsp = {
				async_or_timeout = true,
			},
			oldfiles = {
				cwd_only = true,
				stat_file = true,
			},
			files = {
				fd_opts = table.concat({
					"--color=never ",
					"--hidden ",
					"--type f ",
					"--type l ",
					"-E '.git' -E 'dev/' -E 'dev/**' -E 'vendor/**/tests/' -E 'vendor/**/Test/' ",
					"-E 'vendor/composer/' -E 'sync/' -E 'lib/' -E '.idea/' -E 'setup/' -E '.wexo/app/' ",
					"-E '.wexo/**/*.sql' -E '.wexo/restore/' -E '.wexo/.local/' -E 'generated/' -E 'pub/' ",
					"-E 'var/' -E 'logs/' -E 'CHANGELOG.md' -E 'node_modules/' -E 'dist/' -E 'public/' ",
					"-E 'yarn.lock' -E 'composer.lock' ",
				}),
				fzf_opts = {
					["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-files-history",
				},
			},
			buffers = {
				sort_lastused = true,
				cwd_only = true,
				fzf_opts = {
					["--with-nth"] = "3..",
				},
			},
			grep = {
				fzf_opts = {
					["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-grep-history",
				},
				rg_opts = table.concat({
					"-uu ",
					"--hidden --column --line-number --no-heading --color=always --smart-case --max-columns=4096 -F ",
					"-g !dev/ -g !dev/** -g !vendor/**/tests/ -g !vendor/**/Test/ -g !vendor/composer/ ",
					"-g !sync/ -g !lib/ -g !.idea/ -g !setup/ -g !.wexo/app/ -g !.wexo/**/*.sql ",
					"-g !.wexo/restore/ -g !.wexo/.local/ -g !generated/ -g !pub/ -g !var/ -g !logs/ ",
					"-g !CHANGELOG.md -g !node_modules/ -g !dist/ -g !.git/ -g !public/ -g !yarn.lock ",
					"-g !composer.lock ",
				}),
			},
			actions = {
				files = {
					true,
					["ctrl-g"] = actions.toggle_ignore,
				},
			},
		})
	end,
}

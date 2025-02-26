# 1:
    - add keymap to search using regular ripgrep (which ignores vendor etc.)
        - perhaps use <leader>sg, function() require("fzf-lua").live_grep({opts = {rg_opts = {}}}) end, {desc =  " [S]earch [G]it files"}
# 2:
    - add keymap for cmdline:
        - up and down for navigating. Keep ctrl -n and ctrl -p
# 3:
    - create a plugin to handle notes for each project
        - Should save an md file based on the cwd or the directory of the nearest .git file in the parent scope

# 4:
    tmux sessionizer in vim
        -- this is next priority.



-- det kan sgu godt være at cattpuchin skal bruges som tema i stedet..
    Gør sgu lidt nullernaller at kigge på i løbet af dagen..


Brug catppuccin i stedet of ændre lidt i fzf-lua highlight groups så vendor filer er mere skjulte
Få i øvrigt alminelige filer i git til at have en mere hvid farve..


Phpactor tilbyder ikke gode code-actions. Køb en licens til intelephense og undersøg hvad der kan bruges herfra.
Der er ikke autoudfyld af constructor når man extender en klasse der har sin egen constructor

-- mod-version:3
local syntax = require "core.syntax"

local function prepare_symbols(symtable)
	local symbols = { }
	for symtype, symlist in pairs(symtable) do
		for _, symname in ipairs(symlist) do
			symbols[symname] = symtype
		end
	end
	return symbols
end

syntax.add {
	name = "Nanorc",
	files = { "%.nanorc$" },
	comment = "#",
	patterns = {
		{ pattern = "[%a_][%w_]*",        type = "normal"  },
		{ pattern = "-?%d+[%d%.eE]*f?",   type = "number"  },
		{ pattern = "-?%.?%d+f?",         type = "number"  },
		{ pattern = { '"', '".-[\n%s]' }, type = "string"  },
		{ pattern = "#.-\n",              type = "comment" }
	},
	symbols = prepare_symbols({
		["keyword"] = {
			"bind", "set", "unset", "syntax", "header", "include", "magic",
			"start", "end", "color", "icolor", "comment", "afterends", "backup",
			"allow_insecure_backup", "atblanks", "autoindent", "backupdir",
			"boldtext", "brackets", "breaklonglines", "casesensitive",
			"constantshow", "cutfromcursor", "emptyline", "errorcolor",
			"fill", "functioncolor", "guidestripe", "historylog", "jumpyscrolling",
			"keycolor", "linenumbers", "locking", "matchbrackets", "morespace",
			"mouse", "multibuffer", "noconvert", "nohelp", "nonewlines", "nopauses",
			"nowrap", "numbercolor", "operatingdir", "positionlog", "preserve", "punct",
			"quickblank", "quotestr", "rawsequences", "rebinddelete", "regexp", "selectedcolor",
			"showcursor", "smarthome", "smooth", "softwrap", "speller", "statuscolor",
			"stripecolor", "suspend", "tabsize", "tabstospaces", "tempfile", "titlecolor",
			"trimblanks", "unix", "view", "whitespace", "wordbounds", "wordchars", "zap"
		},
		["keyword2"] = {
			"black", "red", "green", "yellow", "blue", "magenta", "cyan", "white", "normal",
			"brightblack", "brightred", "brightgreen", "brightyellow", "brightblue", "brightmagenta",
			"brightcyan", "brightwhite", "brightnormal"
		}
	})
}

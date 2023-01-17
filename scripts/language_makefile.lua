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
  name = "Makefile",
  files = { "Makefile", "makefile", "%.mk$" },
  comment = "#",
  patterns = {
    { pattern = "#.*\n",                  type = "comment"  },
    { pattern = [[\.]],                   type = "normal"   },
    { pattern = "$[@^<%%?+|*]",           type = "keyword"  },
    { pattern = "$%(.-",                  type = "keyword2" },
    { pattern = "%)",                     type = "keyword2" },
    { pattern = {"@%S[%w%W]", "%s"},      type = "keyword"  },
    { pattern = "[^%w%p]%d+",             type = "number"   },
    { pattern = "%..*:",                  type = "function" },
    { pattern = ".*:",                    type = "function" }
  },
	symbols = prepare_symbols({
		["keyword"] = {
			"ifeq", "else", "endif", "include",
			"subst", "wildcard", "lc", "patsubst", "strip", "findstring",
			"filter", "filter-out", "sort", "word", "wordlist", "words",
			"firstword", "lastword"
		}
	})
}

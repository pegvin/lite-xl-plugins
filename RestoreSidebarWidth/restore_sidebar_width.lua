-- mod-version:3
--[[
	Restore Sidebar Width
	  - Saves Sidebar's Width On Editor Quit
	  - Loads Sidebar's Width On Editor Open
	  - Plugin Saves The Width Here: $USERDIR/.treeview_width.lua

	Configuration
	  - To Enable The Plugin (by default it is enabled): `config.plugins.restore_sidebar_width = true`
]]

local core = require "core"
local config = require "core.config"
local treeview = require "plugins.treeview"
local configFile = USERDIR .. "/.treeview_width.lua"

config.plugins.restore_sidebar_width = true

if config.plugins.restore_sidebar_width then
	local function _SaveTreeViewWidth()
		local fp = io.open(configFile, "w")
		if fp then
			fp:write(string.format("TreeView_Width = %d\n", treeview.size.x))
			fp:close()
		end
	end

	local function file_exists(name)
		local f = io.open(name,"r")
		if f ~= nil then io.close(f) return true else return false end -- if file was opened successfully (which means it exists) close the file & return true else return false
	end

	if file_exists(configFile) then
		local config = {}
		local chunk, err = loadfile(configFile, 'bt', config)
		if not err then
			chunk()
			if config["TreeView_Width"] ~= nil then -- Check If The Table Contains The Key
				treeview:set_target_size("x", config["TreeView_Width"])
			end
		end
	else
		_SaveTreeViewWidth();
	end

	local _quit = core.quit
	local _restart = core.restart

	function core.quit()
		_SaveTreeViewWidth()
		_quit()
	end

	function core.restart()
		_SaveTreeViewWidth()
		_restart()
	end
end


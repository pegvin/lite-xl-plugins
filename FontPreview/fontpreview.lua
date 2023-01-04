-- mod-version:3
local core = require "core"
local Doc = require "core.doc"
local style = require "core.style"
local config = require "core.config"
local common = require "core.common"
local DocView = require "core.docview"

config.plugins.fontpreview = common.merge({
	enabled = false,
	editable = false,
	size = style["code_font"]:get_size(),
	default_text = { "The Quick Brown Fox Jumps Over The Lazy Dog!" }
}, config.plugins.fontpreview)

if config.plugins.fontpreview.enabled then
	function DocView:new(doc)
		DocView.super.new(self)
		self.cursor = "ibeam"
		self.scrollable = true
		self.doc = assert(doc)
		self.font = "code_font"
		self.last_x_offset = {}
		self.ime_selection = { from = 0, size = 0 }
		self.ime_status = false
		self.hovering_gutter = false
		self.v_scrollbar:set_forced_status(config.force_scrollbar_status)
		self.h_scrollbar:set_forced_status(config.force_scrollbar_status)

		local fname = doc["filename"]
		local abs_fname = doc["abs_filename"]
		if
			string.lower(string.sub(fname, -4)) == ".ttf" or
			string.lower(string.sub(fname, -4)) == ".otf"
		then
			style["__font_preview_for_" .. abs_fname] = renderer.font.load(abs_fname, config.plugins.fontpreview.size)
			self.font = "__font_preview_for_" .. abs_fname

			doc.lines = config.plugins.fontpreview.default_text
			doc:set_filename(fname, fname)

			if not config.plugins.fontpreview.editable then
				doc.text_input = function(text) end
				self.on_text_input = function(text) end
				doc.ime_text_editing = function(text, start, length) end
				self.on_ime_text_editing = function(text, start, length) end
			end
		end
	end
end

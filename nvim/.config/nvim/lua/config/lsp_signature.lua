-- lua/config/lsp_signature.lua
-- ray-x/lsp_signature.nvim setup.
-- Loaded via `require("config.lsp_signature")` from the plugin spec in init.lua.

local cfg = {
  debug = false, -- set to true to enable debug logging
  log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log", -- log dir when debug is on
  -- default is  ~/.cache/nvim/lsp_signature.log
  verbose = false, -- show debug line number

  bind = true, -- This is mandatory, otherwise border config won't get registered.
  -- If you want to hook lspsaga or other signature handler, set to false.
  doc_lines = 10, -- will show two lines of comment/doc (if there are more than two
  -- lines in doc, will be truncated); set to 0 if you DO NOT want any API
  -- comments to be shown. This setting only takes effect in insert mode, it
  -- does not affect signature help in normal mode. 10 by default.

  max_height = 12, -- max height of signature floating_window
  max_width = 80, -- max_width of signature floating_window
  noice = false, -- set to true if you're using noice to render markdown
  wrap = true, -- allow doc/signature text to wrap inside the floating window,
  -- useful if the returned doc/sig is too long

  floating_window = true, -- show hint in a floating window; set to false for
  -- virtual text only mode

  floating_window_above_cur_line = true, -- try to place the floating window
  -- above the current line when possible

  floating_window_off_x = 1, -- adjust float window's x position.
  -- can be either a number or a function
  floating_window_off_y = 0, -- adjust float window's y position.
  -- e.g. -2 moves the window up 2 lines; 2 moves it down 2 lines.
  -- can be either a number or a function, see examples

  close_timeout = 4000, -- close floating window after ms when the last parameter is entered
  fix_pos = false, -- if true, the floating window will not auto-close until all
  -- parameters are finished
  hint_enable = true, -- virtual hint enable
  hint_prefix = "🐼 ", -- Panda for parameter, NOTE: terminals without emoji
  -- support might crash
  hint_scheme = "String",
  hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlighted
  handler_opts = {
    border = "rounded", -- double, rounded, single, shadow, none, or a table of borders
  },

  always_trigger = false, -- sometimes showing signature on a new line or in
  -- the middle of a parameter can be confusing; set to false for #58

  auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil
  extra_trigger_chars = {}, -- extra characters that will trigger signature completion,
  -- e.g. { "(", "," }
  zindex = 200, -- by default it will be on top of all floating windows; set to <= 50
  -- to send it to the bottom

  padding = "", -- character to pad on left and right of signature; can be ' ', '|', etc.

  transparency = nil, -- disabled by default; allow floating win transparency, value 1~100
  shadow_blend = 36, -- if using shadow as border, use this to set the opacity
  shadow_guibg = "Black", -- if using shadow as border, use this to set the color,
  -- e.g. 'Green' or '#121315'
  timer_interval = 200, -- default timer check interval; set to a lower value if
  -- you want to reduce latency

  toggle_key = nil, -- toggle signature on and off in insert mode,
  -- e.g. toggle_key = '<M-x>'

  select_signature_key = nil, -- cycle to next signature, e.g. '<M-n>' for
  -- function overloading
  move_cursor_key = nil, -- imap; use nvim_set_current_win to move cursor between
  -- current win and floating window
}

require("lsp_signature").setup(cfg)

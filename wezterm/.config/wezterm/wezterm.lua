local wezterm = require 'wezterm'
local hostname = wezterm.hostname()

--- See https://wezfurlong.org/wezterm/config/lua/wezterm/hostname.html
local font_size 
if hostname == 'yemen' then 
    font_size = 11.0
else 
    font_size = 10.5
end

return {
    font_size = font_size,
    -- -> => ==>
    font = wezterm.font_with_fallback(
        {
            'JetBrains Mono',
            'Noto Color Emoji', 
            'JetBrainsMono Nerd Font',
            'Symbols Nerd Font Mono'
        }
    ),
    color_scheme = "Gruvbox dark, pale (base16)",
    hide_tab_bar_if_only_one_tab = true, 
}

--  vim: set ts=4 sw=4 tw=88 et :

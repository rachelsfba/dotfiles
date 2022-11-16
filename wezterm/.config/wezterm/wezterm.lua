local wezterm = require 'wezterm'

return {
    font_size = 10.5,
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

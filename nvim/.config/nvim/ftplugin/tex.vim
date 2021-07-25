" use LaTeX by default
let g:tex_flavor = "latex"

" per https://github.com/lervag/vimtex/wiki/introduction#neovim
let g:vimtex_compiler_progname = 'nvr'

" use zathura as PDF viewer (evince/FoxitReader might be system default)
let g:latex_view_general_viewer = 'zathura'
let g:vimtex_view_method='zathura'

" TeX characters concealing
let g:tex_conceal=''

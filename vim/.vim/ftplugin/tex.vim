" I like my sums and limits to have placeholders
let g:Tex_Com_sum = "\\sum\\limits\_{<++>}\^{<++>}<++>"
let g:Tex_Com_cap = "\\bigcap\\limits\_{<++>}\^{<++>}<++>"
let g:Tex_Com_cup = "\\bigcup\\limits\_{<++>}\^{<++>}<++>"
let g:Tex_Com_lim = "\\lim\\limits\_{<++>}\^{<++>}<++>"

" To save and compile with one command \k (k=kompile) :)
" no need to launch the pdf along with this because zathura can refresh
" itself after every compilation produces a new pdf, so \k is enough
nmap <leader>k :wa<CR> <leader>ll

" I will just remap this \lv thing to \v just to be consistent with \k and \f
nmap <leader>v <leader>lv


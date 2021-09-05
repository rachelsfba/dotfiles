" From https://black.readthedocs.io/en/stable/integrations/editors.html#vim
autocmd BufWritePre *.py execute ':Black'

" TODO(rachel, 2021-09-02):  when multiple buffers are saved at once with `:wa`, this
" sends a bunch of lines to stdout that i have to acknowledge with <cr>.... can we
" automatically get rid of this if there are no errors?

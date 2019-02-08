" All system-wide defaults are set in $VIMRUNTIME/archlinux.vim (usually just
" /usr/share/vim/vimfiles/archlinux.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vimrc), since archlinux.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing archlinux.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages.
runtime! archlinux.vim

" If you prefer the old-style vim functionalty, add 'runtime! vimrc_example.vim'
" Or better yet, read /usr/share/vim/vim74/vimrc_example.vim or the vim manual
" and configure vim to your own liking!

"{{{Plugin Managers

" Install vim-plug. From
" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

   " Declare the list of plugins.
   
   " Color schemes
   Plug 'drewtempelmeyer/palenight.vim'
   Plug 'trapd00r/neverland-vim-theme'
   
   " Plugins
   Plug 'itchyny/lightline.vim'
   Plug 'Yggdroot/indentLine'
   "Plug 'vim-latex/vim-latex'
   Plug 'lervag/vimtex'
   "Plug 'vim-airline/vim-airline'
   
" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" Needed for Syntax Highlighting and stuff
filetype on
" filetype plugin on
" syntax enable
" syntax on

" execute pathogen#infect()

"}}}

"{{{Airline/Powerline
let g:powerline_pycmd="py3"
let g:airline_powerline_fonts = 1
"}}}


"{{{Auto Commands

" Automatically cd into the directory that the file is in
autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')

" Remove any trailing whitespace that is in the file
" autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" Restore cursor position to where it was before
augroup JumpCursorOnEdit
   au!
   autocmd BufReadPost *
            \ if expand("<afile>:p:h") !=? $TEMP |
            \   if line("'\"") > 1 && line("'\"") <= line("$") |
            \     let JumpCursorOnEdit_foo = line("'\"") |
            \     let b:doopenfold = 1 |
            \     if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
            \        let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
            \        let b:doopenfold = 2 |
            \     endif |
            \     exe JumpCursorOnEdit_foo |
            \   endif |
            \ endif
   " Need to postpone using "zv" until after reading the modelines.
   autocmd BufWinEnter *
            \ if exists("b:doopenfold") |
            \   exe "normal zv" |
            \   if(b:doopenfold > 1) |
            \       exe  "+".1 |
            \   endif |
            \   unlet b:doopenfold |
            \ endif
augroup END

"}}}

"{{{Misc Settings

" Necesary  for lots of cool vim things
set nocompatible

" This shows what you are typing as a command.  I love this!
set showcmd

" Folding Stuffs
set foldmethod=marker

set grepprg=grep\ -nH\ $*

set tabpagemax=100

" From https://shapeshed.com/vim-netrw/
" let g:netrw_banner = 0
" let g:netrw_liststyle = 3
" let g:netrw_browse_split = 4
" let g:netrw_altv = 1
" let g:netrw_winsize = 25
" augroup ProjectDrawer
"   autocmd!
"   autocmd VimEnter * :Vexplore
" augroup END

" Who doesn't like autoindent?
set autoindent

" Spaces are better than a tab character
set expandtab
set smarttab

" Who wants an 8 character tab?  Not me!
set shiftwidth=4
set tabstop=4

" Use english for spellchecking, but don't spellcheck by default
if version >= 700
   set spl=en spell
   set nospell
endif

" Real men use gcc
"compiler gcc

" Cool tab completion stuff
set wildmenu
set wildmode=list:longest,full

" Got backspace?
set backspace=2

" Line Numbers PWN!
set number

" Ignoring case is a fun trick
set ignorecase

" And so is Artificial Intellegence!
set smartcase

" This is totally awesome - remap jj to escape in insert mode.  You'll never type jj anyway, so it's great!
inoremap jj <Esc>

nnoremap j gj
nnoremap k gk

nnoremap JJJJ <Nop>

" Incremental searching is sexy
set incsearch

" Highlight things that we find with the search
set hlsearch

" Since I use linux, I want this
let g:clipbrdDefaultReg = '+'

" When I close a tab, remove the buffer
set nohidden

" Set off the other paren
highlight MatchParen ctermbg=4

let g:rct_completion_use_fri = 1

" autocmd BufNewFile,BufRead *.tex set makeprg=pdflatex\ %\ &&\ evince\ %:r.pdf
"set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after
set grepprg=grep\ -nH\

au FileType * exec("setlocal dictionary+=/usr/share/vim/vimfiles/dictionaries/".expand('<amatch>'))
set complete+=

au BufRead,BufNewFile *.md setlocal textwidth=80

" Customisations based on house-style (arbitrary)
autocmd FileType markdown setlocal sts=2 ts=2 sw=2 expandtab
autocmd FileType htmldjango setlocal  sts=2 ts=2 sw=2 expandtab
autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType javascript setlocal ts=2 sts=2 sw=2 expandtab

set pastetoggle=<F3>
nnoremap <F4> :set number!<cr>
vnoremap <F4> :set number!<cr>

set tabpagemax=100

"}}}

"{{{ Functions

"{{{ Open URL in browser

function! Browser ()
   let line = getline (".")
   let line = matchstr (line, "http[^   ]*")
   exec "!ff ".line
endfunction

nmap <leader>f :call Browser()<cr>

"}}}

let s:comment_map = {
    \   "c": '\/\/',
    \   "cpp": '\/\/',
    \   "go": '\/\/',
    \   "java": '\/\/',
    \   "javascript": '\/\/',
    \   "lua": '--',
    \   "scala": '\/\/',
    \   "php": '\/\/',
    \   "python": '#',
    \   "ruby": '#',
    \   "rust": '\/\/',
    \   "sh": '#',
    \   "zsh": '#',
    \   "zshrc": '#',
    \   "desktop": '#',
    \   "fstab": '#',
    \   "conf": '#',
    \   "profile": '#',
    \   "bashrc": '#',
    \   "bash_profile": '#',
    \   "yaml": '#',
    \   "mail": '>',
    \   "eml": '>',
    \   "bat": 'REM',
    \   "ahk": ';',
    \   "vim": '"',
    \   "tex": '%',
    \ }

function! ToggleComment()
    if has_key(s:comment_map, &filetype)
        let comment_leader = s:comment_map[&filetype]
        if getline('.') =~ "^" . comment_leader . " "
            " Uncomment the line
            execute "silent s/^" . comment_leader . " //"
        else
            if getline('.') =~ "^" . comment_leader
                " Uncomment the line
                execute "silent s/^" . comment_leader . " //"
            else
                " Comment the line
                execute "silent s/^/" . comment_leader . " /"
            end
        end
    else
        echo "No comment leader found for filetype"
    end
endfunction

" Taken from https://stackoverflow.com/a/24046914 and modified
" function! ToggleComment()
"     if has_key(s:comment_map, &filetype)
"         let comment_leader = s:comment_map[&filetype]
"         if getline('.') =~ "^\\s*" . comment_leader . " "
"             " Uncomment the line
"             execute "silent s/^\\(\\s*\\)" . comment_leader . " /\\1/"
"         else
"             if getline('.') =~ "^\\s*" . comment_leader
"                 " Uncomment the line
"                 execute "silent s/^\\(\\s*\\)" . comment_leader . "/\\1/"
"             else
"                 " Comment the line
"                 execute "silent s/^\\(\\s*\\)/\\1" . comment_leader . " /"
"             end
"         end
"     else
"         echo "No comment leader found for filetype"
"     end
" endfunction

nnoremap <leader><Space> :call ToggleComment()<cr>
vnoremap <leader><Space> :call ToggleComment()<cr>

"}}}

"{{{Taglist configuration
let Tlist_Use_Right_Window = 1
let Tlist_Enable_Fold_Column = 0
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_SingleClick = 1
let Tlist_Inc_Winwidth = 0
"}}}

"{{{Look and Feel

"Status line gnarliness
set laststatus=2
set statusline=%F%m%r%h%w\ (%{&ff}){%Y}\ [%l,%v][%p%%]

" Favorite Color Scheme
if has("gui_running")
   colorscheme inkpot
   " Remove Toolbar
   set guioptions-=T
   "Terminus is AWESOME
   set guifont=Terminus\ 9
else
   " Neverland Theme
   color neverland2

   "{{{PaleNight Theme
   "set background=dark
   "colorscheme palenight

   "let g:lightline = { 'colorscheme': 'palenight' }
   "let g:palenight_terminal_italics=1
   "
   "if (has("nvim"))
   "  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
   "  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
   "endif
   "
   "if (has("termguicolors"))
   "   set termguicolors
   "endif
   "}}}
endif

" }}}


"{{{LaTeXSuite stuff
"
"let g:Tex_DefaultTargetFormat = "pdf"
"
""let g:Tex_ViewRule_pdf = "evince"
"let g:Tex_ViewRule_pdf = 'zathura'
"
"" use LaTeX by default
"let g:tex_flavor = "latex"
"let g:Tex_BibtexFlavor = 'biber'
"
"let g:Tex_GotoError = 0
"" The following is relevant to make LaTeX rerun after biber if necessary: 
"" (include all formats for which re-running is to be enabled)
"let g:Tex_MultipleCompileFormats='pdf,dvi'
"
"" autocmd BufNewFile,BufRead *.tex set makeprg=pdflatex\ %\ &&\ evince\ %:r.pdf
"}}}

"{{{vimtex stuff
" use LaTeX by default
let g:tex_flavor = "latex"

" use zathura as PDF viewer (evince/FoxitReader might be system default)
let g:latex_view_general_viewer = 'zathura'
let g:vimtex_view_method='zathura'
"}}}



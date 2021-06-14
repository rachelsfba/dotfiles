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
   
   " Use release branch (recommend)
   Plug 'neoclide/coc.nvim', {'branch': 'release'}

   " Git plugin
   Plug 'tpope/vim-fugitive'

   " Language syntaxes
   Plug 'martinda/Jenkinsfile-vim-syntax'
   
   " Color schemes
   "Plug 'wojciechkepka/bogster'
   "Plug 'drewtempelmeyer/palenight.vim'
   "Plug 'obeijaflor/neverland-vim-theme'
   Plug 'trapd00r/neverland-vim-theme'
   "Plug 'aonemd/kuroi.vim'
  
   " Color scheme test
   Plug 'jgallen23/Color-Scheme-Test'
   
   " Python stuff
   Plug 'cespare/vim-toml'
   Plug 'psf/black'
   
   " Plugins
   "Plug 'itchyny/lightline.vim'
   "Plug 'powerline/powerline'
   "Plug 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
   Plug 'vim-airline/vim-airline'
   Plug 'vim-airline/vim-airline-themes'"
   "Plug 'Yggdroot/indentLine'
   "Plug 'vim-latex/vim-latex'
   Plug 'lervag/vimtex'
   Plug 'tpope/vim-abolish'

   " From https://medium.com/@huntie/10-essential-vim-plugins-for-2018-39957190b7a9
   " -----
   " Evaluating currently for usefulness.
   Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
   Plug 'junegunn/fzf.vim'
   Plug 'editorconfig/editorconfig-vim'
   Plug 'preservim/nerdtree'

   " Shows line diffs on left-hand-side column relative to last git commit
   Plug 'airblade/vim-gitgutter'
  

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" Needed for Syntax Highlighting and stuff
filetype on
" filetype plugin on
" syntax enable
" syntax on

" execute pathogen#infect()

"}}}

"{{{Airline/Powerline/Lightline
"let g:powerline_pycmd="python3"
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter='default'
let g:airline_theme='deus'

"Status line gnarliness
"set laststatus=2
"set statusline=%F%m%r%h%w\ (%{&ff}){%Y}\ [%l,%v][%p%%]

"set rtp+=~/.vim/plugged/powerline/powerline/bindings/vim
"}}}

"{{{fzf
map <C-p> :Files<cr>
nmap <leader>; :Buffers<cr>
"}}}

"{{{coc stuff
" 'Smart' nevigation
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-.> to trigger completion.
inoremap <silent><expr> <c-.> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>

" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>

" Implement methods for trait
nnoremap <silent> <space>i  :call CocActionAsync('codeAction', '', 'Implement missing members')<cr>

" Show actions available at this location
nnoremap <silent> <space>a  :CocAction<cr>
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

"set grepprg=grep\ -nH\ $*
set grepprg=rg\ --vimgrep\ --smart-case\ --follow

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


" Set textwidth to 88 chars
set textwidth=88

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

" Cool tab completion stuff
set wildmenu
set wildmode=list:longest,full

" Don't autocomplete for certain file patterns
" Taken from https://github.com/jonhoo/configs/blob/master/editor/.config/nvim/init.vim
set wildignore=*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db,*.min.js,*.sw?,*.o,*.hi,vendor

" Search results centered please
" Taken from https://github.com/jonhoo/configs/blob/master/editor/.config/nvim/init.vim
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" Ctrl+h to stop searching
" Taken from https://github.com/jonhoo/configs/blob/master/editor/.config/nvim/init.vim
vnoremap <C-h> :nohlsearch<cr>
nnoremap <C-h> :nohlsearch<cr>

" Got backspace?
set backspace=2

" Line Numbers
set number

" per https://jeffkreeftmeijer.com/vim-number/
"set relativenumber
"set nonumber
"augroup numbertoggle
"  autocmd!
"  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber nonumber
"  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber number
"augroup END

" Ignoring case is a fun trick
set ignorecase

" And so is Artificial Intellegence!
set smartcase

" This is totally awesome - remap jj to escape in insert mode.  You'll never type jj anyway, so it's great!
inoremap jj <Esc>

" Move by line
nnoremap j gj
nnoremap k gk

nnoremap JJJJ <Nop>

" Open new file adjacent to current file
" Taken from https://github.com/jonhoo/configs/blob/master/editor/.config/nvim/init.vim
nnoremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" No arrow keys --- force yourself to use the home row
" Taken from https://github.com/jonhoo/configs/blob/master/editor/.config/nvim/init.vim
"nnoremap <up> <nop>
"nnoremap <down> <nop>
"inoremap <up> <nop>
"inoremap <down> <nop>
"inoremap <left> <nop>
"inoremap <right> <nop>

" Left and right can switch buffers
"nnoremap <left> :bp<CR>
"nnoremap <right> :bn<CR>

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

" Append modeline after last line in buffer.
" Use substitute() instead of printf() to handle '%%s' modeline in LaTeX
" files.
function! AppendModeline()
  let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d %set :",
        \ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), l:modeline)
endfunction
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>

nnoremap <leader>k :wa<cr>

" Per https://vim.fandom.com/wiki/Search_and_replace_the_word_under_the_cursor#Mapping
nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>

"}}}

"{{{Taglist configuration
let Tlist_Use_Right_Window = 1
let Tlist_Enable_Fold_Column = 0
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_SingleClick = 1
let Tlist_Inc_Winwidth = 0
"}}}

"{{{Look and Feel

" Favorite Color Scheme
if has("gui_running")
   colorscheme inkpot
   " Remove Toolbar
   set guioptions-=T
   "Terminus is AWESOME
   set guifont=Terminus\ 9
else
   " Neverland Theme
    color neverland

endif

" }}}

"{{{vimtex stuff
" use LaTeX by default
let g:tex_flavor = "latex"

" use zathura as PDF viewer (evince/FoxitReader might be system default)
let g:latex_view_general_viewer = 'zathura'
let g:vimtex_view_method='zathura'

" TeX characters concealing
let g:tex_conceal=''
"}}}


" Check out https://github.com/jonhoo/configs/blob/master/editor/.config/nvim/init.vim
" in the future for more tweaks to consider.


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
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs 
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
 endif

" Plugins will be downloaded under the specified directory.
call plug#begin(stdpath('data') . '/plugged')

   " Declare the list of plugins.
   
   " Carbon for screenshotting code snippets
   " per https://twitter.com/thingskatedid/status/1439155034348941313
   " (base repo: https://github.com/carbon-app/carbon)
   Plug 'kristijanhusak/vim-carbon-now-sh'
   
   " Use release branch (recommend)
   Plug 'neoclide/coc.nvim', {'branch': 'release'}

   " Git plugin
   Plug 'tpope/vim-fugitive'
   
   " Commenting out lines easily
   " Plug 'tpope/vim-commentary'
   Plug 'numToStr/Comment.nvim'

   " Language syntaxes
   Plug 'martinda/Jenkinsfile-vim-syntax'
   Plug 'cespare/vim-toml'
   Plug 'justinmk/vim-syntax-extra'
   
   " Extra movement options
   " Plug 'justinmk/vim-sneak'
   
   " Color schemes
   "Plug 'wojciechkepka/bogster'
   "Plug 'drewtempelmeyer/palenight.vim'
   "Plug 'obeijaflor/neverland-vim-theme'
   Plug 'trapd00r/neverland-vim-theme'
   Plug 'theacodes/witchhazel'
   "Plug 'aonemd/kuroi.vim'
   "Plug 'theacodes/witchhazel'
  
   " Color scheme test
   Plug 'jgallen23/Color-Scheme-Test'
   
   " Python stuff
   Plug 'psf/black'

   " Rust stuff
   Plug 'rust-lang/rust.vim'
   
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
   " Evaluating currently for usefulness.
   Plug 'preservim/nerdtree'

   " Fuzzy finder
   Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
   Plug 'junegunn/fzf.vim'

   " Consistent editing experience between editors
   Plug 'editorconfig/editorconfig-vim'

   " Shows line diffs on left-hand-side column relative to last git commit
   Plug 'airblade/vim-gitgutter'

   " Stuff to look into once NeoVim 0.5 is stable
   " -----------------------------------------------
   " https://github.com/nvim-treesitter/nvim-treesitter
   "Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
   
   " Stuff to look into once NeoVim 0.5 is stable
   " -----------------------------------------------
   " https://github.com/nvim-telescope/telescope.nvim
   "Plug 'nvim-lua/popup.nvim'
   "Plug 'nvim-lua/plenary.nvim'
   "Plug 'nvim-telescope/telescoApe.nvim'
   
   " Stuff to look into once NeoVim 0.5 is stable
   " -----------------------------------------------
   " https://github.com/neovim/nvim-lspconfig
   "Plug 'neovim/nvim-lspconfig'
  

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" Needed for Syntax Highlighting and stuff
filetype on
" filetype plugin on
" syntax enable
" syntax on

" execute pathogen#infect()

"}}}

"{{{Airline
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
let g:coc_global_extensions = [ 
    \ 'coc-json',
    \ 'coc-git',
    \ 'coc-markdownlint',
    \ 'coc-pyright',
    \ 'coc-rust-analyzer'
    \]

" Taken from https://github.com/jonhoo/configs/blob/master/editor/.config/nvim/init.vim

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

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

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
" augroup JumpCursorOnEdit
"    au!
"    autocmd BufReadPost *
"             \ if expand("<afile>:p:h") !=? $TEMP |
"             \   if line("'\"") > 1 && line("'\"") <= line("$") |
"             \     let JumpCursorOnEdit_foo = line("'\"") |
"             \     let b:doopenfold = 1 |
"             \     if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
"             \        let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
"             \        let b:doopenfold = 2 |
"             \     endif |
"             \     exe JumpCursorOnEdit_foo |
"             \   endif |
"             \ endif
"    " Need to postpone using "zv" until after reading the modelines.
"    autocmd BufWinEnter *
"             \ if exists("b:doopenfold") |
"             \   exe "normal zv" |
"             \   if(b:doopenfold > 1) |
"             \       exe  "+".1 |
"             \   endif |
"             \   unlet b:doopenfold |
"             \ endif
" augroup END

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

" Use English for spellchecking, but don't spellcheck by default
if version >= 700
   set spl=en spell
   set nospell
endif

" Permanent undo -- persists between nvim sessions
set undodir=$XDG_DATA_HOME/nvim/undo
set undofile

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
"set number

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" per https://jeffkreeftmeijer.com/vim-number/
set number

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

" Ignoring case is a fun trick
set ignorecase

" And so is Artificial Intellegence!
set smartcase

" This is totally awesome - remap jj to escape in insert mode.  You'll never type jj anyway, so it's great!
" inoremap jj <Esc>
nnoremap JJJJ <Nop>

" Move by line
"nnoremap j gj
"nnoremap k gk

" Add current date/time to insert position
nnoremap <leader>da :put =strftime(\"%Y-%m-%d %H:%M:%S\")<cr>

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

" Control + Page Down or Control + Page Up can switch buffers
" I use gt and gT for tabs anyway so idc if overriding that
nnoremap <C-PageUp> :bn<CR>
nnoremap <C-PageDown> :bp<CR>

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

" Prevent accidental writes to buffers that shouldn't be edited
" Taken from https://github.com/jonhoo/configs/blob/master/editor/.config/nvim/init.vim
autocmd BufRead *.orig set readonly
autocmd BufRead *.pacnew set readonly

" Leave paste mode when leaving insert mode
" Taken from https://github.com/jonhoo/configs/blob/master/editor/.config/nvim/init.vim
autocmd InsertLeave * set nopaste

set pastetoggle=<F3>
nnoremap <F4> :set number!<cr>
vnoremap <F4> :set number!<cr>

set tabpagemax=100

" I want to auto-continue comments on the next line.  
" The default is 'tcql' -- add 'r' (for Insert mode) and 'o' (for Normal mode).
"
" See `:h formatoptions` and `:h fo-table` for more info.
set formatoptions+=ro

"}}}

"{{{ Functions

"{{{ Open URL in browser

" function! Browser ()
"    let line = getline (".")
"    let line = matchstr (line, "http[^   ]*")
"    exec "!ff ".line
" endfunction

" nmap <leader>f :call Browser()<cr>

"}}}

lua require('Comment').setup()

" nnoremap <leader><Space> :Commentary<cr>
" vnoremap <leader><Space> :Commentary<cr>

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

" Neat X clipboard integration
" \p will paste clipboard into buffer
" \c will copy entire buffer into clipboard
" Taken from https://github.com/jonhoo/configs/blob/master/editor/.config/nvim/init.vim
noremap <leader>p :read !xsel --clipboard --output<cr>
noremap <leader>c :w !xsel -ib<cr><cr>

" Per https://vim.fandom.com/wiki/Search_and_replace_the_word_under_the_cursor#Mapping
nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>

"}}}

"{{{Look and Feel

color neverland
" color witchhazel-hypercolor
" color witchhazel

" }}}

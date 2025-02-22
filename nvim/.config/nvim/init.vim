" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages.
runtime! archlinux.vim

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
   
   " Secure modelines
   Plug 'ciaranm/securemodelines'
   
   " Carbon for screenshotting code snippets
   " per https://twitter.com/thingskatedid/status/1439155034348941313
   " (base repo: https://github.com/carbon-app/carbon)
   Plug 'kristijanhusak/vim-carbon-now-sh'
   
   " Configuration for built-in NeoVim LSP client
   " https://github.com/neovim/nvim-lspconfig
   Plug 'neovim/nvim-lspconfig'
   Plug 'hrsh7th/cmp-nvim-lsp'
   Plug 'hrsh7th/cmp-buffer'
   Plug 'hrsh7th/cmp-path'
   Plug 'hrsh7th/cmp-cmdline'
   Plug 'hrsh7th/nvim-cmp'
   Plug 'ray-x/lsp_signature.nvim'

   " code/text snippet functionality
   Plug 'hrsh7th/cmp-vsnip'
   Plug 'hrsh7th/vim-vsnip'

   " Git plugin
   Plug 'tpope/vim-fugitive'
   
   " Commenting out lines easily
   " Plug 'tpope/vim-commentary'
   Plug 'numToStr/Comment.nvim'

   " Language syntaxes
   Plug 'martinda/Jenkinsfile-vim-syntax'
   " Plug 'cespare/vim-toml' unnecessary now
   Plug 'justinmk/vim-syntax-extra'
   Plug 'twh2898/vim-scarpet'
   
   " Extra movement options
   " Plug 'justinmk/vim-sneak'
   
   " Color schemes
   "Plug 'wojciechkepka/bogster'
   "Plug 'drewtempelmeyer/palenight.vim'
   "Plug 'obeijaflor/neverland-vim-theme'
   Plug 'trapd00r/neverland-vim-theme'
   " Plug 'sainnhe/everforest'
   " Plug 'morhetz/gruvbox'
   Plug 'sainnhe/gruvbox-material'
   Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
   "Plug 'aonemd/kuroi.vim'
   "Plug 'theacodes/witchhazel'
  
   " Color scheme test
   Plug 'jgallen23/Color-Scheme-Test'
   
   " Python stuff
   Plug 'psf/black'

   " Rust stuff
   Plug 'rust-lang/rust.vim'
   
   " Plugins
   Plug 'vim-airline/vim-airline'
   Plug 'lervag/vimtex'
   Plug 'tpope/vim-abolish'

   " File explorer
   Plug 'nvim-tree/nvim-web-devicons' " optional, for file icons
   Plug 'nvim-tree/nvim-tree.lua'

   " Fuzzy finder
   Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
   Plug 'junegunn/fzf.vim'

   " Consistent editing experience between editors
   Plug 'editorconfig/editorconfig-vim'

   " Shows line diffs on left-hand-side column relative to last git commit
   Plug 'airblade/vim-gitgutter'

   " TreeSitter for better syntax Highlighting
   " https://github.com/nvim-treesitter/nvim-treesitter
   Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

   " For TODO, etc. highlighting in comments
   " Plug 'nvim-lua/plenary.nvim'
   " Plug 'folke/todo-comments.nvim'  " could also use https://github.com/stsewd/tree-sitter-comment instead

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

"Status line gnarliness
"set laststatus=2
"set statusline=%F%m%r%h%w\ (%{&ff}){%Y}\ [%l,%v][%p%%]

"set rtp+=~/.vim/plugged/powerline/powerline/bindings/vim
"}}}

"{{{fzf
map <C-p> :Files<cr>
nmap <leader>; :Buffers<cr>
"}}}

" {{{ TODO comments highlighting
" lua << EOF
"   require("todo-comments").setup {
"     -- your configuration comes here
"     -- or leave it empty to use the default settings
"     -- refer to the configuration section below
"   }
"
"   vim.keymap.set("n", "]t", function()
"   require("todo-comments").jump_next()
"   end, { desc = "Next todo comment" })
"
"   vim.keymap.set("n", "[t", function()
"     require("todo-comments").jump_prev()
"   end, { desc = "Previous todo comment" })
"   
"   -- You can also specify a list of valid jump keywords
"   
"   vim.keymap.set("n", "]t", function()
"     require("todo-comments").jump_next({keywords = { "ERROR", "WARNING" }})
"   end, { desc = "Next error/warning todo comment" })
"    
" EOF
" }}}

" {{{ TreeSitter support
lua <<EOF
    require'nvim-treesitter.configs'.setup {
      -- A list of parser names, or "all"
      -- https://github.com/nvim-treesitter/nvim-treesitter
      ensure_installed = {
          "c",
          "comment",
          "diff",
          "gitcommit",
          "git_rebase",
          "lua",
          "markdown",
          "markdown_inline",
          "python",
          "query",
          "rust",
          "terraform",
          "vim",
          "vimdoc",
          "yaml",
      },
         
      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,

      -- Automatically install missing parsers when entering buffer
      -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
      auto_install = true,

      -- List of parsers to ignore installing (for "all")
      -- NOTE(2023-03-07): Disabled Treesitter for LaTeX due to conflicts with VimTeX.
      --    See `:help vimtex-faq-treesitter` for more info.
      ignore_install = { "latex" },

      ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
      -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

      -- https://github.com/nvim-treesitter/nvim-treesitter/issues/1136#issuecomment-986260717
      indent = {
          disable = true,
          -- disable = { "yaml", "python", }
      },
      
      highlight = {
        -- `false` will disable the whole extension
        enable = true,

        -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
        -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
        -- the name of the parser)
        -- list of language that will be disabled
        -- disable = { "c", "rust" },
        -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
        disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
      }
    }
EOF
" }}}

" {{{ nvim-tree

" Per https://github.com/nvim-tree/nvim-tree.lua/wiki/Tips
"
" See `:help nvim-tree-setup` for more info on configuration options
lua << EOF
require("nvim-tree").setup()
EOF

" }}}

" {{{ NeoVim LSP 

set completeopt=menu,menuone,noselect

lua <<EOF
  -- Set up nvim-cmp.
  local cmp = require'cmp'
  
  -- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#super-tab-like-mapping
  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end
  
  -- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#super-tab-like-mapping
  local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
  end

  local lsp_flags = {
    -- This is the default in Nvim 0.7+
    -- debounce_text_changes = 150,
  }

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

      -- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#super-tab-like-mapping
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif vim.fn["vsnip#available"](1) == 1 then
          feedkey("<Plug>(vsnip-expand-or-jump)", "")
        elseif has_words_before() then
          cmp.complete()
        else
          fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function()
        if cmp.visible() then
          cmp.select_prev_item()
        elseif vim.fn["vsnip#jumpable"](-1) == 1 then
          feedkey("<Plug>(vsnip-jump-prev)", "")
        end
      end, { "i", "s" }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  -- Mappings.
  -- See `:help vim.diagnostic.*` for documentation on any of the below functions
  local opts = { noremap=true, silent=true }
  vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)
  
  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
  local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  
    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
  end

  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['pyright'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
    flags = lsp_flags,
  }

  require('lspconfig')['rust_analyzer'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
    flags = lsp_flags,
    settings = {
      ["rust-analyzer"] = {
        imports = {
          granularity = {
            group = "module",
          },
          prefix = "self",
        },
        cargo = {
          buildScripts = {
            enable = true,
          },
        },
        procMacro = {
          enable = true
        },
      }
    }
  }

EOF
" }}}

" {{{ lsp_signature hints
lua << EOF
  local cfg = {
    debug = false, -- set to true to enable debug logging
    log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log", -- log dir when debug is on
    -- default is  ~/.cache/nvim/lsp_signature.log
    verbose = false, -- show debug line number
  
    bind = true, -- This is mandatory, otherwise border config won't get registered.
                 -- If you want to hook lspsaga or other signature handler, pls set to false
    doc_lines = 10, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
                   -- set to 0 if you DO NOT want any API comments be shown
                   -- This setting only take effect in insert mode, it does not affect signature help in normal
                   -- mode, 10 by default
  
    max_height = 12, -- max height of signature floating_window
    max_width = 80, -- max_width of signature floating_window
    noice = false, -- set to true if you using noice to render markdown
    wrap = true, -- allow doc/signature text wrap inside floating_window, useful if your lsp return doc/sig is too long
    
    floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
  
    floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
    -- will set to true when fully tested, set to false will use whichever side has more space
    -- this setting will be helpful if you do not want the PUM and floating win overlap
  
    floating_window_off_x = 1, -- adjust float windows x position. 
                               -- can be either a number or function
    floating_window_off_y = 0, -- adjust float windows y position. e.g -2 move window up 2 lines; 2 move down 2 lines
                                -- can be either number or function, see examples
  
    close_timeout = 4000, -- close floating window after ms when laster parameter is entered
    fix_pos = false,  -- set to true, the floating window will not auto-close until finish all parameters
    hint_enable = true, -- virtual hint enable
    hint_prefix = "🐼 ",  -- Panda for parameter, NOTE: for the terminal not support emoji, might crash
    hint_scheme = "String",
    hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
    handler_opts = {
      border = "rounded"   -- double, rounded, single, shadow, none, or a table of borders
    },
  
    always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58
  
    auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
    extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
    zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom
  
    padding = '', -- character to pad on left and right of signature can be ' ', or '|'  etc
  
    transparency = nil, -- disabled by default, allow floating win transparent value 1~100
    shadow_blend = 36, -- if you using shadow as border use this set the opacity
    shadow_guibg = 'Black', -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
    timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
    toggle_key = nil, -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
  
    select_signature_key = nil, -- cycle to next signature, e.g. '<M-n>' function overloading
    move_cursor_key = nil, -- imap, use nvim_set_current_win to move cursor between current win and floating
  }
  
  require "lsp_signature".setup(cfg)
EOF
" }}}

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

" {{{ Rust stuff
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0
let g:rust_clip_command = 'xclip -selection clipboard'
" }}}

"{{{Misc Settings

" Necessary for lots of cool vim things
set nocompatible

" Plugin settings
let g:secure_modelines_allowed_items = [
                \ "textwidth",   "tw",
                \ "softtabstop", "sts",
                \ "tabstop",     "ts",
                \ "shiftwidth",  "sw",
                \ "expandtab",   "et",   "noexpandtab", "noet",
                \ "filetype",    "ft",
                \ "foldmethod",  "fdm",
                \ "readonly",    "ro",   "noreadonly", "noro",
                \ "rightleft",   "rl",   "norightleft", "norl",
                \ "colorcolumn"
                \ ]

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

" Suspend with Ctrl+S
" inoremap <C-s> :sus<cr>
" vnoremap <C-s> :sus<cr>
" nnoremap <C-s> :sus<cr>


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

" Keep on mouse support
"set mouse=a
" Turn off mouse support
set mouse=

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
" nnoremap <up> <nop>
" nnoremap <down> <nop>
" inoremap <up> <nop>
" inoremap <down> <nop>
" inoremap <left> <nop>
" inoremap <right> <nop>

" Left and right can switch buffers
" nnoremap <left> :bp<CR>
" nnoremap <right> :bn<CR>

" Control + Page Down or Control + Page Up can switch buffers
" I use gt and gT for tabs anyway so idc if overriding that
nnoremap <C-PageUp> :bn<CR>
nnoremap <C-PageDown> :bp<CR>

" Incremental searching is sexy
set incsearch

" Highlight things that we find with the search
set hlsearch

" https://superuser.com/questions/163589/switch-buffers-in-vim-without-saving-to-a-currently-modified-file
set hidden

" Since I use linux, I want this
let g:clipbrdDefaultReg = '+'


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

" Per https://vi.stackexchange.com/questions/678/how-do-i-save-a-file-in-a-directory-that-does-not-yet-exist
nnoremap <Leader>m :call mkdir(expand("%:p:h"), "p")<CR>

" Run doctest on current file, for use when LeetCoding
nnoremap <Leader>dt :!pytest --doctest-modules %<CR>



"}}}

"{{{Look and Feel

" color neverland
" color everforest
" color gruvbox
" color gruvbox-material
" set termguicolors
" let g:airline_theme='gruvbox_material'

" https://github.com/catppuccin/nvim
color catppuccin-macchiato
let g:airline_theme = 'catppuccin'

"}}}

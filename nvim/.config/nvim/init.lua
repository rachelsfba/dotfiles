--------------------------------------------------------------------------------
-- init.lua
-- Pure-Lua rewrite of the original init.vim
-- Plugin manager: lazy.nvim (https://github.com/folke/lazy.nvim)
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Bootstrap lazy.nvim
--------------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

--------------------------------------------------------------------------------
-- Plugins
--------------------------------------------------------------------------------
require("lazy").setup({

  -- Secure modelines
  {
    "ciaranm/securemodelines",
    init = function()
      vim.g.secure_modelines_allowed_items = {
        "textwidth", "tw",
        "softtabstop", "sts",
        "tabstop", "ts",
        "shiftwidth", "sw",
        "expandtab", "et", "noexpandtab", "noet",
        "filetype", "ft",
        "foldmethod", "fdm",
        "readonly", "ro", "noreadonly", "noro",
        "rightleft", "rl", "norightleft", "norl",
        "colorcolumn",
      }
    end,
  },

  -- Carbon for screenshotting code snippets
  -- https://github.com/kristijanhusak/vim-carbon-now-sh (base: https://github.com/carbon-app/carbon)
  "kristijanhusak/vim-carbon-now-sh",

  -- Built-in NeoVim LSP client + completion
  -- https://github.com/neovim/nvim-lspconfig
  "neovim/nvim-lspconfig",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",
    },
    config = function()
      require("config.cmp_lsp")
    end,
  },
  -- Snippet functionality
  "hrsh7th/cmp-vsnip",
  "hrsh7th/vim-vsnip",

  -- Git plugin
  "tpope/vim-fugitive",
  

  -- Commenting out lines easily
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },

  -- Language syntaxes
  "martinda/Jenkinsfile-vim-syntax",
  "justinmk/vim-syntax-extra",
  "twh2898/vim-scarpet",

  -- Color schemes
  "trapd00r/neverland-vim-theme",
  "sainnhe/gruvbox-material",
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("catppuccin-macchiato")
    end,
  },

  -- Color scheme test
  "jgallen23/Color-Scheme-Test",

  -- Python stuff
  "psf/black",

  -- Rust stuff
  {
    "rust-lang/rust.vim",
    init = function()
      vim.g.rustfmt_autosave = 1
      vim.g.rustfmt_emit_files = 1
      vim.g.rustfmt_fail_silently = 0
      vim.g.rust_clip_command = "xclip -selection clipboard"
    end,
  },

  -- Status line
  {
    "vim-airline/vim-airline",
    init = function()
      vim.g.airline_powerline_fonts = 1
      vim.g["airline#extensions#tabline#enabled"] = 1
      vim.g["airline#extensions#tabline#formatter"] = "default"
      vim.g.airline_theme = "catppuccin_macchiato"
    end,
  },
  -- NOTE(2026-11-09): until https://github.com/vim-airline/vim-airline-themes/pull/288
  -- is merged into `vim-airline/vim-airline-themes`, we need to use this one forked
  -- repo to get the catppuccin themes
  --"vim-airline/vim-airline-themes", 
  {
    "comfysage/vim-airline-themes", 
    branch = "push-nllkturtlpkm",
  },

  "lervag/vimtex",
  "tpope/vim-abolish",

  -- File explorer
  { "nvim-tree/nvim-web-devicons" }, -- optional, for file icons
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- See `:help nvim-tree-setup` for more info on configuration options
      require("nvim-tree").setup()
    end,
  },

  -- Fuzzy finder
  {
    "junegunn/fzf",
    build = function()
      vim.fn["fzf#install"]()
    end,
  },
  {
    "junegunn/fzf.vim",
    dependencies = { "junegunn/fzf" },
    keys = {
      { "<C-p>", ":Files<CR>", desc = "Fuzzy find files" },
      { "<leader>;", ":Buffers<CR>", desc = "Fuzzy find buffers" },
    },
  },

  -- Consistent editing experience between editors
  "editorconfig/editorconfig-vim",

  -- Shows line diffs on left-hand-side column relative to last git commit
  "airblade/vim-gitgutter",

  -- TreeSitter for better syntax highlighting
  -- https://github.com/nvim-treesitter/nvim-treesitter (`main` branch rewrite)
  -- NOTE: the rewrite has no `nvim-treesitter.configs` module, no
  -- `ensure_installed`/`auto_install`/`highlight` options. Parsers are installed
  -- with `require("nvim-treesitter").install()` and highlighting is started
  -- with Neovim's built-in `vim.treesitter.start()`.
  -- Requires Neovim 0.11+, the `tree-sitter` CLI, and a C compiler.
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false, -- this plugin does not support lazy-loading
    build = ":TSUpdate", -- We recommend updating the parsers on update
    config = function()
      local ts = require("nvim-treesitter")

      ts.setup({
        -- Where parsers/queries are stored (this is the default)
        install_dir = vim.fn.stdpath("data") .. "/site",
      })

      -- Equivalent of the old `ensure_installed` (async; no-op if already installed)
      ts.install({
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
      })

      -- NOTE(2023-03-07): Disabled Treesitter for LaTeX due to conflicts with VimTeX.
      --   See `:help vimtex-faq-treesitter` for more info.
      local ignore_langs = { latex = true }

      -- Equivalent of the old `highlight.disable` function (skip large files)
      local max_filesize = 100 * 1024 -- 100 KB

      -- Equivalent of `highlight.enable = true` and `auto_install = true`.
      -- (`indent` was disabled in the old config, so nothing to set up for it.)
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter_start", { clear = true }),
        pattern = "*",
        callback = function(args)
          local lang = vim.treesitter.language.get_lang(args.match) or args.match
          -- ignore any ignored languages
          if ignore_langs[lang] then
            return
          end

          -- do not use treesitter for any huge files, it would be too buggy
          local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
          if ok and stats and stats.size > max_filesize then
            return
          end

          if vim.tbl_contains(ts.get_installed(), lang) then
            vim.treesitter.start(args.buf, lang)
          elseif vim.tbl_contains(ts.get_available(), lang) then
            -- Auto-install a missing parser (async). Highlighting begins the
            -- next time this filetype loads, e.g. after `:e`.
            ts.install({ lang })
          end
        end,
      })
    end,
  },

  -- For TODO, etc. highlighting in comments (disabled, as in the original)
  -- "nvim-lua/plenary.nvim",
  -- "folke/todo-comments.nvim",

  {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("config.lsp_signature")
    end,
  },
})

--------------------------------------------------------------------------------
-- General options
-- (roughly the vim.vim `set` lines from the {{{Misc Settings}}} fold)
--------------------------------------------------------------------------------
local opt = vim.opt

-- Folding
opt.foldmethod = "marker"

-- Grep
opt.grepprg = "rg --vimgrep --smart-case --follow"

opt.tabpagemax = 100

-- Line width / indentation
opt.textwidth = 88
opt.autoindent = true
opt.expandtab = true
opt.smarttab = true
opt.shiftwidth = 4
opt.tabstop = 4

-- Spelling: available, but off by default
opt.spelllang = "en"
opt.spell = false

-- Permanent undo -- persists between nvim sessions
opt.undodir = vim.fn.expand("$XDG_DATA_HOME/nvim/undo")
opt.undofile = true

-- Cool tab completion stuff
opt.wildmenu = true
opt.wildmode = "list:longest,full"

-- Don't autocomplete for certain file patterns
-- Taken from https://github.com/jonhoo/configs/blob/master/editor/.config/nvim/init.vim
opt.wildignore = {
  "*~", 
  "*.png", 
  "*.jpg", 
  "*.gif", 
  "*.settings", 
  "Thumbs.db",
  "*.min.js", 
  "*.sw?", 
  "*.o", 
  "*.hi", 
  "vendor",
}

-- Got backspace?
opt.backspace = { "indent", "eol", "start" }

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appear/become resolved.
opt.signcolumn = "yes"

-- Line numbers (relative-number toggling handled by an autocmd below)
opt.number = true

-- Ignoring case is a fun trick
opt.ignorecase = true

-- And so is Artificial Intelligence!
opt.smartcase = true

-- Turn off mouse support
opt.mouse = ""

-- Incremental / highlighted search
opt.incsearch = true
opt.hlsearch = true

-- https://superuser.com/questions/163589/switch-buffers-in-vim-without-saving-to-a-currently-modified-file
opt.hidden = true

-- I want to auto-continue comments on the next line.
-- The default is 'tcql' -- add 'r' (for Insert mode) and 'o' (for Normal mode).
-- See `:h formatoptions` and `:h fo-table` for more info.
opt.formatoptions:append("ro")

--------------------------------------------------------------------------------
-- Misc globals
--------------------------------------------------------------------------------
vim.g.clipbrdDefaultReg = "+"
vim.g.rct_completion_use_fri = 1

-- Set off the other paren
vim.api.nvim_set_hl(0, "MatchParen", { ctermbg = 4 })

--------------------------------------------------------------------------------
-- Keymaps
--------------------------------------------------------------------------------
local map = vim.keymap.set

-- Search results centered please
-- Taken from https://github.com/jonhoo/configs/blob/master/editor/.config/nvim/init.vim
map("n", "n", "nzz", { silent = true })
map("n", "N", "Nzz", { silent = true })
map("n", "*", "*zz", { silent = true })
map("n", "#", "#zz", { silent = true })
map("n", "g*", "g*zz", { silent = true })

-- Ctrl+h to stop searching
-- Taken from https://github.com/jonhoo/configs/blob/master/editor/.config/nvim/init.vim
map({ "n", "v" }, "<C-h>", ":nohlsearch<CR>")

-- Disable an old accidental habit
map("n", "JJJJ", "<Nop>")

-- Add current date/time to insert position
map("n", "<leader>da", ":put =strftime(\"%Y-%m-%d %H:%M:%S\")<CR>")

-- Open new file adjacent to current file
-- Taken from https://github.com/jonhoo/configs/blob/master/editor/.config/nvim/init.vim
map("n", "<leader>e", ':e <C-R>=expand("%:p:h") . "/" <CR>')

-- Control + j/k switches buffers
map("n", "<C-j>", ":bn<CR>")
map("n", "<C-k>", ":bp<CR>")

-- Toggle line numbers
map({ "n", "v" }, "<F4>", ":set number!<CR>")

-- Save all buffers
map("n", "<leader>k", ":wa<CR>")

-- Neat X clipboard integration
-- \p will paste clipboard into buffer
-- \c will copy entire buffer into clipboard
-- Taken from https://github.com/jonhoo/configs/blob/master/editor/.config/nvim/init.vim
map({ "n", "v" }, "<leader>p", ":read !xsel --clipboard --output<CR>")
map({ "n", "v" }, "<leader>c", ":w !xsel -ib<CR><CR>")

-- Per https://vim.fandom.com/wiki/Search_and_replace_the_word_under_the_cursor#Mapping
map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>//g<Left><Left>]])

-- Per https://vi.stackexchange.com/questions/678/how-do-i-save-a-file-in-a-directory-that-does-not-yet-exist
map("n", "<leader>m", function()
  vim.fn.mkdir(vim.fn.expand("%:p:h"), "p")
end)

-- Run doctest on current file, for use when LeetCoding
map("n", "<leader>dt", ":!pytest --doctest-modules %<CR>")

-- Append a modeline after the last line in the buffer.
local function append_modeline()
  local modeline = string.format(
    " vim: set ts=%d sw=%d tw=%d %set :",
    vim.bo.tabstop,
    vim.bo.shiftwidth,
    vim.bo.textwidth,
    vim.bo.expandtab and "" or "no"
  )
  modeline = vim.fn.substitute(vim.bo.commentstring, "%s", modeline, "")
  vim.api.nvim_buf_set_lines(0, -1, -1, false, { modeline })
end
map("n", "<leader>ml", append_modeline, { silent = true })

--------------------------------------------------------------------------------
-- Autocommands
--------------------------------------------------------------------------------
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Automatically cd into the directory that the file is in
autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    vim.cmd("chdir " .. vim.fn.escape(vim.fn.expand("%:p:h"), " "))
  end,
})

-- Relative-number toggling
-- per https://jeffkreeftmeijer.com/vim-number/
local numbertoggle = augroup("numbertoggle", { clear = true })
autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
  group = numbertoggle,
  pattern = "*",
  callback = function()
    if vim.wo.number and vim.fn.mode() ~= "i" then
      vim.wo.relativenumber = true
    end
  end,
})
autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
  group = numbertoggle,
  pattern = "*",
  callback = function()
    if vim.wo.number then
      vim.wo.relativenumber = false
    end
  end,
})

-- Dictionary completion per filetype
autocmd("FileType", {
  pattern = "*",
  callback = function(args)
    vim.opt_local.dictionary:append("/usr/share/vim/vimfiles/dictionaries/" .. args.match)
  end,
})

-- Prevent accidental writes to buffers that shouldn't be edited
-- Taken from https://github.com/jonhoo/configs/blob/master/editor/.config/nvim/init.vim
autocmd("BufRead", { pattern = "*.orig", command = "set readonly" })
autocmd("BufRead", { pattern = "*.pacnew", command = "set readonly" })

-- Leave paste mode when leaving insert mode
-- Taken from https://github.com/jonhoo/configs/blob/master/editor/.config/nvim/init.vim
autocmd("InsertLeave", { pattern = "*", command = "set nopaste" })

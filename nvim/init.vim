packadd minpac

call minpac#init()

" minpac must have {'type': 'opt'} so that it can be loaded with `packadd`.
call minpac#add('k-takata/minpac', {'type': 'opt'})

call minpac#add('kyazdani42/nvim-web-devicons')

" Add other plugins here.
call minpac#add('christoomey/vim-tmux-navigator')
call minpac#add('shaunsingh/nord.nvim')
call minpac#add('hoob3rt/lualine.nvim')
call minpac#add('akinsho/nvim-bufferline.lua')

call minpac#add('tpope/vim-surround')
call minpac#add('godlygeek/tabular')
call minpac#add('ervandew/supertab')
call minpac#add('liuchengxu/vim-clap', { 'do': ':Clap install-binary!' })
call minpac#add('camspiers/animate.vim')
call minpac#add('camspiers/lens.vim')

"" Git Plugins
call minpac#add('rhysd/git-messenger.vim')
call minpac#add('nvim-lua/plenary.nvim')
call minpac#add('lewis6991/gitsigns.nvim')
"call minpac#add('tpope/vim-fugitive')

"" Language Plugins
call minpac#add('liuchengxu/vista.vim')
"call minpac#add('prabirshrestha/async.vim')
"call minpac#add('prabirshrestha/vim-lsp')
call minpac#add('nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'})
call minpac#add('lukas-reineke/indent-blankline.nvim')
"call minpac#add('davidhalter/jedi-vim')
"call minpac#add('neovim/nvim-lsp')
"call minpac#add('dense-analysis/ale')

command! Pu call minpac#update()
command! Pc call minpac#clean()

" Load the plugins right now. (optional)
packloadall

"===========================Basic settings begin ======================"
set termguicolors
set background=dark
set encoding=utf-8
set ruler
set hlsearch
set number
set relativenumber
set updatetime=100
"set mouse=a
set selectmode=mouse
set hlsearch
set softtabstop=4
set shiftwidth=4
set tabstop=4
set expandtab
set backspace=indent,eol,start
set ignorecase
set smartcase
set incsearch
set title
set textwidth=0
set wrapmargin=0
set tags=tags;/
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.
set path=**
set scrolloff=5
"syntax on
filetype plugin on
"set cmdheight=2
set signcolumn=yes
let g:python_highlight_all = 1
"=========================== Basic end======================"

"=========================== Misc Start======================"
function! LoadCscope()
  let db = findfile("cscope.out", ".;")
  if (!empty(db))
    let path = strpart(db, 0, match(db, "/cscope.out$"))
    set nocscopeverbose " suppress 'duplicate connection' error
    exe "cs add " . db . " " . path
    set cscopeverbose
  endif
endfunction
au BufEnter /* call LoadCscope()

function! ShowFuncName()
  let lnum = line(".")
  let col = col(".")
  echohl ModeMsg
  echo getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bW'))
  echohl None
  call search("\\%" . lnum . "l" . "\\%" . col . "c")
endfun
map f :call ShowFuncName() <CR>

let g:indent_blankline_use_treesitter = v:true
let g:indent_blankline_show_current_context = v:true
map <leader>ib :IndentBlanklineToggle! <CR>
"=========================== Misc end======================"

"=========================== Vista Start======================"
"function! NearestMethodOrFunction() abort
"  return get(b:, 'vista_nearest_method_or_function', '')
"endfunction
"autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
"
"let g:vista_sidebar_position = 'vertical topleft'
"let g:vista_sidebar_width = 50
"let g:vista_echo_cursor_strategy = 'echo'
"
"let g:vista_executive_for = {
"  \ 'c': 'vim_lsp',
"  \ }
"=========================== Vista End======================"

"=========================== GitMessenger Start======================"
let g:git_messenger_always_into_popup = 'true'
"=========================== GitMessenger End======================"

"=========================== Shortcuts Start======================"
" Line numbers
nnoremap <leader>n  :set nonumber!<CR>
nnoremap <leader>rn :set norelativenumber!<CR>

" Clear highlighting
nnoremap <leader>c :nohl<CR>

" Paste mode
nnoremap <leader>pa :set nopaste!<CR>

" Pane navigation
let g:tmux_navigator_no_mappings = 1
" Disable tmux navigator when zooming the Vim pane
let g:tmux_navigator_disable_when_zoomed = 1
nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>

" vim-clap
map <leader>p  :Clap files! <CR>
nmap <unique> <C-\>p :Clap files ++query=<cword> <CR>
map <leader>b  :Clap buffers! <CR>
map <leader>r  :Clap grep! <CR>
nmap <unique> <C-\>r :Clap grep ++query=<cword> <CR>
map <leader>rr :Clap grep2! <CR>
nmap <unique> <C-\>rr :Clap grep2 ++query=<cword> <CR>

" Cscope
set cscopetag
nmap <unique> <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <unique> <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <unique> <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <unique> <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <unique> <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <unique> <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <unique> <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <unique> <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>s :scs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>g :scs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>c :scs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>t :scs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>e :scs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-Space>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-Space>d :scs find d <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>a :scs find a <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-Space><C-Space>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>a :vert scs find a <C-R>=expand("<cword>")<CR><CR>
"=========================== Shortcuts End======================"

""=========================== LSP Registration ======================"
"let g:lsp_diagnostics_enabled = 0         " disable diagnostics support
""" use <tab> for trigger completion and navigate to the next complete item
"function! s:check_back_space() abort
"  let col = col('.') - 1
"  return !col || getline('.')[col - 1]  =~ '\s'
"endfunction
"
"nnoremap <leader>s :LspReferences<cr>
"nnoremap <leader>g :LspDefinition<cr>
"=========================== LSP Registration END======================"

""=========================== Ale Plugin ======================"
"let g:ale_linters = {
"    \   'c': ['clangd'],
"    \}
"" Only run linters named in ale_linters settings.
"let g:ale_linters_explicit = 1
""=========================== Ale Plugin End ======================"

""========================== Lua ==========================="
lua <<EOF
-- Treesitter
require'nvim-treesitter.configs'.setup {
ensure_installed = { "bash", "c", "json", "lua", "python", "regex" },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
    custom_captures = {
      -- Highlight the @TODO capture group with the "Identifier" highlight group.
      ["TODO"] = "Identifier",
    },
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = {
    enable = true
  }
}

-- lualine
require'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = 'nord',
    component_separators = {'', ''},
    section_separators = {'', ''},
    disabled_filetypes = {},
    numbers = "buffer_id"
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {
        {
            'filename',
            file_status = true,
            path = 1
        }
    },
    --lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_x = {},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
        {
            'filename',
            file_status = true,
            path = 1
        }
    },
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}

-- gitsigns
require('gitsigns').setup()
-- bufferline
require("bufferline").setup{}
EOF
""========================== Lua ==========================="

let g:indent_blankline_use_treesitter = v:true
let g:nord_cursor_line_number_background = 1
let g:nord_italic = 1
let g:nord_italic_comments = 1
let g:nord_contrast = v:true
let g:nord_borders = v:true
colorscheme nord


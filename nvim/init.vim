packadd minpac

call minpac#init()

" minpac must have {'type': 'opt'} so that it can be loaded with `packadd`.
call minpac#add('k-takata/minpac', {'type': 'opt'})

" Add other plugins here.
call minpac#add('arcticicestudio/nord-vim')
call minpac#add('vim-airline/vim-airline')
call minpac#add('rhysd/git-messenger.vim')
call minpac#add('airblade/vim-gitgutter')
call minpac#add('junegunn/fzf')
call minpac#add('junegunn/fzf.vim')
call minpac#add('liuchengxu/vista.vim')
call minpac#add('tpope/vim-fugitive')
call minpac#add('christoomey/vim-tmux-navigator')
call minpac#add('prabirshrestha/async.vim')
call minpac#add('prabirshrestha/vim-lsp')
call minpac#add('tpope/vim-surround')
call minpac#add('godlygeek/tabular')
call minpac#add('sheerun/vim-polyglot')
call minpac#add('neoclide/coc.nvim', {'branch': 'release'})
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
syntax on
filetype plugin on
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
"=========================== Misc end======================"

"=========================== Vista Start======================"
function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

let g:vista_sidebar_position = 'vertical topleft'
let g:vista_sidebar_width = 50
let g:vista_echo_cursor_strategy = 'echo'

let g:vista_executive_for = {
  \ 'c': 'vim_lsp',
  \ }
"=========================== Vista End======================"

"=========================== Airline Start======================"
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.dirty='⚡'

" Mode symbols
let g:airline_mode_map = {} " see source for the defaults
let g:airline_mode_map = {
  \ '__'     : '-',
  \ 'c'      : 'C',
  \ 'i'      : 'I',
  \ 'ic'     : 'I',
  \ 'ix'     : 'I',
  \ 'n'      : 'N',
  \ 'multi'  : 'M',
  \ 'ni'     : 'N',
  \ 'no'     : 'N',
  \ 'R'      : 'R',
  \ 'Rv'     : 'R',
  \ 's'      : 'S',
  \ 'S'      : 'S',
  \ ''     : 'S',
  \ 't'      : 'T',
  \ 'v'      : 'V',
  \ 'V'      : 'V',
  \ ''     : 'V',
  \ }

" Sections
"let g:airline_section_b = airline#section#create([
"            \ 'branch',
"            \])
"let g:airline_section_z = airline#section#create([
"            \ 'line',
"            \ 'column'
"            \])

" Extensions
"let g:airline#extensions#gutentags#enabled = 1
let g:airline#extensions#branch#enabled = 1
"=========================== Airline End======================"

"=========================== FZF Start======================"
set rtp+=~/.fzf

" Command for git grep
" - fzf#vim#grep(command, with_column, [options], [fullscreen])
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)

" Override Colors command. You can safely do this in your .vimrc as fzf.vim
" will not override existing commands.
command! -bang Colors
  \ call fzf#vim#colors({'left': '15%', 'options': '--reverse --margin 30%,0'}, <bang>0)

" Augmenting Ag command using fzf#vim#with_preview function
"   * fzf#vim#with_preview([[options], [preview window], [toggle keys...]])
"     * For syntax-highlighting, Ruby and any of the following tools are required:
"       - Bat: https://github.com/sharkdp/bat
"       - Highlight: http://www.andre-simon.de/doku/highlight/en/highlight.php
"       - CodeRay: http://coderay.rubychan.de/
"       - Rouge: https://github.com/jneen/rouge
"
"   :Ag  - Start fzf with hidden preview window that can be enabled with "?" key
"   :Ag! - Start fzf in fullscreen and display the preview window above
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

" Similarly, we can apply it to fzf#vim#grep. To use ripgrep instead of ag:
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview({ 'options': '-e' }, 'right:50%:hidden', '?'),
  \   <bang>0)

" Likewise, Files command with preview window
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"
let $FZF_DEFAULT_OPTS=' --color=dark --color=fg:15,bg:-1,hl:1,fg+:#ffffff,bg+:0,hl+:1 --color=info:0,prompt:0,pointer:12,marker:4,spinner:11,header:-1 --layout=reverse  --margin=1,4'
let g:fzf_layout = { 'window': 'call FloatingFZF()' }

function! FloatingFZF()
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, '&signcolumn', 'no')

  let height = float2nr(30)
  let width = float2nr(150)
  let horizontal = float2nr((&columns - width) / 2)
  let vertical = 1

  let opts = {
        \ 'relative': 'editor',
        \ 'row': vertical,
        \ 'col': horizontal,
        \ 'width': width,
        \ 'height': height,
        \ 'style': 'minimal'
        \ }

  call nvim_open_win(buf, v:true, opts)
endfunction

nnoremap <silent> <C-p> :call fzf#vim#files('.', {'options': '--prompt ""'})<CR>
nnoremap <silent> <leader>b :Buffers<CR>

" Advanced customization using autoload functions
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})
"=========================== FZF End======================"

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
"=========================== Shortcuts End======================"

"=========================== LSP Registration ======================"
set updatetime=300
let g:lsp_diagnostics_enabled = 0         " disable diagnostics support
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
" use <c-space>for trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

"if executable('clangd')
"    au User lsp_setup call lsp#register_server({
"            \ 'name': 'clangd',
"            \ 'cmd': {server_info->['clangd', '--background-index', '-j=8']},
"            \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), ['cscope.files', 'compile_commands.json']))},
"            \ 'whitelist': ['c', 'cpp'],
"            \ })
"endif

" Register ccls C++ lanuage server.
if executable('ccls')
   au User lsp_setup call lsp#register_server({
      \ 'name': 'ccls',
      \ 'cmd': {server_info->['ccls']},
      \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), ['cscope.files', 'compile_commands.json']))},
      \ 'initialization_options': {'cache': {'directory': '/tmp/ccls/cache' }},
      \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc', 'h'],
      \ })
endif
nnoremap <leader>s :LspReferences<cr>
nnoremap <leader>g :LspDefinition<cr>
"=========================== LSP Registration END======================"

""=========================== Ale Plugin ======================"
"let g:ale_linters = {
"    \   'c': ['clangd'],
"    \}
"" Only run linters named in ale_linters settings.
"let g:ale_linters_explicit = 1
""=========================== Ale Plugin End ======================"
colorscheme nord

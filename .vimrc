set nocompatible

" set leader to ,
let mapleader = ";"

call plug#begin('~/.vim/plugged')

Plug '/usr/local/opt/fzf'
Plug 'SirVer/ultisnips'
Plug 'ap/vim-css-color'
Plug 'itchyny/lightline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'jremmen/vim-ripgrep'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'justinmk/vim-sneak'
Plug 'mattn/emmet-vim'
Plug 'mustache/vim-mustache-handlebars'
Plug 'pangloss/vim-javascript'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-surround'
Plug 'vim-ruby/vim-ruby'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/diagnostic-nvim'
" Plug 'w0rp/ale'
" Plug 'Valloric/youcompleteme', { 
"   \   'do': './install.py --clangd-completer --rust-completer --java-completer --ts-completer'
"   \ }
Plug 'prettier/vim-prettier', {
  \   'do': 'yarn install',
  \   'branch': 'release/1.x'
  \ } 

call plug#end()

" lua configurations
lua << EOF
  local nvim_lsp = require'nvim_lsp'
  nvim_lsp.solargraph.setup{}
  nvim_lsp.tsserver.setup{}
  nvim_lsp.clangd.setup{}
  nvim_lsp.jdtls.setup{
    root_dir = nvim_lsp.util.root_pattern('*')
  }
EOF

" Use completion-nvim and diagnostic-nvim in every buffer
autocmd BufEnter * lua require'completion'.on_attach()
autocmd BufEnter * lua require'diagnostic'.on_attach()

set nowrap                                              " do not wrap long lines
set hidden                                              " buffers stay alive
set linespace=3                                         " add space between lines in Gvim
set clipboard=unnamedplus                               " sync with system clipboard
set laststatus=2                                        " show status line always
set noshowmode                                          " don't show mode status in bottom
set shortmess+=F                                        " don't show filename o startup
set encoding=utf-8                                      " use UTF-8 encoding internally
set tabstop=2                                           " The width of a TAB
set shiftwidth=2                                        " Indents will have a width of 2
set softtabstop=2                                       " Sets the number of columns for a TB
set expandtab                                           " Expand TABs to spaces
set ttimeoutlen=0                                       " reduce delay on pressing escape
set fillchars=""                                        " remove split line
set number                                              " Show hybridline number
set nohlsearch                                          " search highlight
set noswapfile                                          " do not create swap files
set spelllang=en_us                                     " set spellcheck
set formatprg=par\ -w80ej                               " set par as default formatter and format the text to a text width of 80 chars, removes superflues lines (e), and justify the text (j)
set cursorline                                          " show cursor line
set mouse=a                                             " enable scrolling with mouse

" performance optimization settings
syntax sync minlines=256                                " limit syntax highlighting for lines
set synmaxcol=200                                       " limit syntax highlighting for columns
set lazyredraw                                          " lazy redraw for performance

" set filetype specific tab formatting
filetype plugin indent on

" ruby settings
autocmd FileType ruby nnoremap <silent> gd <C-]>

" color settings
" override colorsheme - must be before setting colorsheme
autocmd ColorScheme onehalfdark highlight Normal guibg=#1d1f21
autocmd ColorScheme onehalfdark highlight CursorLine guibg=#26292e
autocmd ColorScheme onehalfdark highlight ColorColumn guibg=#26292b
autocmd ColorScheme onehalfdark highlight LineNr guibg=#1d1f21
autocmd ColorScheme onehalfdark highlight LineNr guifg=#555555

syntax enable                                           " enable syntax higlighting
set background=dark                                     " inform vim of dark background

:let theme = 'onehalfdark'                              " set colorscheme name here
:exe 'colorscheme ' . theme

highlight Comment cterm=italic gui=italic
highlight LineNr ctermfg=white                          " show line highlight color

" additional color settings
if (has("termguicolors"))
  set termguicolors
endif

if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

if has("gui_running")
    autocmd GUIEnter * set vb t_vb=
end

" --------------------------------------------------------------------
" NORMAL MODE KEYBINDINGS - NATIVE
" --------------------------------------------------------------------

" toggle relative numbers
nnoremap <silent> <leader>n :set relativenumber!<CR>

" scroll vertically easily
noremap <silent> zj 10<C-y>z
noremap <silent> zk 10<C-e>z

" scroll horizontal easily
noremap <silent> zh zH
noremap <silent> zl zL

" quickfix navigation
noremap <silent> ]q :cnext<CR>
noremap <silent> [q :cprevious<CR>

" map H and L for tab switching
nnoremap H gT
nnoremap L gt

" toggle cursorline
noremap <silent> <leader>c :set cursorline!<CR>

" map go to definition to ctags shortcut
" nnoremap <silent> gd <C-]>

" --------------------------------------------------------------------
" VISUAL MODE KEYBINDINGS - NATIVE
" --------------------------------------------------------------------

" retain visual selection on indent
vnoremap > >gv
vnoremap < <gv

" --------------------------------------------------------------------
" OTHER SETTINGS
" --------------------------------------------------------------------

" git settings
" --------------------------------------------------------------------
" reset file to staging version
:command! Gcos :!git checkout origin/staging %

" show file diff in tmuz pane 1
nnoremap <silent> <leader>w wy$:exe "!tmux send -t 1 'qq\b\bclear; git diff HEAD <C-R>"' Enter"<CR><CR>
nnoremap <silent> <leader>q wy$:exe "!tmux send -t 1 'qq\b\bclear; git diff --staged' Enter"<CR><CR>

" vim-fugitive key bindings
" --------------------------------------------------------------------
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>ga :Gwrite<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gl :Glog<CR>
nnoremap <silent> <leader>gr :0Glog<CR>


" vim-commentary settings
" --------------------------------------------------------------------
noremap <silent> \ :Commentary<CR>
autocmd FileType ruby setlocal commentstring=#\ %s

" neovim lsp
" --------------------------------------------------------------------
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
" nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
" nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>

" neovim completion
" --------------------------------------------------------------------
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect
" Avoid showing message extra message when using completion
set shortmess+=c
" show untisnippets in completion
let g:completion_enable_snippet = 'UltiSnips'

" neovim diagnostics
" --------------------------------------------------------------------
" don't show diagnostics on insert mode
let g:diagnostic_insert_delay = 1

" indentguide settings
" --------------------------------------------------------------------
" prevent indent when no filetype
let g:indentguides_ignorelist = ['', 'txt']

" FZF settings
" --------------------------------------------------------------------
nnoremap <silent> <leader>gf :GFiles<CR>
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>t :Tags<CR>
nnoremap <silent> <leader>d :Buffers<CR>
nnoremap <silent> <leader>l :Lines<CR>

" tags used by fzf
let g:fzf_tags_command = 'ctags -R --exclude=@.ctagsignore .'

" fzf actions
let g:fzf_action = {
  \ 'ctrl-n': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit'
  \ }

" Rg and then FZF
command! -bang -nargs=* Rgfzf
  \ call fzf#vim#grep(
  \   'rg --trim --column --line-number --hidden --ignore-case --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
  \   <bang>0)

" Interactive RG
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

" open interactive RG
command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" open interactive RG - shortcut
nnoremap <silent> <leader><leader>f :RG!<CR>

" Rg word under cursor and fzf
nnoremap <silent> <leader>z yiw:Rgfzf <C-R>"<CR>

" what is this
set rtp+=~/.fzf

" --------------------------------------------------------------------
" CUSTOM COMMANDS
" --------------------------------------------------------------------

" prose mode
" --------------------------------------------------------------------
" toggle write mode
:command! WM call SwitchWriteMode()
" toggle code mode
:command! CM call SwitchCodeMode()

function SwitchWriteMode()
  set background=light
  setlocal spell
  colorscheme solarized8_high
  Goyo
endfunction

function SwitchCodeMode()
  set background=dark
  Goyo!
  :exe 'colorscheme ' . g:theme
  setlocal nospell
endfunction

" autocmd BufNewFile,BufRead *.txt,*.md :WM
" autocmd BufUnload *.txt,*.md :CM

" netrw settings
" --------------------------------------------------------------------
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_browse_split = 1
let g:netrw_winsize = 20
let g:netrw_altv = 1

" Emmet config
" --------------------------------------------------------------------
" redefine trigger key
" let g:user_emmet_leader_key='k'
let g:user_emmet_expandabbr_key = ';;'

let g:user_emmet_settings = {
  \  'html' : {
  \    'snippets' : {
  \          'd': "<div class=\"|\">\n</div>",
  \     },
  \   },
  \ }

let g:user_emmet_install_global = 0
autocmd FileType html,css,hbs EmmetInstall
let g:user_emmet_mode='i'

" lightline settings
" --------------------------------------------------------------------
" show relative project root path
let g:lightline = {
      \ 'colorscheme': theme,
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \ }
      \ }

function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction

" you complete me settings
" --------------------------------------------------------------------
" Start autocompletion after 4 chars
" let g:ycm_min_num_of_chars_for_completion = 4
" let g:ycm_min_num_identifier_candidate_chars = 4
" let g:ycm_enable_diagnostic_highlighting = 0
" " Don't show YCM's preview window
" set completeopt-=preview
" let g:ycm_add_preview_to_completeopt = 0
" let g:ycm_semantic_triggers = {
"     \   'css': [ 're!^', 're!^\s+', ': ' ],
"     \   'scss': [ 're!^', 're!^\s+', ': ' ],
"     \ }

" vim-rails settings
" --------------------------------------------------------------------
noremap <silent> <leader>r :R<CR>
noremap <silent> <leader>a :A<CR>

" ale linter settings
" --------------------------------------------------------------------
let g:ale_linters = {
  \ 'ruby': ['rubocop'],
  \ 'javascript': ['eslint'],
  \ }

let g:ale_java_javac_sourcepath = 'src'
" let g:ale_java_javac_classpath = '/Users/elelango/lox/bin'
" let g:ale_java_javac_executable = 'src'
" let g:ale_java_javac_sourcepath = './src'

let g:ale_fixers = {
  \ 'ruby': ['rubocop'],
  \ 'javascript': ['eslint'],
  \ }

" prettier first and then fix lint
noremap <silent> <leader>p :Prettier<CR>:ALEFix<CR>

" fix lint on save
" let g:ale_fix_on_save = 1

" vim sneak settings
" --------------------------------------------------------------------
map f <Plug>Sneak_s
map F <Plug>Sneak_S
let g:sneak#label = 1
hi! link Sneak Search

" ultisnips
" --------------------------------------------------------------------
" override default tab to expand
let g:UltiSnipsExpandTrigger = '<f5>'


set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
set nocompatible

" automatically install vim-plug in absence
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug '/usr/local/opt/fzf'
Plug 'SirVer/ultisnips'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'justinmk/vim-sneak'
Plug 'mustache/vim-mustache-handlebars'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-rails'
Plug 'w0rp/ale'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/diagnostic-nvim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'prettier/vim-prettier', {
  \   'do': 'yarn install',
  \   'branch': 'release/1.x'
  \ } 

call plug#end()

let mapleader = ";"                                     " set leader to ,

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
set cursorline                                          " show cursor line
set mouse=a                                             " enable scrolling with mouse

" performance optimization settings
syntax sync minlines=256                                " limit syntax highlighting for lines
set synmaxcol=200                                       " limit syntax highlighting for columns
set lazyredraw                                          " lazy redraw for performance

" set filetype specific tab formatting
filetype plugin indent on

" ruby settings
" autocmd FileType ruby nnoremap <silent> gd <C-]>

" markdown settings
au BufRead,BufNewFile *.md setlocal textwidth=80

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
:exe 'colorscheme ' g:theme

highlight Comment cterm=italic gui=italic

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

" --------------------------------------------------------------------
" VISUAL MODE KEYBINDINGS - NATIVE
" --------------------------------------------------------------------

" retain visual selection on indent
vnoremap > >gv
vnoremap < <gv

" --------------------------------------------------------------------
" STATUS LINE SETTINGS
" --------------------------------------------------------------------
function! StatusLine()
    return luaeval("require'status-line'.statusLine()")
endfunction

set statusline=%!StatusLine()

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

" netrw settings
" --------------------------------------------------------------------
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_browse_split = 1
let g:netrw_winsize = 20
let g:netrw_altv = 1

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

let g:ale_linters_explicit = 1                          " Only run linters named in ale_linters settings.

let g:ale_java_javac_sourcepath = 'src'                 " set source path for java files

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
let g:UltiSnipsExpandTrigger = '<f5>'                   " override default tab to expand

" goyo prose mode
" --------------------------------------------------------------------
:command! WM call SwitchWriteMode()                     " toggle write mode
:command! CM call SwitchCodeMode()                      " toggle code mode

function SwitchWriteMode()
  set background=light
  setlocal spell
  colorscheme solarized8_high
  Goyo
endfunction

function SwitchCodeMode()
  set background=dark
  Goyo!
  :exe 'colorscheme ' g:theme
  setlocal nospell
endfunction

" autocmd BufNewFile,BufRead *.txt,*.md :WM
" autocmd BufUnload *.txt,*.md :CM

" neovim lsp
" --------------------------------------------------------------------
lua << EOF
  local nvim_lsp = require'nvim_lsp'
  nvim_lsp.sumneko_lua.setup{}
  nvim_lsp.solargraph.setup{}
  nvim_lsp.tsserver.setup{}
  nvim_lsp.clangd.setup{}
  require'nvim_lsp'.rust_analyzer.setup{}
  nvim_lsp.jdtls.setup{}
  nvim_lsp.jedi_language_server.setup{}
EOF

nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gi    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.declaration()<CR>

" neovim completion
" --------------------------------------------------------------------
autocmd BufEnter * lua require'completion'.on_attach()

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

set completeopt=menuone,noinsert,noselect               " Set completeopt to have a better completion experience
set shortmess+=c                                        " Avoid showing message extra message when using completion
let g:completion_enable_snippet = 'UltiSnips'           " show untisnippets in completion

" neovim diagnostics settings
" --------------------------------------------------------------------
autocmd BufEnter * lua require'diagnostic'.on_attach()
let g:diagnostic_insert_delay = 1                       " don't show diagnostics on insert mode

" cycle through diagnostics
noremap <silent> ]w :NextDiagnosticCycle<CR>
noremap <silent> [w :PrevDiagnosticCycle<CR>

" neovim telescope settings
" --------------------------------------------------------------------
" nnoremap <Leader>f <cmd>lua require'telescope.builtin'.find_files{}<CR>
" nnoremap <Leader><Leader>f <cmd>lua require('telescope.builtin').live_grep{}<CR>
" nnoremap <Leader>d <cmd>lua require('telescope.builtin').buffers{}<CR>
" nnoremap <Leader>z <cmd>lua require('telescope.builtin').lsp_workspace_symbols{}<CR>


" neovim treesitter settings
" --------------------------------------------------------------------
lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  highlight = {
    enable = true,
  },
}
EOF


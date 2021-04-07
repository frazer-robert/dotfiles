set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
set nocompatible

" automatically install vim-plug in absence
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  au VimEnter * PlugInstall --sync | source $MYVIMRC
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
Plug 'w0rp/ale'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'junegunn/seoul256.vim'
Plug 'prettier/vim-prettier', {
  \   'do': 'yarn install',
  \   'branch': 'release/1.x'
  \ } 

call plug#end()

let mapleader = ";"                                     " set leader to ,

set nowrap                                              " do not wrap long lines
set hidden                                              " buffers stay alive
set linespace=3                                         " add space between lines in Gvim
set ignorecase                                          " case insensitive search
set smartcase                                           " but sensitive if uppercase is used
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
au FileType ruby nnoremap <silent> gd <C-]>zz

" markdown settings
" augroup markdown
"   au FileType markdown setlocal textwidth=80
"   au BufWinEnter *.md exe WM
"   " au BufHidden *.md call SwitchCodeMode()
" augroup end

" --------------------------------------------------------------------
" COLOR SETTINGS
" --------------------------------------------------------------------

syntax enable                                           " enable syntax higlighting
set background=dark                                     " inform vim of dark background
highlight Comment cterm=italic gui=italic

" handling setting and unsetting BAT_THEME for fzf.vim
augroup update_bat_theme
    au!
    au colorscheme * call ToggleBatEnvVar()
augroup end

function ToggleBatEnvVar()
    if (&background == "light")
        let $BAT_THEME='Solarized (light)'
    else
        let $BAT_THEME='gruvbox'
    endif
endfunction

:let theme = 'palenight'                              " set colorscheme name here
:exe 'colorscheme ' g:theme

" additional color settings
if has("termguicolors")
  set termguicolors
endif

if has("nvim")
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

if has("gui_running")
    au GUIEnter * set vb t_vb=
end

" transparent background
hi Normal guibg=NONE ctermbg=NONE
hi StatusLine guibg=NONE ctermbg=NONE
hi CursorLine guibg=#1c2a2f ctermbg=NONE

" --------------------------------------------------------------------
" NORMAL MODE KEYBINDINGS - NATIVE
" --------------------------------------------------------------------

" toggle relative numbers
nnoremap <silent> <leader>n :set relativenumber!<CR>

" scroll vertically easily
nnoremap <silent> zj 10<C-y>
nnoremap <silent> zk 10<C-e>

" scroll horizontal easily
nnoremap <silent> zh zH
nnoremap <silent> zl zL

" quickfix navigation
nnoremap <silent> ]q :cnext<CR>
nnoremap <silent> [q :cprevious<CR>

" map H and L for tab switching
nnoremap H gT
nnoremap L gt

" toggle cursorline
nnoremap <silent> <leader>c :set cursorline!<CR>

" --------------------------------------------------------------------
" VISUAL MODE KEYBINDINGS - NATIVE
" --------------------------------------------------------------------

" retain visual selection on indent
vnoremap > >gv
vnoremap < <gv

" copy contents to system clipboard while yanking
vnoremap <silent> y "+y

" --------------------------------------------------------------------
" CUSTOM COMMANDS NATIVE
" --------------------------------------------------------------------
" create a file in opened file directory
:command! -nargs=1 E :e %:h/<args>


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

" vim-fugitive key bindings
" --------------------------------------------------------------------
nnoremap <silent> <leader>gd :Gstatus<CR>
nnoremap <silent> <leader>ga :Gwrite<CR>
nnoremap <silent> <leader><leader>c :Git commit<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gl :Glog<CR>
nnoremap <silent> <leader>gr :0Glog<CR>

:command! Gc :Gcommit

" vim-commentary settings
" --------------------------------------------------------------------
noremap <silent> \ :Commentary<CR>
au FileType ruby setlocal commentstring=#\ %s

" FZF settings
" --------------------------------------------------------------------
" tags used by fzf
let g:fzf_tags_command = 'ctags -R --exclude=@.ctagsignore .'

" fzf actions
let g:fzf_action = {
  \ 'ctrl-n': 'tab split',
  \ 'ctrl-v': 'vsplit'
  \ }

" default preview window settings
let g:fzf_preview_window = ['right:60%', 'ctrl-/']

" respect vim colorscheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>t :Tags<CR>
nnoremap <silent> <leader>d :Buffers<CR>
nnoremap <silent> <leader>l :Lines<CR>
nnoremap <silent> <leader>gs :GF!?<CR>
nnoremap <silent> <leader><leader>h :Commits!<CR>
nnoremap <silent> <leader><leader>b :BCommits!<CR>
" search in dir of currently viewing file
nnoremap <silent> <leader>h :Files %:p:h<CR>

" open interactive RG
command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" open interactive RG - shortcut
nnoremap <silent> <leader><leader>f :RG!<CR>

" Rg word under cursor and fzf
nnoremap <silent> <leader>z yiw:Rgfzf! <C-R>"<CR>

" Interactive RG
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

" Rg and then FZF
command! -bang -nargs=* Rgfzf
  \ call fzf#vim#grep(
  \   'rg --trim --column --line-number --hidden --ignore-case --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
  \   <bang>0)

let preview = printf(
    \ 'bash -c "if [[ {1} =~ \? ]]; then %s; else %s; fi"',
    \ 'git diff /dev/null {-1} | delta --file-style=omit | sed 1d',
    \ 'git diff HEAD -- {-1} | delta --file-style=omit | sed 1d'
    \ )

" stage unstage interactively with fzf
command! -bang -nargs=? -complete=dir GFiles
    \ call fzf#vim#gitfiles(<q-args>, {'options': 
    \ ['--layout', 'reverse',
    \  '--cycle',
    \  '--preview-window', 'right:70%',
    \  '--preview', preview,
    \  '--bind', 'ctrl-x:execute-silent($HOME/.config/nvim/grm.sh {1} {2})+reload(git -c color.status=always status --short --untracked-files=all)',
    \  '--bind', 'ctrl-s:execute-silent($HOME/.config/nvim/gst.sh {1} {2})+reload(git -c color.status=always status --short --untracked-files=all)']}, <bang>0)

" netrw settings
" --------------------------------------------------------------------
let g:netrw_liststyle = 3
" let g:netrw_banner = 0
let g:netrw_browse_split = 1
let g:netrw_winsize = 20
let g:netrw_altv = 1

" vim-rails settings
" --------------------------------------------------------------------
nnoremap <silent> <leader>r :R<CR>
nnoremap <silent> <leader>a :A<CR>

" ale linter settings
" --------------------------------------------------------------------
let g:ale_linters = {
  \ 'ruby': ['rubocop'],
  \ 'javascript': ['eslint'],
  \ 'rust': ['cargo'],
  \ }

let g:ale_linters_explicit = 1                          " Only run linters named in ale_linters settings.
let g:ale_rust_cargo_use_clippy = 1                     " use cargo clippy instead of cargo check
" let g:ale_java_javac_sourcepath = 'src'                 " set source path for java files

let g:ale_fixers = {
  \ 'ruby': ['rubocop'],
  \ 'javascript': ['eslint'],
  \ 'rust': ['rustfmt'],
  \ }

" prettier first and then fix lint
nnoremap <silent> <leader>p :Prettier<CR>:ALEFix<CR>

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
  Goyo x35
endfunction

function SwitchCodeMode()
  set background=dark
  Goyo!
  :exe 'colorscheme ' g:theme
  setlocal nospell
endfunction

" au BufNewFile,BufRead *.txt,*.md :WM
" au BufUnload *.txt,*.md :CM

" neovim lsp
" --------------------------------------------------------------------
lua << EOF
  local lsp = require'lspconfig'
  lsp.html.setup{}
  lsp.tsserver.setup{}
  lsp.clangd.setup{}
  lsp.gopls.setup{}
  lsp.rust_analyzer.setup{}
  lsp.jedi_language_server.setup{}
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
au BufEnter * lua require'completion'.on_attach()

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

set completeopt=menuone,noinsert,noselect               " Set completeopt to have a better completion experience
set shortmess+=c                                        " Avoid showing message extra message when using completion
let g:completion_enable_snippet = 'UltiSnips'           " show untisnippets in completion

" neovim diagnostics settings
" --------------------------------------------------------------------

" cycle through diagnostics
nnoremap <silent> ]w <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <silent> [w <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>

lua << EOF
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    signs = true,
    update_in_insert = false,
  }
)
EOF

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


set nocompatible              
                                                                                                                                                          
" automatically install vim-plug in absence
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug '/usr/local/opt/fzf'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'

call plug#end()

let mapleader = ";"                                     " set leader to ,

set nowrap                                              " do not wrap long lines
set hidden                                              " buffers stay alive
set laststatus=2                                        " show status line always
set ignorecase                                          " case insensitive search
set smartcase                                           " but sensitive if uppercase is used
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
set mouse=a                                             " enable scrolling with mouse

" performance optimization settings
syntax sync minlines=256                                " limit syntax highlighting for lines
set synmaxcol=200                                       " limit syntax highlighting for columns
set lazyredraw                                          " lazy redraw for performance

" set filetype specific tab formatting
filetype plugin indent on

syntax enable                                           " enable syntax higlighting
set background=dark                                     " inform vim of dark background

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

" noremap <silent> ]q :cnext<CR>
" noremap <silent> [q :cprevious<CR>

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

" vim sneak settings
" --------------------------------------------------------------------
map f <Plug>Sneak_s
map F <Plug>Sneak_S
let g:sneak#label = 1
hi! link Sneak Search

" status line settings
" --------------------------------------------------------------------
set statusline=
set statusline+=%2n\ 
set statusline+=%f
set statusline+=\ 
set statusline+=%m%h%r%w
set statusline+=%=
set statusline+=%{FugitiveHead()!=''?FugitiveHead().'\ \|\ ':''}
set statusline+=%{&fileformat}
set statusline+=\ \|\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=%{&ft!=''?'\ \ \|\ '.&ft:''}
set statusline+=\ %-7(%4l:%-2c%)
set statusline+=\ 

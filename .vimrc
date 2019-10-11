﻿filetype off

if has('kaoriya')
    let g:no_vimrc_example=0
    let g:vimrc_local_finish=1
    let g:gvimrc_local_finish=1

	"$VIM/plugins/kaoriya/autodate.vim
	let plugin_autodate_disable  = 1
	"$VIM/plugins/kaoriya/cmdex.vim
	let plugin_cmdex_disable     = 1
	"$VIM/plugins/kaoriya/dicwin.vim
	let plugin_dicwin_disable    = 1
	"$VIMRUNTIME/plugin/format.vim
	let plugin_format_disable    = 1
	"$VIM/plugins/kaoriya/hz_ja.vim
	let plugin_hz_ja_disable     = 1
	"$VIM/plugins/kaoriya/scrnmode.vim
	let plugin_scrnmode_disable  = 1
	"$VIM/plugins/kaoriya/verifyenc.vim
	let plugin_verifyenc_disable = 1
endif

"Plugin managed by dein.vim
"installing directory
let s:dein_dir = expand('~\vimfiles\dein')
" dir of dein.vim
let s:dein_repo_dir = s:dein_dir . '\repos\github.com\Shougo\dein.vim'

"download dein.vim if there's no dein.vim
if &runtimepath !~# '\dein.vim'
    if !isdirectory(s:dein_repo_dir)
        execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
    endif
    execute 'set runtimepath^=' . s:dein_repo_dir
endif

"dein.vim settings
if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    "create plugins list file using TOML format beforehand
    let g:rc_dir = expand('~\dotfiles')
    let s:toml = g:rc_dir . '\dein.toml'
    let s:lazy_toml = g:rc_dir . '\dein_lazy.toml'

    "read and cache the toml files
    call dein#load_toml(s:toml, {'lazy':0})
    call dein#load_toml(s:lazy_toml, {'lazy':1})

    "end the setting
    call dein#end()
    call dein#save_state()
endif

"install if there are plugins not installed
if dein#check_install()
    call dein#install()
endif

"set backup folders
set undodir=$HOME/vimtmp/undo
set backupdir=$HOME/vimtmp/bk
set directory=$HOME/vimtmp/swap

"about search
set hlsearch
set ignorecase "search both upper/lower case
set smartcase "distinguish upper/lower if search word include upper

"completion of parentheses
imap [ []<left>
imap ( ()<left>
imap { {}<left>
" imap < <><left>

"map jj to Esc
" inoremap <silent> jj <Esc>:<C-u>w<CR>
" cnoremap <silent> jj <Esc>:<C-u>w<CR>
" inoremap <silent> ｊｊ <Esc>:<C-u>w<CR>
" cnoremap <silent> ｊｊ <Esc>:<C-u>w<CR>
inoremap <silent> jj <Esc>
cnoremap <silent> jj <Esc>
inoremap <silent> ｊｊ <Esc>
cnoremap <silent> ｊｊ <Esc>
tnoremap <silent> jj <C-\><C-n>

imap <C-j> <esc>

"key bindings of Space + another
let mapleader = "\<Space>"
noremap <Leader>v g0vg$h
noremap <Leader>d g0vg$hx
noremap <Leader>y g0vg$hy

noremap <Leader>gv 0v$h
noremap <Leader>gd 0v$hx
noremap <Leader>gy 0v$hy

"space + h/l : move to beginning/end of the line
noremap <Leader>h g^
noremap <Leader>l g$
vnoremap <Leader>l g$h

noremap <Leader>gh ^
noremap <Leader>gl $
vnoremap <Leader>gl $h

"move to the bracket counterpart
noremap <Leader>b %

"tab
set tabstop=4 "set indent to four spaces
set autoindent
set expandtab
set shiftwidth=4

"command line mode
set wildmenu
set wildmode=longest:full,full
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>
cnoremap <C-k> <Up>
cnoremap <C-j> <Down>
cnoremap <C-Space>h <Home>
cnoremap <C-Space><C-h> <Home>
cnoremap <C-Space>l <End>
cnoremap <C-Space><C-l> <End>
cnoremap <C-d> <Del>

"etc.
set ruler
set number "display line number
" set relativenumber
set title "display file name
set showmatch "show corresponding bracket
set showcmd
set clipboard=unnamed
set mouse=a
set iminsert=0
set imsearch=-1
set incsearch
set t_Co=256
set wrap
set breakindent
set linebreak
set virtualedit+=block "enable to select place w/o character in <C-v> mode
set matchpairs+=<:>
set belloff=all
set noshowmode
set conceallevel=0
set ambiwidth=double
let g:indentLine_char = '¦'
noremap j gj
noremap k gk
noremap gj j
noremap gk k

augroup etcSettingsGroup
    autocmd!
    autocmd BufRead,BufNewFile *.toml set filetype=conf
    autocmd QuickFixCmdPost *grep* cwindow
augroup END

"always search in very magic mode
nnoremap / /\v

"lightline
let g:lightline = {
        \ 'colorscheme': 'one',
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ],
        \   'right': [ ['lineinfo'], ['fileformat', 'fileencoding', 'filetype'] ]
        \ },
        \ 'inactive': {
        \   'left': [['filename']],
        \   'right': [['lineinfo'], ['filetype']]
        \ },
        \ 'component_function': {
        \   'modified': 'LightlineModified',
        \   'readonly': 'LightlineReadonly',
        \   'fugitive': 'LightlineFugitive',
        \   'filename': 'LightlineFilename',
        \   'fileformat': 'LightlineFileformat',
        \   'filetype': 'LightlineFiletype',
        \   'fileencoding': 'LightlineFileencoding',
        \   'mode': 'LightlineMode'
        \ }
\ }

function! LightlineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! LightlineFilename()
  return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
    return fugitive#head()
  else
    return ''
  endif
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction
"end lightline

" nnoremap <C-p> :bnext<CR>
" nnoremap <C-n> :bprevious<CR>

"vim-anzu
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star-with-echo)N
nmap # <Plug>(anzu-sharp-with-echo)
set statusline=%{anzu#search_status()}
"hide highlight and anzu-status
nmap <silent><esc><esc> :nohlsearch<CR><esc> <Plug>(anzu-clear-search-status)

"window
nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap sr <C-w>r
nnoremap sR <C-w>R
nnoremap s= <C-w>=
nnoremap sO <C-w>=
nnoremap sw <C-w>w
nnoremap so :<C-u>vertical res<CR><C-w>_
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>bd<CR>
nnoremap sc :<C-u>only<CR>
nnoremap s> <C-w>>
nnoremap s< <C-w><
nnoremap s+ <C-w>+
nnoremap s- <C-w>-
call submode#enter_with('bufmove', 'n', '', 's>', '<C-w>>')
call submode#enter_with('bufmove', 'n', '', 's.', '<C-w>>')
call submode#enter_with('bufmove', 'n', '', 's<', '<C-w><')
call submode#enter_with('bufmove', 'n', '', 's,', '<C-w><')
call submode#enter_with('bufmove', 'n', '', 's+', '<C-w>+')
call submode#enter_with('bufmove', 'n', '', 's;', '<C-w>+')
call submode#enter_with('bufmove', 'n', '', 's-', '<C-w>-')
call submode#enter_with('bufmove', 'n', '', 's=', '<C-w>-')
call submode#map('bufmove', 'n', '', '>', '<C-w>>')
call submode#map('bufmove', 'n', '', '.', '<C-w>>')
call submode#map('bufmove', 'n', '', '<', '<C-w><')
call submode#map('bufmove', 'n', '', ',', '<C-w><')
call submode#map('bufmove', 'n', '', '+', '<C-w>+')
call submode#map('bufmove', 'n', '', ';', '<C-w>+')
call submode#map('bufmove', 'n', '', '-', '<C-w>-')
call submode#map('bufmove', 'n', '', '=', '<C-w>-')
call submode#leave_with('bufmove', 'n', '', 'e')

" submode
call submode#enter_with('changetab', 'n', '', 'sn', 'gt')
call submode#enter_with('changetab', 'n', '', 'sp', 'gT')
call submode#map('changetab', 'n', '', 'n', 'gt')
call submode#map('changetab', 'n', '', 'p', 'gT')
call submode#leave_with('changetab', 'n', '', 'e')
call submode#enter_with('undo/redo', 'n', '', 'g-', 'g-')
call submode#enter_with('undo/redo', 'n', '', 'g+', 'g+')
call submode#map('undo/redo', 'n', '', '-', 'g-')
call submode#map('undo/redo', 'n', '', '+', 'g+')
call submode#leave_with('undo/redo', 'n', '', 'e')
call submode#enter_with('winmove', 'n', '', 'sl', '<C-w>l')
call submode#enter_with('winmove', 'n', '', 'sh', '<C-w>h')
call submode#enter_with('winmove', 'n', '', 'sj', '<C-w>j')
call submode#enter_with('winmove', 'n', '', 'sk', '<C-w>k')
call submode#map('winmove', 'n', '', 'l', '<C-w>l')
call submode#map('winmove', 'n', '', 'h', '<C-w>h')
call submode#map('winmove', 'n', '', 'j', '<C-w>j')
call submode#map('winmove', 'n', '', 'k', '<C-w>k')
call submode#leave_with('winmove', 'n', '', 'e')
let g:submode_always_show_submode = 1
let g:submode_timeoutlen = 2000


"tab
nnoremap st :<C-u>tabnew<CR>
nnoremap sT :<C-u>Unite tab<CR>

"buffer
nnoremap sN :<C-u>bn<CR>
nnoremap sP :<C-u>bp<CR>
nnoremap sb :<C-u>Unite buffer_tab -buffer-name=file<CR>
nnoremap sB :<C-u>Unite buffer -buffer-name=file<CR>

"NERDTree
nnoremap <silent><leader>t :NERDTreeToggle<CR>
let g:NERDTreeShowBookmarks=1
let g:NERDTreeShowHidden=1
let g:NERDTreeChDirMode=2
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

augroup nerdTreeGroup
    autocmd!
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
augroup END

"vim-easymotion
let g:EasyMotion_smartcase = 1

"restart
let g:restart_sessionoptions = 'blank,buffers,curdir,folds,help,localoptions,tabpages'

"vim-commentary
augroup vimCommentaryGroup
    autocmd!
    autocmd FileType matlab setlocal commentstring=%\ %s
augroup END

"ale
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_insert_leave = 1
let g:ale_fix_on_save = 1
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 0
let g:ale_open_list = 0
let g:ale_keep_list_window_open = 0
let g:ale_linters = {
\   'python': ['pylint'],
\   'matlab': ['mlint'],
\}
let g:ale_fixers = {
\   'python': ['autopep8'],
\}

"encoding
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8
set fileencodings+=utf-8,euc-jp,iso-2022-jp,ucs-2le,ucs-2,cp932

"ctags
set tags=./.tags;,.tags;
nnoremap tjc g<C-]>
nnoremap <silent>tjl :vsp<CR> <C-w>l :exe("tjump ".expand('<cword>'))<CR>
nnoremap <silent>tjh :vsp<CR> :exe("tjump ".expand('<cword>'))<CR>
nnoremap <silent>tjj :sp<CR> <C-w>j :exe("tjump ".expand('<cword>'))<CR>
nnoremap <silent>tjk :sp<CR> :exe("tjump ".expand('<cword>'))<CR>

"markdown
augroup markdownGroup
    autocmd!
    autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END

"colorscheme
" deopleteのポップアップ色の変更
augroup colorSchemeGroup
    autocmd!
    autocmd ColorScheme * highlight Pmenu ctermfg=255 ctermbg=55 guifg=#ffffff guibg=#3c2ba0
    autocmd ColorScheme * highlight PmenuSel ctermfg=255 ctermbg=27 guifg=#ffffff guibg=#4174f4

    " カーソル行,列の色
    set cursorline
    autocmd ColorScheme * highlight CursorLine guibg=#28516f
    " set cursorcolumn
    " autocmd ColorScheme * highlight CursorColumn guibg=#28516f

    autocmd ColorScheme * highlight Visual ctermbg=244 guibg=#646464
    autocmd ColorScheme * highlight LineNr ctermbg=12 guifg=#b0c4de
    autocmd ColorScheme * highlight Comment ctermfg=12 guifg=#34a4eb
    autocmd ColorScheme * highlight IncSearch ctermfg=0 ctermbg=226 guifg=#000000 guibg=#ffff00
    autocmd ColorScheme * highlight Search ctermfg=0 ctermbg=42 guifg=#000000 guibg=#66cdaa
    autocmd ColorScheme * highlight VertSplit ctermfg=2 ctermbg=2 guifg=#1c47b2 guibg=#1c47b2
augroup END

colorscheme cobalt2
syntax on

" Folding
augroup foldingGroup
    autocmd!
    autocmd ColorScheme * highlight Folded gui=bold guifg=LightGreen
augroup END

" restore vimsession
augroup RestoreVimSession
    autocmd!
    autocmd VimLeave * mks! ~/session.vim
augroup END

"use only when delete plugins
" call map(dein#check_clean(), "delete(v:val, 'rf')")
"after above, execute :call dein#recache_runtimepath()

filetype plugin indent on

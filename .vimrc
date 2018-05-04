"	    for OpenVMS:  sys$login:.gvimrc

" Make external commands work through a pipe instead of a pseudo-tty
"set noguipty

" set the X11 font to use
" set guifont=-misc-fixed-medium-r-normal--14-130-75-75-c-70-iso8859-1

set ch=2		" Make command line two lines high

set mousehide		" Hide the mouse when typing text

set background=dark
" Отображение выполняемой команды
set showcmd
"Для распознавания русской раскладки при вводе команд
"set langmap=ёйцукенгшщзхъфывапролдэячсмить;`qwertyuiop[]asdfghjkl'zxcvbnm
"
set keymap=russian-jcukenwin
set imsearch=0
" По умолчанию - латинская раскладка
set iminsert=0

" использовать Ctrl+L для переключения раскладок
cmap <silent> <C-L> <C-^>
imap <silent> <C-L> <C-^><Esc>a
nmap <silent> <C-L> a<C-^><Esc>
vmap <silent> <C-L> <Esc>a<C-^><Esc>

setlocal spell spelllang=ru_ru,en_us
set nospell " Включать spell будем вручную

" Размер табуляции по умолчанию
set shiftwidth=4
set softtabstop=4
set tabstop=4

" Формат строки состояния. Альтернативные варианты настройки `:h statusline`
set statusline=%<%f%h%m%r%=format=%{&fileformat}\ file=%{&fileencoding}\ enc=%{&encoding}\ %b\ 0x%B\ %l,%c%V\ %P
set laststatus=2

set wildmenu
set smartindent
filetype plugin on
filetype indent on

colorscheme elflord
set completeopt=longest,menuone " Опции автодополнения

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

nnoremap <silent><C-j> m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><C-k> m`:silent -g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent>j :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent>k :set paste<CR>m`O<Esc>``:set nopaste<CR>

" Tab wrapper
"function! InsertTabWrapper(direction)
	"let col = col(".") - 1
	"if !col || getline(".")[col-1] !~ '\k'
		"return "\<tab>"
	"elseif "backward" == a:direction
		"return "\<c-p>"
	"else
		"return "\<c-n>"
	"endif
"endfunction
"inoremap <tab> <c-r>=InsertTabWrapper("forward")<cr>
"inoremap <s-tab> <c-r>=InsertTabWrapper("backward")<cr>

" Only do this for Vim version 5.0 and later.
if version >= 500

  " I like highlighting strings inside C comments
  let c_comment_strings=1

  " Switch on syntax highlighting if it wasn't on yet.
  if !exists("syntax_on")
    syntax on
  endif

  " Switch on search pattern highlighting.
  set hlsearch

  " For Win32 version, have "K" lookup the keyword in a help file
  "if has("win32")
  "  let winhelpfile='windows.hlp'
  "  map K :execute "!start winhlp32 -k <cword> " . winhelpfile <CR>
  "endif

  " Set nice colors
  " background for normal text is light grey
  " Text below the last line is darker grey
  " Cursor is green, Cyan when ":lmap" mappings are active
  " Constants are not underlined but have a slightly lighter background
  highlight Normal guibg=grey90
  highlight Cursor guibg=Green guifg=NONE
  highlight lCursor guibg=Cyan guifg=NONE
  highlight NonText guibg=grey80
  highlight Constant gui=NONE guibg=grey95
  highlight Special gui=NONE guibg=grey95
:endif


" Настройка плагинного менеджера 
call plug#begin('~/.vim/plugged')

Plug 'majutsushi/tagbar'              " Class/module browser

Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jreybert/vimagit'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/vim-github-dashboard'
Plug 'Shougo/neocomplete'

Plug 'klen/python-mode'               " Python mode (docs, refactor, lints, highlighting, run and ipdb and more)
Plug 'davidhalter/jedi-vim'           " Jedi-vim autocomplete plugin

" Initialize pligin system
call plug#end()

"  при переходе за границу в 80 символов в Ruby/Python/js/C/C++ подсвечиваем на темном фоне текст
augroup vimrc_autocmds
    autocmd!
    autocmd FileType ruby,python,javascript,c,cpp highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType ruby,python,javascript,c,cpp match Excess /\%80v.*/
    autocmd FileType ruby,python,javascript,c,cpp set nowrap
augroup END

" TagBar настройки
map <F4> :TagbarToggle<CR>
let g:tagbar_autofocus = 0 " автофокус на Tagbar при открытии
 
" NerdTree настройки
" показать NERDTree на F3
map <F3> :NERDTreeToggle<CR>
"игноррируемые файлы с расширениями
let NERDTreeIgnore=['\~$', '\.pyc$', '\.pyo$', '\.class$', 'pip-log\.txt$', '\.o$']  
 

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

let mapleader = ","

" airline configs
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

let g:airline_theme='wombat'
let g:airline_extensions = ['branch']

" end airline configs

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

let g:github_dashboard = { 'username': 'Viktorokh96' }


" Dashboard window position
" - Options: tab, top, bottom, above, below, left, right
" - Default: tab
let g:github_dashboard['position'] = 'top'

" Disable Emoji output
" - Default: only enable on terminal Vim on Mac
let g:github_dashboard['emoji'] = 0

" Customize emoji (see http://www.emoji-cheat-sheet.com/)
let g:github_dashboard['emoji_map'] = {
\   'user_dashboard': 'blush',
\   'user_activity':  'smile',
\   'repo_activity':  'laughing',
\   'ForkEvent':      'fork_and_knife'
\ }

" Command to open link URLs
" - Default: auto-detect
let g:github_dashboard['open_command'] = 'open'

" API timeout in seconds
" - Default: 10, 20
let g:github_dashboard['api_open_timeout'] = 10
let g:github_dashboard['api_read_timeout'] = 20

" Do not set statusline
" - Then you can customize your own statusline with github_dashboard#status()
let g:github_dashboard['statusline'] = 0

" Neocomplete ------------------

"Note: This option must be set in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
"inoremap <expr><C-g>     neocomplete#undo_completion()
"inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'


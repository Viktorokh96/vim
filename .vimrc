"	    for OpenVMS:  sys$login:.gvimrc

" Make external commands work through a pipe instead of a pseudo-tty
"set noguipty

" set the X11 font to use
" set guifont=-misc-fixed-medium-r-normal--14-130-75-75-c-70-iso8859-1

set ch=2		" Make command line two lines high

set mousehide		" Hide the mouse when typing text

set background=dark
" По умолчанию - латинская раскладка
set iminsert=0
" Отображение выполняемой команды
set showcmd
"Для распознавания русской расскладки при вводе команд
set langmap=ёйцукенгшщзхъфывапролдэячсмить;`qwertyuiop[]asdfghjkl'zxcvbnm

set wildmenu
set smartindent

filetype plugin on
filetype indent on

colorscheme desert
set completeopt=longest,menuone " Опции автодополнения

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

nnoremap <silent><C-j> m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><C-k> m`:silent -g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent>j :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent>k :set paste<CR>m`O<Esc>``:set nopaste<CR>

" Tab wrapper
function! InsertTabWrapper(direction)
	let col = col(".") - 1
	if !col || getline(".")[col-1] !~ '\k'
		return "\<tab>"
	elseif "backward" == a:direction
		return "\<c-p>"
	else
		return "\<c-n>"
	endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper("forward")<cr>
inoremap <s-tab> <c-r>=InsertTabWrapper("backward")<cr>

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

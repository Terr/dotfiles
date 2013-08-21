"Use Vim settings, rather then Vi settings (much better!).
"This must be first, because it changes other options as a side effect.
set nocompatible

" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %

filetype plugin on
filetype indent on

set cindent
set smartindent
set autoindent
set t_Co=256

" Tab settings
set tabstop=4
set shiftwidth=4
set softtabstop=4
set fo-=t   " don't automatically wrap text when typing
"set wrap " As opposed to nowrap
set nowrap
set linebreak

" Enable line breaks/wrapping in Python files
" autocmd FileType python setlocal formatoptions+=t
autocmd! FileType * set noexpandtab " Set multiple options using set a=1|set b=2
au BufEnter,BufRead *.py call SetPythonOptions()
au BufEnter,BufRead *.php call SetPhpOptions()

function! SetPythonOptions()
	setlocal textwidth=79
	setlocal expandtab
	setlocal colorcolumn=80
	setlocal shiftround
endfunction

function! SetPhpOptions()
	setlocal noexpandtab
	setlocal shiftround
endfunction

" vim-powerline
"let g:Powerline_symbols = 'fancy'

" vim-airline
let g:airline_enable_fugitive=1
let g:airline_enable_syntastic=1
let g:airline_theme='solarized2'
"" unicode symbols (taken from airline's help page)
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_linecolumn_prefix = '␊ '
let g:airline_linecolumn_prefix = '␤ '
let g:airline_linecolumn_prefix = '¶ '
let g:airline_fugitive_prefix = '⎇ '
let g:airline_paste_symbol = 'ρ'
let g:airline_paste_symbol = 'Þ'
let g:airline_paste_symbol = '∥'

" Pathogen
call pathogen#infect()
call pathogen#helptags()

" Search
set incsearch
set hlsearch
" When 'ignorecase' and 'smartcase' are both on, if a pattern contains an uppercase letter, it is case sensitive, otherwise, it is not
set ignorecase
set smartcase

" Backup settings
set nobackup
set nowb
set noswapfile

" Automaticaly reload files changed outside of vim
"set autoread

" Ignore list for Ctrl-P
set wildmode=list:longest
set wildmenu
"set wildignore+=*.o,*.obj,*/.git/*,*.pyc,*.pyo,*.jpg,*.jpeg,*.gif,*.png,*/.svn/*,*/.hg/*
set wildignore+=*.o,*.obj,*.pyc,*.pyo,*.jpg,*.jpeg,*.gif,*.png,*/.svn/*,*/.hg/*
set wildignore+=*/.cache/*,*/cache/*

" Window settings
set showcmd
set showmode
" Line numbers
set number
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>
set mouse=a

" Disable cursor blink
set gcr=a:blinkon0

" Keep X lines above/below the cursor when scrolling
set scrolloff=7
set sidescrolloff=7
set sidescroll=1

" Rebind <Leader> key
let mapleader = ','

" Faster saving
nmap <Leader>w :w!<cr>
" Force saving files that require root permission
cmap w!! %!sudo tee > /dev/null %

" Redo visual selection after indenting
vnoremap < <gv " better indentation
vnoremap > >gv " better indentation

" Make Y behave like other capticals
map Y y$

" Move up/down to wrapped lines instead as if they were real lines
nnoremap j gj
nnoremap k gk
nnoremap <Up> gk
nnoremap <Down> gj

" Format / wrap paragraphs
vmap Q gq
nmap Q gqgq

" Sort selection
vmap s :sort<CR>

" Make vim's regex handling less weird
nnoremap / /\v
vnoremap / /\v

" Clear search highlights
noremap <silent><Leader>/ :nohls<CR>

" Prevent 'Press ENTER..' on error messages
"set shortmess=atI

" Save up to 100 marks and f1 means global marks (capital letters) are enabled
set viminfo='100,f1
" Do not automatically enable showmarks, as it interferes with some smaller buffer windows
let g:showmarks_enable=0 
let g:showmarks_include="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ.'`^<>[]{}()\""

if ! has('gui_running')
	" Map 'Home' and 'End' keys to expected actions
	" For some reason home and end keys are not mapping properly.
	" Home key
	imap <esc>OH <esc>0i
	cmap <esc>OH <home>
	nmap <esc>OH 0
	" End key
	nmap <esc>OF $
	imap <esc>OF <esc>$a
	cmap <esc>OF <end>
endif

" Commands
nnoremap <silent> <F8> :NERDTreeToggle<cr>
nnoremap <S-F8> :3winc h\|vertical res -60<cr>

" Window and buffer switching
map <silent> <C-Up> :winc k<cr>
map <silent> <C-Right> :winc l<cr>
map <silent> <C-Down> :winc j<cr>
map <silent> <C-Left> :winc h<cr>

map <silent> <A-Left> :bprev<cr>
map <silent> <A-Right> :bnext<cr>
map <silent> <A-h> :bprev<cr>
map <silent> <A-l> :bnext<cr>

" Bubble single line
nmap <C-S-Up> [e
nmap <C-S-Down> ]e
" Bubble multiple lines
vmap <C-S-Up> [egv
vmap <C-S-Down> ]egv

" From /usr/share/vim/vim72/mswin.vim
" CTRL-X and SHIFT-Del are Cut
vnoremap <C-X> "+x
vnoremap <S-Del> "+x
vnoremap <S-Del> "+x

" CTRL-C and CTRL-Insert are Copy
vnoremap <C-C> "+y
vnoremap <C-Insert> "+y

" CTRL-V and SHIFT-Insert are Paste
map <C-V>		"+gP
map <S-Insert>		"+gP

cmap <C-V>		<C-R>+
cmap <S-Insert>		<C-R>+

" Pasting blockwise and linewise selections is not possible in Insert and
" Visual mode without the +virtualedit feature.  They are pasted as if they
" were characterwise instead.
" Uses the paste.vim autoload script.

exe 'inoremap <script> <C-V>' paste#paste_cmd['i']
exe 'vnoremap <script> <C-V>' paste#paste_cmd['v']

imap <S-Insert>		<C-V>
vmap <S-Insert>		<C-V>

" Use CTRL-Q to do what CTRL-V used to do
noremap <C-Q>		<C-V>
" End of /usr/share/vim/vim72/mswin.vim

" Omni completion
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

autocmd FileType python set ft=python.django " For SnipMate
autocmd FileType html set ft=htmldjango.html " For SnipMate

" Remove trailing whitespace on save
autocmd FileType c,cpp,java,php,python,javascript,html autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

" Taglist variables
" Display function name in status bar:
let g:ctags_statusline=1
" Automatically start script
let generate_tags=1
" Displays taglist results in a vertical window:
let Tlist_Use_Horiz_Window=0
" Shorter commands to toggle Taglist display
nnoremap TT :TlistToggle<CR>
map <F4> :TlistToggle<CR>
" Various Taglist diplay config:
let Tlist_Use_Right_Window = 1
let Tlist_Compact_Format = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_File_Fold_Auto_Close = 1

" ctrlp
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_lazy_update = 0
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_max_height = 20

" Syntastic
let g:syntastic_mode_map = { 'mode': 'active',
			\ 'active_filetypes': ['coffee', 'php', 'javascript'],
			\ 'passive_filetypes': ['ruby', 'python'] }

" python-mode settings
" 'Show documentation' plugin
let g:pymode_doc = 1
" Key for show python documentation
let g:pymode_doc_key = 'K'
" Load pylint code plugin
let g:pymode_lint = 1
" Auto fix vim python paths if virtualenv enabled
let g:pymode_virtualenv = 1
" Enable python objects and motion
let g:pymode_motion = 1
" Python folding
let g:pymode_folding = 0
" Custom syntax highlighting
let g:pymode_syntax = 1
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_cmd = "import pudb; pudb.set_trace()  # XXX BREAKPOINT"
let g:pymode_syntax_builtin_objs = 0
let g:pymode_syntax_builtin_funcs = 0

" Skip errors and warnings
" Mostly cosmetic stuff like redundant backslashes or over-identation when
" breaking up lines
let g:pymode_lint_ignore = "E126,E127,E128,E302,E501,E502"
" Do not automatically open quickfix window
let g:pymode_lint_cwindow = 0

"
" pymode: rope settings
let g:pymode_rope = 1
let g:pymode_rope_auto_project = 1
let g:pymode_rope_vim_completion = 1
let g:pymode_rope_extended_complete = 1
let g:pymode_rope_autoimport_modules = ["os","sys","shutil","datetime","django.*"]
let g:pymode_rope_goto_def_newwin = "vnew"
" Rope keybindings
let g:pymode_rope_global_prefix = '<C-x>p'
let g:pymode_rope_local_prefix = '<C-x>r'
let g:pymode_rope_goto_def_newwin = "split"
noremap <Leader>g :call RopeGotoDefinition()<CR>
noremap <Leader>r :call RopeRename()<CR>
imap <cs-space> <C-R>=RopeCodeAssistInsertMode()<CR>

" Jedi
let g:jedi#popup_on_dot = 0
let g:jedi#goto_command = "<leader>h"

" YankRing
nnoremap <silent> <F11> :YRShow<CR>
let g:yankring_replace_n_nkey = '}'
let g:yankring_replace_n_pkey = '{'

" Fugitive
autocmd User fugitive
  \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
  \   nnoremap <buffer> .. :edit %:h<CR> |
  \ endif
autocmd BufReadPost fugitive://* set bufhidden=delete
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P " Shows branch name

" Vim CSS colors
autocmd! FileType sass,scss,stylus syn cluster sassCssAttributes add=@cssColors

" Autocompletion
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_disable_auto_complete = 0
"let g:neocomplcache_enable_cursor_hold_i = 1
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_cursor_hold_i_time = 300
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_enable_camel_case_completion = 1

" Neocmplcache plugin key-mappings.
imap  <silent><expr><TAB>  neocomplcache#sources#snippets_complete#expandable() ? "\<plug>(neocomplcache_snippets_expand)" : (pumvisible() ? "\<c-e>" : "\<tab>")
smap  <TAB>  <right><plug>(neocomplcache_snippets_jump) 
inoremap <expr><c-e>     neocomplcache#complete_common_string()
noremap <expr><C-y>  neocomplcache#close_popup()
imap <C-k>     <Plug>(neocomplcache_snippets_expand)
smap <C-k>     <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><TAB>     neocomplcache#complete_common_string()

" numbers.vim
nnoremap <F3> :NumbersToggle<CR>

" MatchIt
" Extra patterns for matching Django template elements
if exists("loaded_matchit")
    let b:match_ignorecase = 1
    let b:match_skip = 's:Comment'
    let b:match_words = '<:>,' .
    \ '<\@<=[ou]l\>[^>]*\%(>\|$\):<\@<=li\>:<\@<=/[ou]l>,' .
    \ '<\@<=dl\>[^>]*\%(>\|$\):<\@<=d[td]\>:<\@<=/dl>,' .
    \ '<\@<=\([^/][^ \t>]*\)[^>]*\%(>\|$\):<\@<=/\1>,'  .
    \ '{% *if .*%}:{% *else *%}:{% *endif *%},' .
    \ '{% *ifequal .*%}:{% *else *%}:{% *endifequal *%},' .
    \ '{% *ifnotequal .*%}:{% *else *%}:{% *endifnotequal *%},' .
    \ '{% *ifchanged .*%}:{% *else *%}:{% *endifchanged *%},' .
    \ '{% *for .*%}:{% *endfor *%},' .
    \ '{% *with .*%}:{% *endwith *%},' .
    \ '{% *comment .*%}:{% *endcomment *%},' .
    \ '{% *block .*%}:{% *endblock *%},' .
    \ '{% *filter .*%}:{% *endfilter *%},' .
    \ '{% *spaceless .*%}:{% *endspaceless *%}'
endif

"Allow switching from an unsaved buffer to another
set hidden
" Default UTF-8 text encoding
set encoding=utf-8   
set fileencoding=utf-8

" Color scheme & syntax highlighting
:syntax on

set background=light

syntax enable
let g:solarized_termcolors=256
colorscheme solarized

" Startup

"autocmd VimEnter * :Project
"autocmd VimEnter * set winfixwidth

" Start with NERDTree opened
"autocmd VimEnter * NERDTree
"autocmd BufEnter * NERDTreeMirror
autocmd VimEnter * wincmd w

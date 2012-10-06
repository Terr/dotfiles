"Use Vim settings, rather then Vi settings (much better!).
"This must be first, because it changes other options as a side effect.
set nocompatible
set t_Co=256
set cindent
set smartindent
set autoindent
set textwidth=79
set t_Co=256

if has('gui_running')
  "set guifont=DejaVu\ Sans\ Mono\ 10
  " Patched font for vim-powerline
  set guifont=DejaVu\ Sans\ Mono\ for\ Powerline
endif

" vim-powerline
let g:Powerline_symbols = 'fancy'

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

" Tab settings
set tabstop=4
set shiftwidth=4
"set softtabstop=4
set autoindent
"set expandtab
set smartindent
filetype plugin on
filetype indent on

" Ignore list for Command-T
set wildmode=list:longest
set wildmenu
"set wildignore+=*.o,*.obj,*/.git/*,*.pyc,*.pyo,*.jpg,*.jpeg,*.gif,*.png,*/.svn/*,*/.hg/*
set wildignore+=*.o,*.obj,*.pyc,*.pyo,*.jpg,*.jpeg,*.gif,*.png,*/.svn/*,*/.hg/*
set wildignore+=*/.cache/*

" Window settings
set showcmd
set showmode
" Line numbers
set number
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>

" Disable cursor blink
set gcr=a:blinkon0

set wrap " As opposed to nowrap
set linebreak

" Keep X lines above/below the cursor when scrolling
set scrolloff=7
set sidescrolloff=7
set sidescroll=1

" Faster saving
nmap <Leader>w :w!<cr>

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
command NTT :NERDTreeToggle 
nnoremap <silent> <F8> :NERDTreeToggle<cr>
nnoremap <S-F8> :3winc h\|vertical res -60<cr>

" Window and buffer switching
map <silent> <C-Up> :winc k<cr>
map <silent> <C-Right> :winc l<cr>
map <silent> <C-Down> :winc j<cr>
map <silent> <C-Left> :winc h<cr>

map <silent> <A-Left> :bprev<cr>
map <silent> <A-Right> :bnext<cr>

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
			\ 'active_filetypes': ['coffee', 'php', 'python', 'javascript'],
			\ 'passive_filetypes': ['ruby'] }

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

" SuperTab like snippets behavior.
"imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

" Recommended key-mappings.
" <CR>: close popup and save indent.
"inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
" <TAB>: completion.
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
"inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
"inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
"inoremap <expr><C-e>  neocomplcache#cancel_popup()

" Pydiction
"let g:pydiction_location = '~/.vim/after/ftplugin/pydiction/complete-dict'

" SuperTab
"let g:SuperTabMappingForward = '<C-Space>'
"let SuperTabKey = '<c-space>'
"let g:SuperTabCrMapping = 0
"let g:SuperTabMappingForward = '<c-space>'
"let g:SuperTabMappingBackward = '<s-c-space>'

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

" Color scheme & syntax highlighting
:syntax on
"colorscheme koehler
"let g:zenburn_high_Contrast = 1
"colorscheme zenburn
"colorscheme wombat-terr
"colorscheme coderay

"if has('gui_running')
"    set background=light
"else
"    set background=dark
"endif
set background=light

syntax enable
let g:solarized_termcolors=256
colorscheme solarized

"nmap <unique> <F5> <Plug>ToggleBackground
"imap <unique> <F5> <Plug>ToggleBackground
"vmap <unique> <F5> <Plug>ToggleBackground

" Startup

"autocmd VimEnter * :Project
"autocmd VimEnter * set winfixwidth

" Start with NERDTree opened
"autocmd VimEnter * NERDTree
"autocmd BufEnter * NERDTreeMirror
autocmd VimEnter * wincmd w

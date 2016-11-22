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
set expandtab
set fo-=t   " don't automatically wrap text when typing
"set wrap " As opposed to nowrap
set nowrap
set linebreak
set backspace=indent,eol,start
set shiftround

" Enable line breaks/wrapping in Python files
" autocmd FileType python setlocal formatoptions+=t
au BufEnter,BufRead *.py call SetPythonOptions()
au BufEnter,BufRead *.php call SetPhpOptions()
au BufEnter,BufRead *.yml,*.yaml call SetYamlOptions()
au BufEnter,BufRead *.rb,*.pp call SetRubyOptions()

function! SetPythonOptions()
	setlocal textwidth=79
	setlocal colorcolumn=80
endfunction

function! SetPhpOptions()
	setlocal textwidth=119
	setlocal colorcolumn=120
endfunction

function! SetYamlOptions()
	setlocal tabstop=2
	setlocal shiftwidth=2
	setlocal softtabstop=2
endfunction

function! SetRubyOptions()
	setlocal tabstop=2
	setlocal shiftwidth=2
	setlocal softtabstop=2
endfunction

au FileType qf call AdjustWindowHeight(3, 17)
function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction


if has('gui_running')
	set guioptions-=m  "remove menu bar
	set guioptions-=T  "remove toolbar
	set guioptions-=r  "remove right-hand scroll bar
endif

" vim-powerline
"let g:Powerline_symbols = 'fancy'

" vim-airline
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline_theme='solarized'
"" unicode symbols (taken from airline's help page)
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_linecolumn_prefix = '␊ '
let g:airline_linecolumn_prefix = '␤ '
let g:airline_linecolumn_prefix = '¶ '
let g:airline#extensions#branch#prefix = '⎇ '
let g:airline_paste_symbol = 'ρ'
let g:airline_paste_symbol = 'Þ'
let g:airline_paste_symbol = '∥'

" Pathogen
call pathogen#infect()
call pathogen#helptags()

" Search in files
set incsearch
set hlsearch
" When 'ignorecase' and 'smartcase' are both on, if a pattern contains an uppercase letter, it is case sensitive, otherwise, it is not
set ignorecase
set smartcase

" Use 'The Silver Searcher' (ag) when grepping for files (including in CtrlP)
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor\ -f

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -f -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  " NOTE: For larger projects with thousands of files, caching is still desirable even on a SSD
  "let g:ctrlp_use_caching = 0
endif

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
" Relative line numbers
set relativenumber
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

" Switch to previous buffer with backspace
nmap <BS> <C-^>

" Remap backtick (= go to mark, including vertical position) to quote (= go to
" mark, beginning of line)
nnoremap ' `

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

" Insert close braces and position cursor after opening a brace + <enter>
inoremap {<cr> {<cr>}<c-o>O

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

" NERDTree
nnoremap <silent> <F8> :NERDTreeToggle<cr>
let g:nerdtree_tabs_open_on_gui_startup = 0

" Commands
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

" Shortcut for select last changed (or pasted) text
nnoremap gp `[v`]

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

imap <S-Insert>		<C-V>
vmap <S-Insert>		<C-V>

" Use CTRL-Q to do what CTRL-V used to do
noremap <C-Q>		<C-V>
" End of /usr/share/vim/vim72/mswin.vim


autocmd FileType python set ft=python.django
autocmd FileType html set ft=htmldjango.html

" Remove trailing whitespace on save
autocmd FileType c,cpp,java,php,python,javascript,html,ruby autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

" Tagbar
nnoremap <silent> <F7> :TagbarOpenAutoClose<cr>

" ctrlp
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_lazy_update = 0
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_max_height = 20
let g:ctrlp_map = '`'
let g:ctrlp_prompt_mappings = {
    \ 'ToggleType(1)':  ['`', '<c-up>'],
    \ 'ToggleType(-1)': ['~', '<c-down>'],
\ }

" Syntastic
let g:syntastic_mode_map = { 
            \ 'mode': 'active', 
			\ 'active_filetypes': ['coffee', 'php', 'javascript', 'python'],
			\ 'passive_filetypes': ['ruby', 'html'] 
\ }
"" JavaScript
let g:syntastic_javascript_checkers = ['jsl']
"" PHP
let g:syntastic_php_checkers = ['php', 'phpcs']
let g:syntastic_php_phpcs_args = ' --standard=PSR2'

" YouCompleteMe settings
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_filetype_blacklist = {
    \ 'tagbar': 1,
    \ 'qf': 1,
    \ 'notes': 1,
    \ 'markdown': 1,
    \ 'unite': 1,
    \ 'text': 1,
    \ 'vimwiki': 1,
    \ 'pandoc': 1,
    \ 'infolog': 1,
    \ 'mail': 1
\ }

" Add this to blacklist Python file, in case there is a conflict with
" Rope/python-mode (when pyrope 'complete_on_dot' is on).
"      \ 'python': 1,
"      \ 'python.django': 1

let g:ycm_semantic_triggers = {}
let g:ycm_semantic_triggers.php =
    \ ['->', '::', '(', 'use ', 'namespace ', '\']

let g:ycm_key_list_select_completion = ['<Tab>', '<Down>']
let g:ycm_key_list_previous_completion = ['<S-Tab>', '<Up>']

nnoremap <Leader>d :YcmCompleter GoToDeclaration<CR>

" Ensure preview window option is set in "completeopt"
let g:ycm_add_preview_to_completeopt = 1
" Close preview window after completion and/or leaving insert mode
"let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

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

" Dispatch
autocmd FileType php let b:dispatch = 'phpunit --filter ' . expand('%:t:r')
nnoremap <F9> :Dispatch<CR>
nnoremap <S-F9> :Start<CR>

" vim-test
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>
" make test commands execute using dispatch.vim
let test#strategy = "dispatch"
" don't ask anything, for example if dropping existing test database is okay
let test#python#djangotest#executable = 'python manage.py test --noinput'

" Vim CSS colors
autocmd! FileType sass,scss,stylus syn cluster sassCssAttributes add=@cssColors

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

" UltiSnips
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" Split screen vertically when starting to edit snippets
let g:UltiSnipsEditSplit="vertical"

" Vdebug
let g:vdebug_options = {
    \ 'path_maps': {
    \},
    \ 'server': '0.0.0.0',
    \ 'port': 9000
\}

" PHP refactoring toolbox
let g:vim_php_refactoring_use_default_mapping = 0
nnoremap <unique> <Leader>rlv :call PhpRenameLocalVariable()<CR>
nnoremap <unique> <Leader>rcv :call PhpRenameClassVariable()<CR>
nnoremap <unique> <Leader>rrm :call PhpRenameMethod()<CR>
nnoremap <unique> <Leader>reu :call PhpExtractUse()<CR>
vnoremap <unique> <Leader>rec :call PhpExtractConst()<CR>
nnoremap <unique> <Leader>rep :call PhpExtractClassProperty()<CR>
vnoremap <unique> <Leader>rem :call PhpExtractMethod()<CR>
nnoremap <unique> <Leader>rnp :call PhpCreateProperty()<CR>
nnoremap <unique> <Leader>rdu :call PhpDetectUnusedUseStatements()<CR>
vnoremap <unique> <Leader>r== :call PhpAlignAssigns()<CR>
nnoremap <unique> <Leader>rsg :call PhpCreateSettersAndGetters()<CR>
nnoremap <unique> <Leader>rda :call PhpDocAll()<CR>

" Padawan
let g:padawan#enabled = 0
let g:padawan#composer_command = "php /usr/local/bin/composer"

" ropevim
"" Use completion provided by YouCompleteMe instead
let ropevim_vim_completion = 0

"Allow switching from an unsaved buffer to another
set hidden
" Default UTF-8 text encoding
set encoding=utf-8   
set fileencoding=utf-8

" Color scheme & syntax highlighting
syntax on
syntax enable

set background=light
let g:solarized_termcolors=256
colorscheme solarized

" Change color of selected character more distinct
hi MatchParen guibg=bg guifg=gray

" Startup

"autocmd VimEnter * :Project
"autocmd VimEnter * set winfixwidth

" Start with NERDTree opened
"autocmd VimEnter * NERDTree
"autocmd BufEnter * NERDTreeMirror
autocmd VimEnter * wincmd w

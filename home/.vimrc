set cindent
set smartindent
set autoindent
set textwidth=79

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

" Tab settings
set tabstop=4
set shiftwidth=4
"set softtabstop=4
set autoindent
"set expandtab
set smartindent
filetype plugin on
filetype plugin indent on

" Line numbers
set number
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>

" Keep X lines above/below the cursor when scrolling
set so=7

" Faster saving
nmap <Leader>w :w!<cr>

" RabbitVCS
nmap <Leader>vc :!rabbitvcs commit .<cr>

" Commands
command NTT :NERDTreeToggle 
nnoremap <silent> <F8> :NERDTreeToggle<cr>
nnoremap <S-F8> :3winc h\|vertical res -60<cr>

" Window and buffer switching
"map <silent> <C-Up> :winc k<cr>
"map <silent> <C-Right> :winc l<cr>
"map <silent> <C-Down> :winc j<cr>
"map <silent> <C-Left> :winc h<cr>

"map <silent> <A-Left> :bprev<cr>
"map <silent> <A-Right> :bnext<cr>

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

" Pydiction
let g:pydiction_location = '~/.vim/after/ftplugin/pydiction/complete-dict'

" SuperTab
"let g:SuperTabMappingForward = '<C-Space>'
let SuperTabKey = '<c-space>'
let g:SuperTabCrMapping = 0
let g:SuperTabMappingForward = '<c-space>'
let g:SuperTabMappingBackward = '<s-c-space>'

" MiniBufExpl
"let g:miniBufExplMapWindowNavVim = 0
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

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
colorscheme wombat-terr
"colorscheme coderay

" Startup
"autocmd VimEnter * :Project
"autocmd VimEnter * set winfixwidth

" Start with NERDTree opened
autocmd VimEnter * exe 'NERDTree' 
"| wincmd l
autocmd BufEnter * NERDTreeMirror

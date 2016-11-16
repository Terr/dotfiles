" GUI settings. Could also be placed in .vimrc in an 'gui_running' conditional, 
" if not for MacVim not setting that variable 

if has("gui_macvim")
    set guifont=Office\ Code\ Pro:h14
endif

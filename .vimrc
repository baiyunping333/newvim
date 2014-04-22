" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2008 Jul 02
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
	finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" if has("vms")
	set nobackup		" do not keep a backup file, use versions instead
" else
" 	set backup		" keep a backup file
" endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set bg=dark
set nu
set expandtab
set tabstop=4
set shiftwidth=4
" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
" replace a with i
if has('mouse')
	set mouse=i
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
	syntax on
	set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

	" Enable file type detection.
	" Use the default filetype settings, so that mail gets 'tw' set to 72,
	" 'cindent' is on in C files, etc.
	" Also load indent files, to automatically do language-dependent indenting.
	filetype plugin indent on

	" Put these in an autocmd group, so that we can delete them easily.
	augroup vimrcEx
		au!

		" For all text files set 'textwidth' to 78 characters.
		autocmd FileType text setlocal textwidth=78

		" When editing a file, always jump to the last known cursor position.
		" Don't do it when the position is invalid or when inside an event handler
		" (happens when dropping a file on gvim).
		" Also don't do it when the mark is in the first line, that is the default
		" position when opening a file.
		autocmd BufReadPost *
					\ if line("'\"") > 1 && line("'\"") <= line("$") |
					\   exe "normal! g`\"" |
					\ endif

	augroup END

else

	set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
	command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
				\ | wincmd p | diffthis
endif
autocmd FileType python set et nu sw=4 ts=4 colorcolumn=79
autocmd FileType make setlocal noexpandtab
au BufNewFile,BufRead *.sqc :set ft=c
au BufNewFile,BufRead *.as :set ft=actionscript
au BufNewFile,BufRead *.api :set ft=api
au BufNewFile,BufRead *.mxml :set ft=mxml
au BufEnter /Users/crow/source/flightgear/* setlocal tags +=/Users/crow/source/flightgear/tags
au VimEnter /Users/crow/source/flightgear/* cs add /Users/crow/source/flightgear/cscope.out /Users/crow/source/flightgear
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cscope setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("cscope")
  set csprg=/usr/bin/cscope
  set csto=1
  set cst
  set nocsverb
  " add any database in current directory
  "if filereadable("cscope.out")
  "    cs add cscope.out
  "endif
  set csverb
endif

nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-_>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>



"""""""""""""""""""""""""""""""
" Tag list (ctags)
"""""""""""""""""""""""""""""""
"nmap <F4> :Tlist<CR>
let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_Right_Window = 1

"""""""""""""""""""""""""""""""
" TagBar (ctags)
"""""""""""""""""""""""""""""""
nmap <F4> :TagbarToggle<CR> 

"""""""""""""""""""""""""""""""
" NERDTreeToggle 
"""""""""""""""""""""""""""""""
nmap <F3> :NERDTreeToggle<CR>

"""""""""""""""""""""""""""""""
" PYTHON
"""""""""""""""""""""""""""""""
"au FileType python TagbarToggle
au FileType python set omnifunc=pythoncomplete#Complete
au FileType python setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4 smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
au BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
let g:pydiction_location = '/usr/share/pydiction/complete-dict'
let g:pyflakes_use_quickfix = 0
"au VimLeavePre *.py TagbarClose
autocmd BufWritePre *.py normal m`:%s/\s\+$//e``

"""""""""""""""""""""""""""""""
" latex
"""""""""""""""""""""""""""""""
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"

"""""""""""""""""""""""""""""""
" stop paste auto indentation
"""""""""""""""""""""""""""""""
set pastetoggle=<F2>
nmap <F6> :MiniBufExplorer<cr>
"autocmd FileType python compiler pylint
set foldmethod=indent
set foldlevel=99
set cursorline
set ls=2
" Paste from clipboard
map <leader>p "+p
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
    \ }
execute pathogen#infect()
set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim
autocmd BufWritePre *.go :silent Fmt
" vimwiki 配置
let g:vimwiki_list = [{'path': '~/vimwiki/blog/',
\ 'path_html': '~/vimwiki/blog/html/',
\ 'syntax': 'markdown',
\ 'ext': '.mkd',
\ 'template_path': '~/vimwiki/blog/',
\ 'template_default': 'template',
\ 'template_ext': '.html'}]
let g:vimwiki_camel_case = 0
let g:vimwiki_ext2syntax = {'.md':'markdown','.markdown':'markdown','.mdown':'markdown','.mkd':'markdown'}

map <F8> <Plug>Vimwiki2HTML
map <S-F8> <Plug>VimwikiAll2HTML
let g:evervim_devtoken='S=s37:U=3bb86e:E=14cdbb6b3b2:C=145840587b6:P=1cd:A=en-devtoken:V=2:H=127021417565af2a90cf211839234291'
"let g:wrap_toggle = 0
"func ToggleWrap()
"  if (wrap_toggle == 0)
"    :set wrap
"    set wrap_toggle := 1
"  else
"    :set nowrap
"    set wrap_toggle := 0
" endif
"endfunc
"map <F12>       :call ToggleWrap() <CR><C-W><C-W> :call ToggleWrap() <CR> <C-W><C-W>
"imap <F12>      <Esc>:call ToggleWrap() <C-W><C-W> :call ToggleWrap() <C-W><C-W> 


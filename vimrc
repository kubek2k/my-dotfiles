syntax on

set hlsearch ignorecase incsearch

set smartcase
" show matching brackets
set showmatch
set shiftwidth=4
set tabstop=4
set smarttab
set expandtab

" some filetype based checking
filetype plugin on
filetype indent on

" check if the file is being change from elsewhere
set autoread

" omnifunc completion
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType ruby set omnifunc=rubycomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

" line numbers config
set nu
set numberwidth=3
highlight LineNr ctermfg=red 

" ruler
set ru

" don't redraw when executing macro
set lazyredraw

" magic for regexes
set magic

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" no annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

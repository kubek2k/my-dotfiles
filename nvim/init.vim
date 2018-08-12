" Leader key
let mapleader = ','

" defaults
set nocompatible
filetype plugin indent on
syntax on
set nowrap
set encoding=utf8
set ruler

set hlsearch
set incsearch
set ignorecase
set smartcase

" Set Proper Tabs
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab 
set mouse=a
set updatetime=500

" More natural splits
set splitbelow
set splitright

if (has("termguicolors"))
  set termguicolors
endif

call plug#begin()
Plug 'lifepillar/vim-solarized8'
Plug 'nanotech/jellybeans.vim'
" Colorscheme
autocmd VimEnter * set background=dark
autocmd VimEnter * colorscheme jellybeans

Plug 'neomake/neomake', { 'for': ['haskell', 'elixir'] }
autocmd! BufWritePost *.hs Neomake!
autocmd! BufWritePost *.ex Neomake! mix
let g:neomake_open_list = 2

Plug 'parsonsmatt/intero-neovim'
Plug 'eagletmt/neco-ghc'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
autocmd VimEnter * highlight clear SignColumn | highlight GitGutterAdd guifg=green | highlight GitGutterChange guifg=yellow | highlight GitGutterDelete guifg=red | highlight GitGutterChangeDelete guifg=yellow
set updatetime=500

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
autocmd VimEnter * AirlineTheme jellybeans
let g:airline_powerline_fonts = 1

Plug 'vimlab/split-term.vim'
autocmd VimEnter * let g:disable_key_mappings = 1

Plug 'wesQ3/vim-windowswap'

Plug 'mileszs/ack.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim' 

Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'jiangmiao/auto-pairs'

Plug 'junegunn/vim-peekaboo'
autocmd VimEnter * let g:peekaboo_window = 'vert bo 50new'

Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-function'
Plug 'kana/vim-textobj-indent'
Plug 'sgur/vim-textobj-parameter'
Plug 'fvictorio/vim-textobj-backticks'
Plug 'thinca/vim-textobj-function-javascript'
Plug 'terryma/vim-expand-region'
let g:expand_region_text_objects = {
      \ 'iw'  :0,
      \ 'iW'  :0,
      \ 'i"'  :0,
      \ 'a"'  :0,
      \ 'i''' :0,
      \ 'a''' :0,
      \ 'i`'  :0,
      \ 'a`'  :0,
      \ 'i]'  :1,
      \ 'a]'  :1,
      \ 'ib'  :1,
      \ 'ab'  :1,
      \ 'iB'  :1,
      \ 'aB'  :1,
      \ 'ii'  :0,
      \ 'ai'  :0,
      \ 'if'  :1,
      \ 'af'  :1,
      \ 'i,'  :0,
      \ 'a,'  :0
      \ }
Plug 'hashivim/vim-terraform'
Plug 'juliosueiras/vim-terraform-completion'
Plug 'w0rp/ale', { 'for': 'javascript' }
Plug 'junegunn/rainbow_parentheses.vim'
autocmd VimEnter * RainbowParentheses

Plug 'Valloric/ListToggle'
au VimEnter * nnoremap <silent> <F2> :QToggle<CR>
au VimEnter * nnoremap <silent> <F3> :LToggle<CR>

Plug 'sunaku/vim-dasht'
" search related docsets
au VimEnter * nnoremap <Leader>k :Dasht<Space>

" search ALL the docsets
au VimEnter * nnoremap <Leader><Leader>k :Dasht!<Space>

" search related docsets
au VimEnter * nnoremap <silent> <Leader>K :call Dasht([expand('<cword>'), expand('<cWORD>')])<Return>

" search ALL the docsets
au VimEnter * nnoremap <silent> <Leader><Leader>K :call Dasht([expand('<cword>'), expand('<cWORD>')], '!')<Return>

augroup interoMaps
  au!
  " Maps for intero. Restrict to Haskell buffers so the bindings don't collide.

  " Background process and window management
  au FileType haskell nnoremap <silent> <leader>is :InteroStart<CR>
  au FileType haskell nnoremap <silent> <leader>ik :InteroKill<CR>

  " Open intero/GHCi split horizontally
  au FileType haskell nnoremap <silent> <leader>io :InteroOpen<CR>
  " Open intero/GHCi split vertically
  au FileType haskell nnoremap <silent> <leader>iov :InteroOpen<CR><C-W>H
  au FileType haskell nnoremap <silent> <leader>ih :InteroHide<CR>

  " Reloading (pick one)
  " Automatically reload on save
  au BufWritePost *.hs InteroReload
  " Manually save and reload
  au FileType haskell nnoremap <silent> <leader>wr :w \| :InteroReload<CR>

  " Load individual modules
  au FileType haskell nnoremap <silent> <leader>il :InteroLoadCurrentModule<CR>
  au FileType haskell nnoremap <silent> <leader>if :InteroLoadCurrentFile<CR>

  " Type-related information
  " Heads up! These next two differ from the rest.
  au FileType haskell map <silent> <leader>t <Plug>InteroGenericType
  au FileType haskell map <silent> <leader>T <Plug>InteroType
  au FileType haskell nnoremap <silent> <leader>it :InteroTypeInsert<CR>

  " Navigation
  au FileType haskell nnoremap <silent> <leader>jd :InteroGoToDef<CR>

  " Managing targets
  " Prompts you to enter targets (no silent):
  au FileType haskell nnoremap <leader>ist :InteroSetTargets<SPACE>
  let g:intero_ghci_options='-Wall'
augroup END

" Disable haskell-vim omnifunc
au FileType haskell let g:haskellmode_completion_ghc = 0
au FileType haskell setlocal omnifunc=necoghc#omnifunc

" Deoplete
autocmd VimEnter * inoremap <silent><expr> <Tab>
\ pumvisible() ? "\<C-n>" :
\ "\<Tab>"
autocmd VimEnter * inoremap <silent><expr> <S-Tab>
\ pumvisible() ? "\<C-p>" :
\ deoplete#mappings#manual_complete()

au VimEnter * let g:deoplete#omni_patterns = {}
au VimEnter * let g:deoplete#omni_patterns.terraform = '[^ *\t"{=$]\w*'
au VimEnter * let g:deoplete#enable_at_startup = 1

" Ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
cnoreabbrev ag Ack
cnoreabbrev aG Ack
cnoreabbrev Ag Ack
cnoreabbrev AG Ack

" FZF
" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Advanced customization using autoload functions
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})

nnoremap <silent> <leader><space> :Files<CR>
nnoremap <silent> <leader>a :Buffers<CR>
nnoremap <silent> <leader>A :Windows<CR>
nnoremap <silent> <leader>; :BLines<CR>
nnoremap <silent> <leader>o :BTags<CR>
nnoremap <silent> <leader>O :Tags<CR>
nnoremap <silent> <leader>? :History<CR>
nnoremap <silent> <leader>/ :execute 'Ag ' . input('Ag/')<CR>
nnoremap <silent> <leader>. :AgIn 

nnoremap <silent> K :call SearchWordWithAg()<CR>
vnoremap <silent> K :call SearchVisualSelectionWithAg()<CR>
nnoremap <silent> <leader>gl :Commits<CR>
nnoremap <silent> <leader>gb :BCommits<CR>
nnoremap <silent> <leader>ft :Filetypes<CR>

function! SearchWordWithAg()
    execute 'Ag' expand('<cword>')
endfunction

function! SearchVisualSelectionWithAg() range
    let old_reg = getreg('"')
    let old_regtype = getregtype('"')
    let old_clipboard = &clipboard
    set clipboard&
    normal! ""gvy
    let selection = getreg('"')
    call setreg('"', old_reg, old_regtype)
    let &clipboard = old_clipboard
    execute 'Ag' selection
endfunction

let g:rainbow_active = 1

let g:ale_fix_on_save = 1
let g:airline#extensions#ale#enabled = 1
let g:ale_fixers = {
\   'javascript': ['eslint'],
\   'json': ['jq']
\}

let my_nvim_dir = fnamemodify(expand('<sfile>'), ':p:h')
source $HOME/Dotfiles/nvim/js.vim
source $HOME/Dotfiles/nvim/heroku.vim
source $HOME/Dotfiles/nvim/elixir.vim
source $HOME/Dotfiles/nvim/aws.vim
source $HOME/Dotfiles/nvim/git.vim
source $HOME/Dotfiles/nvim/soji.vim

Plug 'ryanoasis/vim-devicons'
Plug 'diepm/vim-rest-console'
autocmd VimEnter * let g:vrc_response_default_content_type = 'application/json'
autocmd VimEnter * let g:vrc_show_command = 1
autocmd VimEnter * let g:vrc_curl_opts = {
  \ '-sS': '' 
  \}
command! VRCScrapebook Files $HOME/.vrc/
nnoremap <leader>vs :VRCScrapebook<cr>
command! -nargs=1 VRCNewScrapebook e $HOME/.vrc/<args>.rest"
call plug#end()

call deoplete#initialize()

command! TTerm tabe +terminal

nnoremap <leader>tt :tabe +terminal<cr>
nnoremap <leader>tv :VTerm<cr>
nnoremap <leader>te :Term<cr>

" Allow hitting <Esc> to switch to normal mode
tnoremap <Esc> <C-\><C-n>

" Alt+[hjkl] to navigate through windows in insert mode
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l

" Alt+[hjkl] to navigate through windows in normal mode
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" Ctrl+Arrows to navigate through windows in insert mode
tnoremap <C-Left>  <C-\><C-n><C-w>h
tnoremap <C-Down>  <C-\><C-n><C-w>j
tnoremap <C-Up>    <C-\><C-n><C-w>k
tnoremap <C-Right> <C-\><C-n><C-w>l

" Ctrl+Arrows to navigate through windows in normal mode
nnoremap <C-Left>  <C-w>h
nnoremap <C-Down>  <C-w>j
nnoremap <C-Up>    <C-w>k
nnoremap <C-Right> <C-w>l

" FZF mapping
autocmd! FileType fzf tnoremap <buffer> <esc> <c-c>

" Convenience for configuration editing
let s:myVimRC = '$HOME/Dotfiles/nvim/init.vim'
function! EditConfigInNewTab()
    exec 'tabe +e ' . s:myVimRC
    lcd %:p:h
    call fugitive#detect(getcwd())
endfunction

execute 'nnoremap <silent> <leader>sc :so ' . s:myVimRC . '<CR>'
nnoremap <silent> <leader>ec :call EditConfigInNewTab()<CR>

source $HOME/Dotfiles/nvim/gtags.vim
nnoremap <C-\> :Gtags 
nnoremap <C-\>r :Gtags -r <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-\>s :Gtags -s <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-\>d :Gtags -d <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-]> :GtagsCursor<CR>

nnoremap <C-\><C-n> :tn<CR>
nnoremap <C-\><C-p> :tp<CR>
nnoremap <C-n> :cn<CR>
nnoremap <C-p> :cp<CR>

source $HOME/Dotfiles/nvim/gtags-fzf.vim
nnoremap <leader>s :Symbols<CR>
nnoremap <leader>d :Definitions<CR>
nnoremap <leader>r :References<CR>

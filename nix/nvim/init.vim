let mapleader = ','

let my_nvim_dir = fnamemodify(expand('<sfile>'), ':p:h')

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
set tabstop=2
set shiftwidth=2
set smarttab
set expandtab
set mouse=a
set updatetime=100
set previewheight=15

" More natural splits
set splitbelow
set splitright

" Project local vimrc
set exrc

" Some shit with netrw
let g:netrwn_keepdir=0

" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

if (has("termguicolors"))
  set termguicolors
endif

call plug#begin()
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  autocmd VimEnter * AirlineTheme jellybeans
"  let g:airline_powerline_fonts = 1

  Plug 'lifepillar/vim-solarized8'
  Plug 'nanotech/jellybeans.vim'
  " Colorscheme
  autocmd VimEnter * set background=dark
  autocmd VimEnter * colorscheme jellybeans

  " TODO - remove this and use one that works
  " Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'
  autocmd VimEnter * highlight clear SignColumn | highlight GitGutterAdd guifg=green | highlight GitGutterChange guifg=yellow | highlight GitGutterDelete guifg=red | highlight GitGutterChangeDelete guifg=yellow
  set updatetime=500

  Plug 'vimlab/split-term.vim'
  autocmd VimEnter * let g:disable_key_mappings = 1

  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'

  Plug 'scrooloose/nerdcommenter'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-repeat'
  Plug 'jiangmiao/auto-pairs'

  Plug 'easymotion/vim-easymotion'
  Plug 'lukas-reineke/indent-blankline.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

  " Easymotion - changing all mappings to bidirectional
  " <Leader>f{char} to move to {char}
  map  <Plug>(easymotion-prefix)f <Plug>(easymotion-bd-f)
  " Move to line
  map <Plug>(easymotion-prefix)L <Plug>(easymotion-bd-jk)
  " Move to word
  map  <Plug>(easymotion-prefix)w <Plug>(easymotion-bd-w)
  " Move to end of word
  map  <Plug>(easymotion-prefix)e <Plug>(easymotion-bd-e)

  Plug 'junegunn/vim-peekaboo'
  autocmd VimEnter * let g:peekaboo_window = 'vert bo 50new'

  Plug 'kana/vim-textobj-user'
  Plug 'kana/vim-textobj-function'
  Plug 'kana/vim-textobj-indent'
  Plug 'sgur/vim-textobj-parameter'
  Plug 'whatyouhide/vim-textobj-xmlattr'
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
        \ 'ii'  :1,
        \ 'ai'  :1,
        \ 'iI'  :1,
        \ 'aI'  :1,
        \ 'if'  :1,
        \ 'af'  :1,
        \ 'i,'  :0,
        \ 'a,'  :0
        \ }

  Plug 'LnL7/vim-nix'
  Plug 'junegunn/rainbow_parentheses.vim'
  autocmd VimEnter * RainbowParentheses

  let g:lt_quickfix_list_toggle_map = '<F2>'
  let g:lt_location_list_toggle_map = '<F3>'
  Plug 'Valloric/ListToggle'

  "Plug 'Shougo/deoppet.nvim', { 'do': ':UpdateRemotePlugins' }
  "autocmd VimEnter * call deoppet#initialize()
  "autocmd VimEnter * call deoppet#custom#option('snippets',
    "\ map(globpath(&runtimepath, 'snippets', 1, 1),
    "\     { _, val -> { 'path': val } }))

  "imap <C-k>  <Plug>(deoppet_expand)
  "imap <C-f>  <Plug>(deoppet_jump_forward)
  "imap <C-b>  <Plug>(deoppet_jump_backward)
  "smap <C-f>  <Plug>(deoppet_jump_forward)
  "smap <C-b>  <Plug>(deoppet_jump_backward)

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
  nnoremap <silent> <leader>l :Lines<CR>
  nnoremap <silent> <leader>o :BTags<CR>
  nnoremap <silent> <leader>O :Tags<CR>
  nnoremap <silent> <leader>? :History<CR>
  nnoremap <silent> <leader>/ :execute 'Rg ' . input('Rg/')<CR>

  nnoremap <silent> K :call SearchWordWithRg()<CR>
  vnoremap <silent> K :call SearchVisualSelectionWithRg()<CR>
  nnoremap <silent> <leader>gl :Commits<CR>
  nnoremap <silent> <leader>gb :BCommits<CR>
  nnoremap <silent> <leader>ft :Filetypes<CR>


  " ------------------------------------------------------------------
  " Jumps
  " ------------------------------------------------------------------
  function! s:jump_format(line)
    return substitute(a:line, '\S\+', '\=submatch(0)', '')
  endfunction

  function! s:jump_sink(lines)
    if len(a:lines) < 2
      return
    endif
    let cmd = s:action_for(a:lines[0])
    if !empty(cmd)
      execute 'silent' cmd
    endif
    let idx = index(s:jumplist, a:lines[1])
    if idx == -1
      return
    endif
    let current = match(s:jumplist, '\v^\s*\>')
    let delta = idx - current
    if delta < 0
      execute 'normal! ' . -delta . "\<C-O>"
    else
      execute 'normal! ' . delta . "\<C-I>"
    endif

  endfunction

  function! Fzf_jumps(...)
    redir => cout
    silent jumps
    redir END
    let s:jumplist = split(cout, '\n')
    return fzf#wrap(
    'jumps', {
    \ 'source'  : extend(s:jumplist[0:0], map(s:jumplist[1:], 's:jump_format(v:val)')),
    \ 'sink*'   : function('s:jump_sink'),
    \ 'options' : '+m -x --ansi --tiebreak=index --layout=reverse-list --header-lines 1 --tiebreak=begin --prompt "Jumps> "',
    \ })
  endfunction

  command! -bar -bang Jumps call Fzf_jumps(<bang>0)
  nnoremap <silent> <leader>j :Jumps<CR>

  function! OpenFileUnderCursor()
      let underCursor = expand(expand("<cfile>"))
      let currentDir = expand("%:p:h")
      let currentRelativeDir = currentDir[len(getcwd()) + 1:]
      let fileToCheck = resolve(currentRelativeDir . "/" . underCursor)
      if filereadable(fileToCheck)
        execute "edit " . fileToCheck
      else
        return fzf#vim#files ("", {
              \ 'options': ['-q', fileToCheck]
              \})
      endif
  endfunction

  nnoremap <silent> gf :call OpenFileUnderCursor()<CR>

  function! SearchWordWithRg()
      execute 'Rg' expand('<cword>')
  endfunction

  function! SearchCurrentFileWithRg()
      execute 'Rg' expand('%:t')
  endfunction

  function! SearchVisualSelectionWithRg() range
      let old_reg = getreg('"')
      let old_regtype = getregtype('"')
      let old_clipboard = &clipboard
      set clipboard&
      normal! ""gvy
      let selection = getreg('"')
      call setreg('"', old_reg, old_regtype)
      let &clipboard = old_clipboard
      execute 'Rg' selection
  endfunction

  function! JumpToTag()
      let qflist = []
      let underCursor = expand("<cword>")
      let matchingTags = taglist(underCursor)
      if len(matchingTags) == 1
          call add(qflist, {
          \ 'filename': matchingTags[0].filename,
          \ 'pattern': substitute(matchingTags[0].cmd, '^/\(.*\)/$', '\1', ''),
          \ })
          call setqflist(qflist)
          silent cfirst
          normal! zz
      else
          return fzf#vim#tags(underCursor)
      endif
  endfunction

  " Show all matched tags when there are more available to not get confused
  nnoremap <C-]> :call JumpToTag()<CR>

  function! BreakIntoNewlinesOnCharacter()
    let l:firstLine = line('.')
    let l:targetIndent = indent('.')
    let l:cursorPosition = col('.') - 1
    let l:charUnderCursor = nr2char(strgetchar(getline('.')[(l:cursorPosition):], 0))
    execute 's/\%>' . l:cursorPosition . 'c\M' . l:charUnderCursor . '/\r' . l:charUnderCursor . '/g'
    let l:lastLine = line('.')
    let l:shift = ''
    let l:i = 0
    while (l:i < l:targetIndent) 
      let l:shift .= ' ' 
      let l:i += 1
    endwhile
    execute (l:firstLine + 1) . ',' . l:lastLine . 's/^/' . l:shift . '/'
  endfunction

  nnoremap gJ :call BreakIntoNewlinesOnCharacter()<CR>

  let g:rainbow_active = 1

  exec 'source' my_nvim_dir . '/js.vim'
  exec 'source' my_nvim_dir . '/heroku.vim'
  exec 'source' my_nvim_dir . '/elixir.vim'
  exec 'source' my_nvim_dir . '/aws.vim'
  exec 'source' my_nvim_dir . '/git.vim'
  exec 'source' my_nvim_dir . '/soji.vim'
  exec 'source' my_nvim_dir . '/haskell.vim'
  exec 'source' my_nvim_dir . '/eink.vim'

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

" repeat last edit for each line in visual selectio mode
xnoremap . :normal .<CR>

nnoremap <leader>tt :tabe +terminal<cr>i
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
let s:myVimRC = '$HOME/Dotfiles/nix/nvim/init.vim'
function! EditConfigInNewTab()
    exec 'tabe +e ' . s:myVimRC
    lcd %:p:h
endfunction

execute 'nnoremap <silent> <leader>sc :so ' . s:myVimRC . '<CR>'
nnoremap <silent> <leader>ec :call EditConfigInNewTab()<CR>

nnoremap <C-\><C-n> :tn<CR>
nnoremap <C-\><C-p> :tp<CR>
nnoremap <C-n> :cn<CR>
nnoremap <C-p> :cp<CR>

" Polish letters
inoremap <A-a> <C-K>a;
inoremap <A-e> <C-K>e;
inoremap <A-c> <C-K>c'
inoremap <A-o> <C-K>o'
inoremap <A-n> <C-K>n'
inoremap <A-x> <C-K>z'
inoremap <A-z> <C-K>z.

exec 'source' my_nvim_dir . '/gtags-fzf.vim'
nnoremap <leader>s :Symbols<CR>
nnoremap <leader>d :Definitions<CR>
nnoremap <leader>r :References<CR>

if exists("$EXTRA_VIM")
  for path in split($EXTRA_VIM, ':')
    exec "source ".path
  endfor
endif

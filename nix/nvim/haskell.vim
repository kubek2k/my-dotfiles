Plug 'neovimhaskell/haskell-vim'
Plug 'ndmitchell/ghcid', { 'rtp': 'plugins/nvim'}
au FileType haskell let b:ale_linters = {'haskell': []}
Plug 'kubek2k/fzf-hoogle.vim', {'dir': '/Users/jakub.janczak/dev/vim/fzf-hoogle.vim'}
nnoremap <silent> gh :Hoogle <cword><CR>

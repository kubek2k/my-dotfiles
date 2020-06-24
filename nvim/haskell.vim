Plug 'neovimhaskell/haskell-vim'
Plug 'ndmitchell/ghcid', { 'rtp': 'plugins/nvim'}
au FileType haskell let b:ale_linters = {'haskell': []}

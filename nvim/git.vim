Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
autocmd VimEnter * highlight clear SignColumn | highlight GitGutterAdd guifg=green | highlight GitGutterChange guifg=yellow | highlight GitGutterDelete guifg=red | highlight GitGutterChangeDelete guifg=yellow
set updatetime=500

" Fugitive key bindings
nnoremap <leader>gs :Gstatus<cr>:13wincmd_<cr>
nnoremap <leader>gc :Gcommit<cr>
nnoremap <leader>ga :Gwrite<cr>
nnoremap <leader>gl :Glog<cr>
nnoremap <leader>gd :Gdiff<cr>

function! s:changebranch(branch) 
    execute 'Git checkout' . a:branch
    call feedkeys("i")
endfunction

command! -bang Gbranch call fzf#run({
            \ 'source': 'git branch -a --no-color | grep -v "^\* " ', 
            \ 'sink': function('s:changebranch')
            \ })

Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
Plug 'ternjs/tern_for_vim'
Plug 'moll/vim-node'
Plug 'pangloss/vim-javascript'

let g:ale_javascript_eslint_use_global = 0

function s:filterModule(value, modules)
  return index(a:modules, a:value) == -1
endfunction

let s:modules = []
" sindreshorus/builtin-modules
let s:script = 'var blacklist = ['
let s:script .= '"freelist",'
let s:script .= '"sys"'
let s:script .= '];'

let s:script .= 'console.log(Object.keys(process.binding("natives")).filter(function (el) {'
let s:script .= '	return !/^_|^internal|\//.test(el) && blacklist.indexOf(el) === -1;'
let s:script .= '}).sort().join(" "));'
function s:require(command)
  let args = split(a:command)

  if len(s:modules) == 0
    let s:modules = split(system("node -pe '" . s:script . "'"), ' ') 
  endif

  let reqlist = map(copy(args), '"const " . v:val . " = require(''" . v:val . "'');"')

  let toinstall = filter(args, 's:filterModule(v:val, s:modules)')

  if(exists('*tabular#TabularizeStrings'))
    call tabular#TabularizeStrings(reqlist, '=')
  endif

  call append(line('.'), reqlist)

  if len(toinstall) != 0
    exe "Npmi " . join(toinstall, ' ')
  endif

  exe "wincmd j"
endfunction

" Completion function for npm
"
" Delegates to `npm completion`.
function s:npmcomplete(lead, line, pos)
  " code
  let cmd = 'COMP_CWORD="0" COMP_LINE="' . a:lead . '" COMP_POINT="' . a:pos . '" npm completion -- "' . a:line . '"'
  return system(cmd)
endfunction

" Run current file with node
function s:run()
  let bufnr = expand('<bufnr>')
  let file = expand('%:p')

  exe 'Term node ' . file
endf

au FileType javascript setl ts=2 tw=2 sw=2
" ### Require fs path
au FileType javascript command! -complete=file -nargs=+ Require call s:require(<q-args>)

" ### Npm install qs
au FileType javascript command! -complete=custom,s:npmcomplete -nargs=* Npm :3Term npm <q-args>

" ### Npmi qs request
au FileType javascript command! -complete=file -nargs=* Npmi :3Term npm install <args> --save

" ### Node app.js
au FileType javascript command! -complete=file -count=2 -nargs=* Node :<count>Term node

" ### NodeRun
au FileType javascript command! -nargs=* NodeRun call s:run()

let g:deoplete#sources#ternjs#types = 1
let g:deoplete#enable_smart_case = 1
au FileType javascript,jsx setl omnifunc=tern#Complete
autocmd VimEnter * let g:deoplete#omni_patterns.javascript = '[^. \t]\.\w*'


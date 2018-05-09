function! s:openFromFZF(lines)
    let cmd = get({'ctrl-x': 'split',
                \ 'ctrl-v': 'vertical split',
                \ 'ctrl-t': 'tabe'}, a:lines[0], 'e')
    let parts = split(a:lines[1], ' ')   
    execute cmd escape(parts[0], ' %#\')
    execute parts[2]
    let pos = searchpos(parts[1], 'n')
    if len(pos) > 0 
        call cursor(pos[0], pos[1])
    endif
endfunction

command! -nargs=0 Definitions call fzf#run({'source': "global -d '.*' --result cscope",
            \ 'sink*': function('<sid>openFromFZF'),
            \ 'options': '--ansi --expect=ctrl-t,ctrl-v,ctrl-x'
            \})

command! -nargs=0 Symbols call fzf#run({'source': "global -s '.*' --result cscope",
            \ 'sink*': function('<sid>openFromFZF'),
            \ 'options': '--ansi --expect=ctrl-t,ctrl-v,ctrl-x'
            \})

command! -nargs=0 References call fzf#run({'source': "global -r '.*' --result cscope",
            \ 'sink*': function('<sid>openFromFZF'),
            \ 'options': '--ansi --expect=ctrl-t,ctrl-v,ctrl-x'
            \})

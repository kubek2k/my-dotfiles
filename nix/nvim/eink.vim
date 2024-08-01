
Plug 'vim-scripts/delek.vim'

function! EinkReader() " Specify a readable color scheme.
    " Set color scheme, so that mostly things are readable
    colorscheme delek
    " Tune the airline color scheme (feel free to take it away).
    AirlineTheme zenburn
    " Keep the cursor as HD-FT has touch input
    set guioptions+=r
    " I got my copy of ProFontWindows, likely, from here: https://github.com/chrissimpkins/codeface/tree/master/fonts/pro-font-windows
    " Resolution for the 13-inch Paperlike HD display is 1400 x 1050
    set guifont=ProFontWindows:h20
    " Note: font on Dasung is calibrated. Need to make the screen max
    set background=light
    " denote the current line of the cursor.
        set cursorline
        " let g:airline_theme = 'zenburn'
        hi! link airline_tabfill VertSplit
        hi CursorLine guibg=lightblue
    " Highlighting for search pattern
        hi Search guifg=White guibg=black
    " Highlighting for Folded code block
        hi Folded guibg=LightYellow
    " Colorization for Visual Mode
        hi Visual  guifg=White guibg=Black gui=none
    " Character under the cursor
        hi Cursor  guifg=Blue guibg=lightred gui=none
    " Sign column
        hi SignColumn  guibg=White gui=none
    " Sign Marker column
        hi SignatureMarkText guifg=White guibg=LightBlue gui=none
    " ColorColumn (as the 80 char divider)
        hi ColorColumn ctermbg=lightred guibg=lightred
    " Matching parameters, and vimtex matching environments.
        hi MatchParen guibg=NONE guifg=blue gui=bold
    " Send the Vim session to full screen.
        " Fullscreen
    " Undo highlights for TODO
        hi! link Todo Comment
    " Cursor, in a light color: avoiding the traces.
        " highlight iCursor guifg=Black guibg=LightYellow
        " set guicursor+=i:ver25-iCursor
        " set guicursor+=i:blinkwait10
endfun

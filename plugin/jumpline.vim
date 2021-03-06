"============================================================================
"File:        jumpline.vim
"Description: Vim plugin for jumping to a specific line, top or bottom
"License:     The Unlicense
"             See: https://choosealicense.com/licenses/unlicense/
"============================================================================

if exists('g:loaded_jumpline_plugin')
    finish
endif
let g:loaded_jumpline_plugin = 1

" Ask the user for a line number. If none is given, alternate
" between jumping to the top and the bottom of the file.
function jumpline#AskJump()
    let message = "error"
    let lineNumber = input('Go to line: ')
    " Replace 0 with 1
    if lineNumber == "0"
        let lineNumber = "1"
    endif
    if line("$") == 1
        " Already on the one line in the file
        let message = ""
    elseif lineNumber =~# '^\d\+$' " number check
        " Go to the given line number
        call cursor(lineNumber, 1)
        if lineNumber == "1"
            let message = "First line"
        elseif str2nr(lineNumber) >= line("$")
            let message = "Last line"
        else
            let message = "Line " . lineNumber
        endif
    elseif line(".") == 1
        " Jump down
        call feedkeys('G')
        let message = "Last line"
    else
        " Jump up
        call feedkeys('gg')
        let message = "First line"
    endif
    " Output a message and clear the status field
    redraw
    echo message
endfunction

" bind ctrl-l to the function above
nmap <silent> <c-l> :call jumpline#AskJump()<cr>

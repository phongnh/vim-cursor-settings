if exists('g:loaded_cursor_settings') || has('nvim') || has('gui_running')
    finish
endif

let g:loaded_cursor_settings = 1

" Mode Settings
" t_SI: INSERT mode
" t_SR: REPLACE mode
" t_EI: NORMAL mode (ELSE)

" iTerm
if $TERM_PROGRAM ==? 'iTerm.app'
    if exists("$TMUX")
        let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
        try
            let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
        catch
        endtry
        let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
    else
        let &t_SI = "\<Esc>]50;CursorShape=1\x7"
        try
            let &t_SR = "\<Esc>]50;CursorShape=2\x7"
        catch
        endtry
        let &t_EI = "\<Esc>]50;CursorShape=0\x7"
    endif
elseif $TERM_PROGRAM ==? 'Kitty' || $TERM_PROGRAM ==? 'Alacritty' || $TERM_PROGRAM ==? 'VTE'
    " 1 -> blinking block
    " 2 -> solid block
    " 3 -> blinking underscore
    " 4 -> solid underscore
    " 5 -> blinking vertical bar
    " 6 -> solid vertical bar
    let &t_SI = "\<Esc>[5 q"
    try
        let &t_SR = "\<Esc>[3 q"
    catch
    endtry
    let &t_EI = "\<Esc>[1 q"
elseif $TERM_PROGRAM ==? 'Apple_Terminal'
    " 1 -> blinking block
    " 2 -> solid block
    " 3 -> blinking underscore
    " 4 -> solid underscore
    " 5 -> blinking vertical bar
    " 6 -> solid vertical bar
    let &t_SI .= "\e[5 q"
    try
        let &t_SR .= "\e[3 q"
    catch
    endtry
    let &t_EI .= "\e[1 q"
endif

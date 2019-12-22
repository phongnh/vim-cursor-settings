if exists('g:loaded_cursor_settings') || has('nvim') || has('gui_running')
    finish
endif

let g:loaded_cursor_settings = 1

" iTerm
if $TERM_PROGRAM ==? 'iTerm.app'
    " Different cursors for Insert Mode vs Normal Mode for iTerm
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
elseif $TERM_PROGRAM ==? 'Kitty' || $TERM_PROGRAM ==? 'Alacritty'
    " VTE terminals
    let &t_SI = "\<Esc>[6 q"
    try
        let &t_SR = "\<Esc>[4 q"
    catch
    endtry
    let &t_EI = "\<Esc>[2 q"
endif

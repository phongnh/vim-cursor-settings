if exists('g:loaded_cursor_settings') || has('nvim') || has('gui_running')
    finish
endif

let g:loaded_cursor_settings = 1

function! s:autodetect_term_program() abort
    if exists("$LC_TERMINAL")
        return $LC_TERMINAL
    elseif exists("$TERM_PROGRAM_NAME")
        return $TERM_PROGRAM_NAME
    else
        return $TERM_PROGRAM
    endif
endfunction

function! s:is_vte_compatible_terminal() abort
    return s:term_program =~? 'Apple_Terminal\|Alacritty\|Kitty\|Wezterm\|Rio\|VTE\|tmux' ||
                \ !empty($VTE_VERSION) ||
                \ !empty($KONSOLE_VERSION)
endfunction

let s:term_program = s:autodetect_term_program()

" Mode Settings
" t_SI: INSERT mode
" t_SR: REPLACE mode
" t_EI: NORMAL mode (ELSE)

if s:is_vte_compatible_terminal() || exists("$TMUX")
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
elseif s:term_program =~? 'iTerm'
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
endif

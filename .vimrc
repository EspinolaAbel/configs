function CamelCase()
        let current_line = getline(".")
        if strlen( current_line ) == 0
                return ""
        endif
        let final = ""
        let previous_char_is_space = 0
        for idx in range( 0, strlen(current_line) )
                let char = strcharpart(current_line, idx, 1)
                if char == " "
                elseif previous_char_is_space
                        let final.= toupper(char)
                else
                        let final.= char
                endif
                let previous_char_is_space = char == " "
        endfor
        call setline(".", final)
        return final
endfunction

function SnakeCase()
        let current_line = getline(".")
        if strlen( current_line ) == 0
                return ""
        endif
        let final = ""
        for idx in range( 0, strlen(current_line) )
                let char = strcharpart(current_line, idx, 1)
                if char == " "
                        let final.= "_"
                else
                        let final.= char
                endif
        endfor
        call setline(".", final)
        return final
endfunction

command CamelCase :call CamelCase()
command SnakeCase :call SnakeCase()

"****************************************************************************************************
" JAVA Test method convertion
"****************************************************************************************************

function TestName()
        execute "normal! \<Esc>O@Test\<Esc>jA {\<Enter>\<Enter>}\<Esc>kA\<Esc>"
endfunction

function TestCamelCase()
        call CamelCase()
        call TestName()
endfunction

function TestSnakeCase()
        call SnakeCase()
        call TestName()
endfunction

command TestCamelCase :call TestCamelCase()
command TestSnakeCase :call TestSnakeCase()

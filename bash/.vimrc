" version 1.3
" https://github.com/EspinolaAbel/configs/edit/master/.vimrc

" Mostrar tabs con longitud de 4 espacios
set tabstop=4
set softtabstop=0 noexpandtab
set shiftwidth=4

" Mostrar caracteres no visibles con :list
set listchars=tab:»»,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨,space:•

" CaseInsensitive en búsquedas cuando todos los caracteres son minúsculas
" CaseSensitive cuando hay por lo menos un caracter mayúscula
set ignorecase
set smartcase

set nohlsearch
" Busqueda incremental. Mueve el cursor a las palabras matcheadas a medida que voy tipeando
set incsearch

" Cambiar los colores de los caracteres cuando el color de fondo de la terminal es negro
set background=dark

" Mover la línea seleccionada un lugar hacía arriba
nnoremap [1;3A ddkkp
vnoremap [1;3A dkkp
inoremap [1;3A <ESC>ddkkpI
" Mover la línea seleccionada un lugar hacía abajo
nnoremap [1;3B ddp
vnoremap [1;3B dp
inoremap [1;3B <ESC>ddpI
" Acumular palabras en el registro w
nnoremap "w "wyiw:let @w='<C-R>w\n'<CR>
nnoremap "W "Wyiw:let @w='<C-R>w\n'<CR>
nnoremap "wp "wp:s/\\n/\r/g<CR>ddk^
nnoremap "wP "wp:s/\\n/ /g<CR>^

" ejemplo de un mapeo de un macro para :IE
"cnoremap IE normal! IInsertame esto con un comando<CR><ESC>

" Mostrar todos los caracteres ocultos por defecto
"set list

" activar autoindent
set autoindent

" permitir scroll horizontal :help scroll-horizontal
"set nowrap

"diccionarios
set dictionary+=/usr/share/dict/american-english
set dictionary+=/usr/share/dict/british-english
set dictionary+=/usr/share/dict/spanish

"Guarda views cuando cierro y las recarga cuando entro
"augroup remember_folds
"  autocmd!
"  autocmd BufWinLeave * mkview
"  autocmd BufWinEnter * silent! loadview
"augroup END

"********************************************************************************************************************************************
"** SOLO PARA VIMRC DE ECLIPSE **************************************************************************************************************
"********************************************************************************************************************************************

" resaltado de sintaxis
" .vrapper de eclipse
"autocmd BufNewFile,BufRead .vrapperrc set syntax=vim
"autocmd BufNewFile,BufRead _vrapperrc set syntax=vim
"nnoremap <C-0> <C-v>

"********************************************************************************************************************************************
"** VIMSCRIPT *******************************************************************************************************************************
"********************************************************************************************************************************************

" VIMSCRIPT
function CamelCase()
	let current_line = getline(".")
	if strlen( current_line ) == 0
		return ""
	endif
	let final = ""
	let previous_char_is_space = 0
	for idx in range( 0, strlen(current_line) )
		let char = strpart(current_line, idx, 1)
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
		let char = strpart(current_line, idx, 1)
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

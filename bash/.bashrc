# agregar esto al final del .bashrc original

# Modo VI!
set -o vi;
# Todos los comandos de este terminal se comienzan a escribir en la línea de abajo
PS1=${PS1:0:-2}\n$
PS1="$PS1 "

VISUAL=vim
EDITOR=$VISUAL

#!/bin/bash

# Obtener el nombre de la ventana activa usando hyprctl
window_name=$(hyprctl activewindow -j | jq -r '.title')

# Mostrar solo el nombre del programa (eliminando la ruta o detalles adicionales)
program_name=$(echo "$window_name" | awk -F ' - ' '{print $1}')

# Imprimir el nombre del programa
echo "$program_name"

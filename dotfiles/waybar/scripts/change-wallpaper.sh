#!/usr/bin/bash

# Directorio de wallpapers
DIR=/home/denko/Pictures/Wallpapers
PICS=($(ls ${DIR}))

# Archivo para guardar el índice del último wallpaper usado
INDEX_FILE=~/.config/hypr/scripts/last_wallpaper_index.txt

# Si el archivo no existe, crearlo y empezar desde 0
if [[ ! -f $INDEX_FILE ]]; then
    echo "0" > $INDEX_FILE
fi

# Leer el índice del último wallpaper usado
LAST_INDEX=$(cat $INDEX_FILE)

# Calcular el siguiente índice
NEXT_INDEX=$((LAST_INDEX + 1))

# Si el índice supera el número de wallpapers, volver a 0
if [[ $NEXT_INDEX -ge ${#PICS[@]} ]]; then
    NEXT_INDEX=0
fi

# Guardar el nuevo índice en el archivo
echo $NEXT_INDEX > $INDEX_FILE

# Seleccionar el wallpaper correspondiente al nuevo índice
RANDOMPIC=${PICS[$NEXT_INDEX]}

# Cambiar el fondo de pantalla con swww
if [[ $(pidof hyprpaper) ]]; then
    pkill hyprpaper
fi

swww query || swww init
swww img --transition-type grow --transition-duration 1 --transition-fps 60 --transition-pos 640,1045 ${DIR}/${RANDOMPIC}

# Generar y aplicar colores con Pywal
wal -i ${DIR}/${RANDOMPIC}

# Aplicar colores en Hyprland (bordes de ventanas)
hyprctl reload

# Aplicar colores en Kitty
if [[ $(pidof kitty) ]]; then
    # Copiar la configuración de colores generada por Pywal
    cp ~/.cache/wal/colors-kitty.conf ~/.config/kitty/colors.conf
    # Enviar una señal a Kitty para recargar la configuración
    kill -SIGUSR1 $(pidof kitty)
fi
# Aplicar colores en Cava
if [[ $(pidof cava) ]]; then
    cp ~/.cache/wal/config ~/.config/cava/
    # Reiniciar Cava para aplicar los nuevos colores
    
    #killall cava
    #cava &
fi


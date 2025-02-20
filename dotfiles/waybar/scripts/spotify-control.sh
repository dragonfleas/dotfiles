#!/bin/bash

case $1 in
    "play-pause")
        playerctl -p spotify play-pause
        ;;
    "next")
        playerctl -p spotify next
        ;;
    "previous")
        playerctl -p spotify previous
        ;;
    *)
        # No hacer nada si no se pasa un argumento
        ;;
esac

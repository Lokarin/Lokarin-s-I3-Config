#!/bin/bash

file=$1

if [[ -f $file && $file == *.jpg ]]; then
	echo "Imagem encontrada! Alterando tema e wallpaper..."
	wal -i "$file"
	cp ~/.cache/wal/colors.Xresources ~/.Xresources

else
	echo "Erro: Diretório e/ou Imagem inexistente! Alterando tema e wallpaper para imagem aleatória..."
	wal -i /home/lokarin/Imagens/WallPapers/
	cp ~/.cache/wal/colors.Xresources ~/.Xresources

fi

#!/bin/bash

# O input "$1" será o texto do dmenu
# e o input "$2" será o comando a ser rodado.

[ "$(echo -e "Não\nSim" | dmenu -i -p "$1")" == "Sim" ] && $2

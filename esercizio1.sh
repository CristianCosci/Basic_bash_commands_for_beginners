#!/bin/bash
cut -d ":" -f 1,6 /etc/passwd | grep "home" | tr ":" " " | sort

#uso cut per selezionare solo prima e sesta colonna di tutte le righe del file
#le colonne sono identificate mediante il separatore ":"
#filtro tutto l'output con grep , prendendo solo le righe che contengono la parola "home"
#uso tr per rimuovere i ":" e sostituirli con lo spazio
#ordino in ordine alfabetico l'output
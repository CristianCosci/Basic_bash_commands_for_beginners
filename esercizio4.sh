#!/bin/bash

if [ $# -lt 2 ]; then #controllo sul numero di argomenti
    echo "$0 : gli argomenti passati devono essere almeno 2"
else
    conta=0
    file_out=${!#} #definisco l'ultimo argomento come file di output
    if [ -e $file_out ]; then #se non esiste un file con il nome dato come ultimo argomento lo creo
        if ! [ -f $file_out ]; then #l'argomento finale deve essere un file per appendere il contenuto degli altri
            echo "ERRORE : $file_out non è un file"
            exit 1
        fi
    else 
        touch $file_out #creo il file con il nome dato come ultimo argomento
    fi 
    for i in $@
    do 
        if [ -f $i ]; then #controlla che tutti gli argomenti siano file 
            A[$conta]=$i
            ((conta++))
        else
            echo "ERRORE : $i non è un file"
            exit
        fi
    done
    ((conta--))
    for ((j=$conta-1; j>-1; j--)) ; do #appendo tutti i file dal penultimo al primo sul file di output
        cat ${A[$j]} >> $file_out
    done
    cat $file_out #stampo il contenuto del file 
fi

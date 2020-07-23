#!/bin/bash

find /home -mmin -2 -type f -exec grep -l "cookies" {} \;
#cerco a partire dalla home tutti i file modificati negli ultimi 2 minuti
#passo a grep i nomi dei file con exec e glieli faccio filtrare leggendo il contenuto e stampando solo i nomi di quelli che contengono la parola "cookies" al suo interno
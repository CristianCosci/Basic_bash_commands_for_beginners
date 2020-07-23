#!/bin/bash
if [ $# -lt 1 ]; then #controllo sugli argomenti passati 
    echo "$0: errore, deve essere passato come argomento almeno un file"
    exit 1
fi
for f in $@; do
    tipo1=`file -b $f|grep text` #controllo per vedere se il file passato è un file con del testo al suo interno 
    if  ! [ -n "$tipo1" ]; then
        echo "$0 : errore , gli argomenti devono essere tutti file di testo"
        echo "$f : non è un file di testo"
        exit 1
    fi 
done 
contaRighe[$#]=0 #creazioni di array contente i dati dei vari file 
contaMedie[$#]=0
contaSomme[$#]=0
contaDeviazioni[$#]=0
i=0
indice=0
re='^[0-9]+([.][0-9]+)?$' #regular expression di un numero in virgola mobile
for j in $@; do 
    conta=0
    somma=0
    while read -r riga; do #leggo i dati sulla seconda colonna del file
        num=`echo $riga |cut -d " " -f 2`
        if ! [[ $num =~ $re ]] ; then #controllo se rispettano la regular expression di un numero
            echo "$0 error: $num nel file $j non è un numero"  
            exit 1
        fi
        somma=`echo "scale=2; $somma+$num" | bc -q` #calcolo la somma dei numeri del file
        ((conta++))
    done < $j
    contaSomme[$indice]=$somma 
    contaMedie[$indice]=`echo "scale=2; ${contaSomme[$indice]}/$conta" | bc -q` #calcolo la media (uso bc per i calcoli in virgola mobile)
    contaRighe[$indice]=$conta
    ((indice++))
done 
indice=0
sommatoria=0
for a in $@; do 
    conta1=0
    while read -r riga; do
        num=`echo $riga |cut -d " " -f 2`
        operazione=`echo "scale=2; $num-${contaMedie[$indice]}" | bc -q` #calcolo la deviazione standard corretta del file
        operazione=`echo "scale=2; $operazione^2" | bc -q`
        sommatoria=`echo "scale=2; $operazione+$sommatoria" | bc -q`
        ((conta1++))
    done < $a
    if [ $conta1 -eq 1 ]; then 
        ((conta1++))
    fi
    sommatoria=`echo "scale=2; $sommatoria/($conta1-1)" | bc -q`
    sommatoria=`echo "scale=2; sqrt($sommatoria)" | bc -q `
    contaDeviazioni[$indice]=$sommatoria
    sommatoria=0
    ((indice++))
done 
argomento=0
for b in $@; do 
    echo "$b: ${contaRighe[$argomento]} ${contaSomme[$argomento]} ${contaMedie[$argomento]} ${contaDeviazioni[$argomento]}" #output per ogni file 
    ((argomento++))
done
righeTot=0
sommaTot=0
mediaTot=0
indice=0 
for c in $@; do #calcolo i dati per il TOT
    righeTot=`echo "scale=2; $righeTot+${contaRighe[$indice]}" | bc -q`
    sommaTot=`echo "scale=2; $sommaTot+${contaSomme[$indice]}" | bc -q`
    ((indice++))
done 
mediaTot=`echo "scale=2; $sommaTot/$righeTot" | bc -q`
deviazioneTot=0
sommatoria=0
for d in $@; do  #calcolo deviazione standard per la popolazione (TOT)
    while read -r riga; do
        num=`echo $riga |cut -d " " -f 2`
        operazione=`echo "scale=2; $num-$mediaTot" | bc -q`
        operazione=`echo "scale=2; $operazione^2" | bc -q`
        sommatoria=`echo "scale=2; $operazione+$sommatoria" | bc -q`
    done < $a
done
sommatoria=`echo "scale=2; $sommatoria/($righeTot)" | bc -q`
sommatoria=`echo "scale=2; sqrt($sommatoria)" | bc -q `
deviazioneTot=$sommatoria
echo "TOT: $righeTot $sommaTot $mediaTot $deviazioneTot"
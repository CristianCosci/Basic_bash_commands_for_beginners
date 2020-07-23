#!/bin/bash
function scelta1() #funzione per rimozione dei due file
{
    echo "Sei sicuro di voler rimuovere i due file ? (S/N)"
    escape1=1
	while [ $escape1 != 0 ]; do 
		read risposta1
		if [ "$risposta1" = "N" -o "$risposta1" = "S" ]; then
			escape1=0
		else
			echo "inserisci una risposta corretta"
		fi 
	done
    if [ "$risposta1" = "S" ]; then
        rm $1
        rm $2
    else 
        echo "$0 : USCITA"
        exit 0
    fi
}

function scelta2()
{   
    nome1=$(basename "$1") #questi due passaggi servono per prendere solo il nome dei due file senza estensione(nel caso ci fosse) nel nome (anche se parlare di estensione in linux può essere errato in quanto effettivamente non esistono su questo sistema operativo)
    nome2=$(basename "$2")
    local nome_dir="$nome1$nome2" #unisco i due nomi, questa stringa andrà a formare il nome dell'archivio
    if [ -e $nome_dir.tar.gz ]; then #da qui in ppi è lo stesso script dell'esercizio 3
		echo "l'archivio $stringa esiste già, vuoi sovrascriverlo? (S/N)"
		escape3=1
		while [ $escape3 != 0 ]; do 
		    read risposta3
			if [ "$risposta3" = "N" -o "$risposta3" = "S" ]; then
				escape3=0
			else
				echo "inserisci una risposta corretta"
			fi 
		done
		if [ "$risposta3" = "S" ]; then
			rm $nome_dir.tar.gz
		else 
            echo "$0 : USCITA"
			exit
		fi
	fi
    if tar -czf $nome_dir.tar.gz $1 $2; then	
		echo "archivio creato con successo, il suo contenuto è: "
		tar -tf $nome_dir.tar.gz 
	else 
		echo "$0 : errore nella creazione dell'archivio"
		exit
	fi
}

function scelta3() #appende il contenuto del primo argomento sul secondo
{
    cat $1 >> $2
}

function scelta4() #chiude l'esecuzione dello script
{
    echo "$0 : USCITA"
    exit 0
}

if [ $# != 2 ]; then #controllo sugli argomenti passati 
    echo "$0: ERRORE, utilizzo dello script : ./esercizio5.sh file1 file2"
    exit 1
else
    tipo1=`file -b $1|grep text` #un controllo strano ma efficente e funzionante per il controllo se gli argomenti passati sono file e hanno del testo al loro interno da poter appendere
    tipo2=`file -b $2|grep text` #andrebbe bene anche un semplice controllo sul fatto se sia o meno un file in quanto il cat stampa lo stesso il suo contenuto come testo, ed è quindi possibile appenderlo
    if  [ -n "$tipo1" ]; then
        if  [ -n "$tipo2" ]; then #stampo il menu se i controlli sono andati bene 
            echo "COSA VUOI FARE ?"
            echo "- 1. rimuovere entrambi i file"
            echo "- 2. archiviare entrambi i file"
            echo "- 3. appendere il file f1 al file f2"
            echo "- 4. esci"
			escape=1
			while [ $escape != 0 ]; do #controllo sull'input inserito dall'utente
				read risposta
				if [ "$risposta" = "1" -o "$risposta" = "2" -o "$risposta" = "3" -o "$risposta" = "4" ]; then
					escape=0
				else
					echo "inserisci una risposta corretta"
				fi 
			done
            case $risposta in #chiamo ogni funzione e gli passo come argomenti i due file in base ad ogni tipo di scelta
                1)
                    scelta1 $1 $2
                    ;;
                2)
                    scelta2 $1 $2
                    ;;
                3)
                    scelta3 $1 $2
                    ;;
                4)
                    scelta4
                    ;;
                *)
                    echo "$0 : ERRORE"
                    ;;
            esac
        else
            echo "$0 ERRORE: i due argomenti devono essere due file di testo"
            exit 1
        fi
    else
        echo "$0 ERRORE: i due argomenti devono essere due file di testo"
        exit 1
    fi 
fi 
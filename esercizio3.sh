#!/bin/bash

if [ $# != 1 ]; then #controlla il numero degli argomenti 
	if [ $# -ge 2 ]; then
		echo "Utilizzo di questo script : $0 nome_directory"
		exit 1
	else
		echo "Utilizzo di questo script : $0 nome_directory"
		exit 1
	fi
else
	if ! [ -d $1 ]; then #controllo se l'argomento è una directory
		echo "$0 : l'argomento deve essere una directory"
		exit 1
	else
		if [ -e $1.tar.gz ]; then #controlla se esiste già un file con questo nome nella directory corrente
			echo "l'archivio $stringa esiste già, vuoi sovrascriverlo? (S/N)"
			escape=1
			while [ $escape != 0 ]; do #controllo sull'input fornito dall'utente
				read risposta
				if [ "$risposta" = "N" -o "$risposta" = "S" ]; then
					escape=0
				else
					echo "inserisci una risposta corretta"
				fi 
			done
			if [ "$risposta" = "S" ]; then 
				rm  $1.tar.gz #rimozione della directory
			else 
				exit 0
			fi
		fi
		if tar -zcf $1.tar.gz $1 ; then	#controllo sull'exit status del comando 
			echo "archivio creato con successo, il suo contenuto è: "
			tar -tf $1.tar.gz #stampo il contenuto della directory con -t
		else 
			echo "$0 : errore nella creazione dell'archivio"
			rm $1.tar.gz #rimuovo la directory che viene creata lo stesso anche se vi è un errore
			exit 1
		fi
	fi
fi
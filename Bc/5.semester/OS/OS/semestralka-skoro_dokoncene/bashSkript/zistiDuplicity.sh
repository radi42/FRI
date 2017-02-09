#!/bin/bash
#Poznamka - skript zahlasi chybu "too many arguments" ak sa v nazve suboru nachadza biely znak (napr. medzera)

#ako spustit skript v skripte?
#echo "Klient pridava zaznamy do databazy. Niektore z nich su duplicitne."
#source ${HOME}/Desktop/OS/semestralka/netbeans/databaza_klient_prerobeny/databaza_klient.sh localhost 5178 insert -k kluc -h "Wolfgang Gartner ft. deadmau5"

echo Hladanie duplicit v adresari: ${HOME}/databazove_subory;
echo

SUBORY=${HOME}/databazove_subory/*.txt;
(ls -l $SUBORY)
echo

for f in $SUBORY		#f ako file
do
	if [ -f $f ]		#zisti, ci subor existuje
	then
		checksum1=($(sha1sum $f))
		sha1sum $f
	
		for of in $SUBORY	#of ako otherFile
		do
			if [ $f != $of ]
			then
				checksum2=($(sha1sum $of))
				sha1sum $of
				#echo $checksum1
				#echo $checksum2
			
				#ak sa nasla zhoda, prvy subor nechaj, duplicitny subor vymaz
				if [ "$checksum1" == "$checksum2" ] || [ "$checksum2" == "$checksum1" ]
				then
					echo
					echo Najdena duplicita
					sha1sum $f
					sha1sum $of
					rm $of
					echo Duplicitny subor $of vymazany
					echo
				fi
			fi
		done

		echo
	fi
done

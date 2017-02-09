#!/bin/bash
#Pouzitie: ./zistiDuplicity.sh <cesta_ku_priecinku>
#./zistiDuplicity.sh /etc

SUBORY=$1/*

if [ ! -d "$1" ]	#ak taky adresar neexistuje, vypis navod na pouzitie
then
	echo
	echo "Nespravny format cesty ku adresaru"
	echo "$1" nie je platny adresar
	echo "Pouzitie: ./zistiDuplicity.sh <platna_cesta_ku_priecinku>"
	echo "napriklad"
	echo "./zistiDuplicity.sh /etc"
	echo
else
	for f in $SUBORY
	do
		if [ ! -d "$f" ] && [[ -r "$f" ]]	#ak to nie je adresar a zaroven mam pravo na citanie
		then
			echo "$f"

			#vypocitaj hash obsahu suboru (kluc = hash)
			checksumSuborLokalny=($(sha1sum $f))
			echo $checksumSuborLokalny
		
		
			#opytaj sa servera na dany kluc (select -k kluc)
			obsahSuborServerovy=`./databaza_klient localhost 5178 select -k $checksumSuborLokalny`
			echo $obsahSuborServerovy

			#porovnaj obsah suboru s prazdnym retazcom
			if [ -z $obsahSuborServerovy ]
			then
				#ak mi server vrati prazdny retazec, ulozim subor na server, kde klucom bude jeho hash a obsahom bude jeho cesta
				echo OK
				`./databaza_klient localhost 5178 insert -k "$checksumSuborLokalny" -h "$f"` 2>/dev/null
				echo Zaznam ulozeny
			else
				#inak vypis dvojicu duplicitnych suborov (cestu aktualne spracovavaneho suboru z z prehladavaneho priecinka a obsah suboru
				echo DUPLICITA
				echo PC: $f
				echo Server: `${HOME}/Desktop/OS/semestralka/netbeans/databaza_klient_prerobeny/databaza_klient localhost 5178 select -k "$checksumSuborLokalny"`
				echo Checksum: $checksumSuborLokalny
			
			
			fi
			echo
			echo
			echo
		fi
	done
fi

#!/bin/bash
echo Peter Grof, 5ZI036
echo Jednoduchy server pre logovanie sprav
echo ""

while :
do
echo '
    [1]Spustenie servera
    [2]Dokumentacia
    [3]Zdrojove kody
    [4]Koniec
'
read -n1 -p 'Zadajte svoj vyber: ' X
echo ""
case "${X}" in
    1)make clean all
		echo Server je po spusteni ukoncit klavesovou skratkou "CTRL + C"
		echo Klienta treba spustit v samostatnom terminalovom okne.
		echo Testovacie prikazy klientskej aplikacie
		echo ./databaza_klient localhost 5178 insert -k dalsikluc -h \"viac textu\"
		echo ./databaza_klient localhost 5178 select -k kluc
		echo ./databaza_klient localhost 5178 delete -k kluc
		echo
		./databaza_server 5178;;
    2)cat README.txt;;
    3)cat databaza_server.c
      		echo
		cat databaza_klient.c;;
    4)exit;;
esac

done


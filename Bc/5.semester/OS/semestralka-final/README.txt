Dokumentácia k semestrálnej práci
Autor: Andrej Šišila
Téma: NoSQL DBM systém implementovaný pomocou soketov

Ovládanie databázového klienta
	Klient môže na server ukladať dvojicu údajov (kľúč a hodnotu).
		./databaza_klient localhost 5178 insert -k kluc -h hodnota

	Klient môže upraviť obsah súboru podľa kľúča, ak už súbor s daným názvom už existuje.
		./databaza_klient localhost 5178 insert -k kluc -h "dalsia hodnota"

	Klient môže zobraziť obsah súboru podľa zadaného kľúča. Ak súbor neexistuje, vypíše sa prázdny reťazec
		./databaza_klient localhost 5178 select -k kluc
		./databaza_klient localhost 5178 select -k klcu

	Klient môže vymazať súbor podľa kľúča. Ak súbor neexistuje, klientovi sa o tom pošle správa.
		./databaza_klient localhost 5178 delete -k kluc

	Klient môže zadávať nepodporované príkazy, avšak tie nič nevykonajú.
		./databaza_klient localhost 5178 zlyprikaz



Ovládanie databázového servera
	Databázový server stačí iba spustiť príkazom "./databaza_server 5178", kde "5178" je číslo portu, cez ktorý sa na server dá pripojiť. Server pracuje so súbormi (ukladanie, vymazávanie) v priečinku ${HOME}/databazove_subory .



Bash skript
	Bash skript "zistiDuplicity.sh" vie vyhľadať a vymazať duplicitné súbory. Používa na to porovnanie kontrolných súm SHA-1 medzi dvomi súbormi. V prípade, že majú rovnaký obsah, potom aj ich kontrolná suma bude rovnaká. Následne sa ten súbor, ktorý bol vybraný ako druhý (duplicitný), vymaže.

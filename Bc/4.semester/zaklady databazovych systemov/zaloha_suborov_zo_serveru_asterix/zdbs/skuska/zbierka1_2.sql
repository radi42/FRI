--Vypiste informacie o vsetkych letoch ktore letia 16.6.2015 (+-3dni) z Bratislavy,Viedne do Londyna zoradte podla dat a ceny.
select letisko_z,letisko_do,datum_letu datum 
FROM L_let 
JOIN L_letisko LetiskoZ ON letisko_z=LetiskoZ.id_letiska 
JOIN L_letisko LetiskoDo ON letisko_do=letiskoDo.id_letiska 
JOIN L_mesto MestoZ ON MestoZ.psc=LetiskoZ.psc AND MestoZ.id_krajiny=LetiskoZ.id_krajiny 
JOIN L_mesto MestoDo on MestoDo.psc=LetiskoDo.psc AND MestoDo.id_krajiny=LetiskoDo.id_krajiny 
WHERE (datum_letu between to_date('16.06.2015','DD.MM.YYYY')-3 AND to_date('16.06.2015','DD.MM.YYYY')+3)
AND (mestoZ.nazov='Bratislava' OR mestoZ.nazov='Vieden')
AND MestoDo.nazov='London'
ORDER BY datum_letu,cena_letu;








/*
select datum_letu datum, letisko_z, letisko_do
from l_let
join l_letisko letiskoZ on letiskoZ.id_letiska=letisko_z
join l_letisko letiskoDo on letiskoDo.id_letiska=letisko_do
join l_mesto mestoZ on mestoZ.psc=letiskoZ.psc AND mestoZ.id_krajiny=letiskoZ.id_krajiny
join l_mesto mestoDo on mestoDo.psc=letiskoDo.psc AND mestoDo.id_krajiny=letiskoDo.id_krajiny
where mestoZ.nazov IN ('Bratislava', 'Vieden')
and mestoDo.nazov='London'
and datum_letu between to_date('16-06-2015','DD-MM-YYYY')-3 and to_date('16-06-2015','DD-MM-YYYY')+3
order by datum_letu,cena_letu;
*/
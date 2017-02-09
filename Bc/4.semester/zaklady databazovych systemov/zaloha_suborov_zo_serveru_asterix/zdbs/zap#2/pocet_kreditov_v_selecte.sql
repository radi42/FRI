SELECT st.os_cislo, ou.meno, ou.priezvisko, pocet_kreditov(st.os_cislo)
FROM student st 
JOIN os_udaje ou ON (st.rod_cislo = ou.rod_cislo);

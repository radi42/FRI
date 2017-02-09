select meno, priezvisko
from os_udaje
where to_char(RCtoDatum(rod_cislo),'DD.MM') = to_char(sysdate,'DD.MM');
--staci ked sa rovnaju mesiac a den (rok nie!)
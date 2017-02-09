variable pocet NUMBER;
execute :pocet:=prejazd_vlaku(12345,to_date('15-10-2003','DD-MM-YYYY'),to_date('18-10-2003','DD-MM-YYYY'));
print pocet;
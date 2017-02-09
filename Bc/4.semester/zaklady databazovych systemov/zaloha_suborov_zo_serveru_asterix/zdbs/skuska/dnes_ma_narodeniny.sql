create or replace function RCtoDatum(rc varchar2)
--varchar je bez dlzky
return date
is
pom varchar2(10);
begin

pom := substr(rc,5,2)||'-';
if(substr(rc,3,1)=5 OR substr(rc,3,1)=0) THEN
  pom := pom||'0'||substr(rc,4,1);
else
  pom := pom||'1'||substr(rc,4,1);
end if;
  
  pom := pom||'-19'||substr(rc,1,2);
return to_date(pom, 'dd-mm-yyyy');


--neplatne rodne cislo
EXCEPTION when others then
return to_date('01-01-0001', 'dd-mm-yyyy');

end;
/

show err;
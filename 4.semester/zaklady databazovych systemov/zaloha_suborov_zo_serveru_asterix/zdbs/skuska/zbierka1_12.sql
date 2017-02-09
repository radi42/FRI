--pridajte let. spol. skypeline kt. sidli v mnichove

--najprv treba pridat mesto 'Mnichov'
--insert into l_mesto values ('85356', 'DE', 'Mnichov');

--potom pridaj letecku spolocnost
insert into l_let_spolocnost
values (1234,'Skypeline', null, 
'85356',
(select id_krajiny from l_krajina join l_mesto using(id_krajiny) 
  where nazov='Mnichov')
);
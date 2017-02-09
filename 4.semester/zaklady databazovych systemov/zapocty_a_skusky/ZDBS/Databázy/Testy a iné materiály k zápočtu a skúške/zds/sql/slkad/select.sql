select x1.constraint_name, x1.table_name, x1.constraint_type, x1.r_constraint_name, x2.table_name
 from user_constraints x1, user_constraints x2 
where x1.table_name='KARTA' and x1.r_constraint_name = x2.constraint_name;
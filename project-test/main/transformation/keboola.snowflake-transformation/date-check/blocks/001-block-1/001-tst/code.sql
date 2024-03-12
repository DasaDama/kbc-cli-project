--tst
set today=convert_timezone('Europe/Prague',current_date)::date;

create table "exit_code_table" as 
select $today as "date",iff(max("date")=$today,0,1) as "exit_code" from "rates";

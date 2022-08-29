-- funciones de fecha y hora

-- add_months(f,n): agrega a una fecha, un número de meses. Si el segundo argumento es positivo, se le suma 
-- a la fecha enviada tal cantidad de meses; si es negativo, se le resta a la fecha enviada tal cantidad de meses.

select add_months('10/06/2020',5) from dual;

select add_months('10/06/2020',-5) from dual;

select add_months('30/01/2020',1) from dual;

-- last_day(f): retorna el ultimo día de mes de la fecha enviada como argumento.

select last_day('10/02/2020') from dual;

select last_day('10/08/2020') from dual;

-- months_between(f1,f2): retorna el numero de meses entre las fechas enviadas como argumento.

select months_between('19/05/2020', '21/06/2020') from dual;

-- next_day(fecha,dia): retorna una fecha correspondiente al primer día especificado en "dia" luego de la fecha especificada. 
-- En el siguiente ejemplo se busca el lunes siguiente a la fecha especificada:

select next_day('10/08/2020', 'LUNES') from dual;

-- current_date: retorna la fecha actual.

select current_date from dual;

-- current_timestamp: retorna la fecha actual.

select current_timestamp from dual;

-- sysdate: retorna la fecha y hora actuales en el servidor de Oracle.

select sysdate from dual;

-- systimestamp: retorna fecha y horas actuales. 

select systimestamp from dual;

-- to_date: convierte una cadena a tipo de dato "date".

select to_date ('05-SEP-2019 10:00 AM', 'DD-MON-YYYY HH:MI:AM') from dual;

-- to_char: convierte una fecha a cadena de caracteres.

select to_char('10/10/2020') from dual;

-- extract(parte from fecha): retorna la parte (especificada por el primer argumento) de una fecha. Puede extraer el año (year), 
-- mes (month), día (day), hora (hour), minuto (minute), segundo (second), etc.

select extract(day from sysdate) from dual;

select extract(year from sysdate) from dual;

-- En Oracle: Los operadores aritméticos "+" (más) y "-" (menos) pueden emplearse con fechas.

select sysdate - 3 from dual;

select to_date('15/12/2020') - 5 from dual;


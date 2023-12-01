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

-- Ejercicio 1

drop table libros;

create table libros(
  titulo varchar2(40) not null,
  autor varchar2(20) default 'Desconocido',
  editorial varchar2(20),
  edicion date,
  precio number(6,2)
);

insert into libros values('El aleph','Borges','Emece','10/10/1980',25.33);
insert into libros values('Java en 10 minutos','Mario Molina','Siglo XXI','05/05/2000',50.65);
insert into libros values('Alicia en el pais de las maravillas','Lewis Carroll','Emece','08/09/2000',19.95);
insert into libros values('Aprenda PHP','Mario Molina','Siglo XXI','02/04/2000',45);

-- mostrando el título y el año de edición

select titulo, extract (year from edicion) from libros;

-- mostrando el titulo del libro y el mes de edicion

select titulo, extract(month from edicion) from libros;

-- mostrando el titulo del libro y los años que tienen de editados:

select titulo, extract(year from sysdate) - extract(year from edicion) from libros;

-- mostrando los titulos de los libros que se editaron en el año 2000

select titulo from libros where extract(year from edicion) = 2000;

-- calcule 3 meses luego de la fecha actual empleando "add_months"

select add_months(sysdate, 3) from dual;

-- muestre la fecha del primer martes desde la fecha actual

select next_day(sysdate, 'MARTES') from dual;

-- muestra la fecha que sera 15 días después de "24/08/2018" empleando el operador "+"

select to_date('24/08/2018') + 15 from dual;

-- muestre la fecha que 20 días antes del "12/08/2018" empleando el operador "-"

select to_date('12/08/2018') - 20 from dual;

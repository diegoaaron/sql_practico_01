-- Funciones asociadas a String

/*
La tabla DUAL es una tabla especial de una sola columna presente de manera predeterminada en todas las instalaciones de 
bases de datos de Oracle. Se utiliza cuando queremos hacer un select que no necesita consultar tablas. 
La tabla tiene una sola columna VARCHAR2(1) llamada DUMMY que tiene un valor de 'X'
*/

select chr(65) from dual;

select chr(100) from dual;

select * from dual;

-- concat(cadena1,cadena2): concatena dos cadenas de caracteres; es equivalente al operador ||. Ejemplo:

select concat('Buenas', ' tardes') as concatenacion from dual;

-- initcap(cadena): retorna la cadena enviada como argumento con la primera letra (letra capital) de cada palabra en mayúscula. 

select initcap('buenas tardes alumnos') from dual;

-- lower(cadena): retorna la cadena enviada como argumento en minúsculas.

select lower('Buenas tardes ALUMNO') from dual;

-- upper(cadena): retorna la cadena con todos los caracteres en mayúsculas.

select upper('www.oracle.com') from dual;

-- lpad(cadena,longitud,cadenarelleno): retorna la cantidad de caracteres especificados por el argumento "longitud", 
-- de la cadena enviada como primer argumento (comenzando desde el primer caracter); si "longitud" es mayor que el 
-- tamaño de la cadena enviada, rellena los espacios restantes con la cadena enviada como tercer argumento 
-- (en caso de omitir el tercer argumento rellena con espacios); el relleno comienza desde la izquierda. 

select lpad('alumno',10,'xyz') from dual;

select lpad('alumno',10,'xyz') from dual;

-- rpad(cadena,longitud,cadenarelleno): retorna la cantidad de caracteres especificados por el argumento "longitud", 
-- de la cadena enviada como primer argumento (comenzando desde el primer caracter); si "longitud" es mayor que 
-- el tamaño de la cadena enviada, rellena los espacios restantes con la cadena enviada como tercer argumento 
-- (en caso de omitir el tercer argumento rellena con espacios); el relleno comienza desde la derecha (último caracter). 

select rpad('alumno', 10,'xyz') from dual;

select rpad('alumno', 4, 'xyz') from dual;

-- ltrim(cadena1,cadena2): borra todas las ocurrencias de "cadena2" en "cadena1", si se encuentran al comienzo; 
-- si se omite el segundo argumento, se eliminan los espacios.

select ltrim('la casa de la cuadra','la') from dual;

select ltrim(' es la casa de la cuadra','la') from dual; -- no borra nada por no estar al inicio

select ltrim('  la casa') from dual;

select ltrim('esta          la    casa') from dual; -- no borra nada por no estar al inicio

-- rtrim(cadena1,cadena2): borra todas las ocurrencias de "cadena2" en "cadena1", si se encuentran por la derecha 
-- (al final de la cadena); si se omite el segundo argumento, se borran los espacios. 

select rtrim('la casa lila','la') from dual;

select rtrim('la casa lila ','la') from dual;-- no borra ningún caracter

select rtrim('la casa lila    ') from dual;

-- trim(cadena): retorna la cadena con los espacios de la izquierda y derecha eliminados. "Trim" significa recortar. 

select trim('   oracle     ') from dual;

-- replace(cadena,subcade1,subcade2): retorna la cadena con todas las ocurrencias de la subcadena de reemplazo 
-- (subcade2) por la subcadena a reemplazar (subcae1). 

select replace('xxx.oracle.com','x','w') from dual;

-- substr(cadena,inicio,longitud): devuelve una parte de la cadena especificada como primer argumento, 
-- empezando desde la posición especificada por el segundo argumento y de tantos caracteres de longitud como 
-- indica el tercer argumento.

select substr('www.oracle.com',1,10) from dual;

select substr('www.oracle.com',5,6) from dual;

-- length(cadena): retorna la longitud de la cadena enviada como argumento. "lenght" significa longitud en inglés.

select length('www.oracle.com') from dual;

-- instr (cadena,subcadena): devuelve la posición de comienzo (de la primera ocurrencia) de la subcadena especificada 
-- en la cadena enviada como primer argumento. Si no la encuentra retorna 0.

select instr('Jorge Luis Borges','or') from dual;

select instr('Jorge Luis Borges','ar') from dual;

-- translate(): reemplaza cada ocurrencia de una serie de caracteres con otra serie de caracteres. La diferencia 
-- con "replace" es que aquella trabaja con cadenas de caracteres y reemplaza una cadena completa por otra, 
-- en cambio "translate" trabaja con caracteres simples y reemplaza varios. En el siguiente ejemplo se especifica que se 
-- reemplacen todos los caracteres "O" por el caracter "0", todos los caracteres "S" por el caracter "5" y todos los 
-- caracteres "G" por "6"

select translate('JORGE LUIS BORGES','OSG','056') from dual;

-- Se pueden emplear estas funciones enviando como argumento el nombre de un campo de tipo caracter.

-- Ejercicio 1

drop table libros;

create table libros(
  codigo number(5),
  titulo varchar2(40) not null,
  autor varchar2(20) default 'Desconocido',
  editorial varchar2(20),
  precio number(6,2),
  cantidad number(3)
);

insert into libros values(1,'El aleph','Borges','Emece',25,100);
insert into libros values(2,'Java en 10 minutos','Mario Molina','Siglo XXI',50.40,100);
insert into libros values(3,'Alicia en el pais de las maravillas','Lewis Carroll','Emece',15.50,200);
insert into libros values(4,'El pais de las hadas',default,'Emece',25.50,150);

select substr(titulo, 1, 12) as titulo from libros;

select rpad(titulo, 20, '*') as titulo from libros;

select initcap(titulo) as titulo from libros;

select titulo, upper(autor) as autor from libros;

select concat(titulo, autor) from libros;

select titulo, concat('$ ', precio) as precio from libros;

select titulo, replace(editorial, 'Emece', 'Sudamericana') from libros;

select translate(autor, 'abc ', 'ABC') from libros;

select instr(titulo, 'pais') from libros;


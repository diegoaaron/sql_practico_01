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

-- initcap(cadena): retorna la cadena enviada como argumento con la primera letra (letra capital) de cada palabra en may�scula. 

select initcap('buenas tardes alumnos') from dual;

-- lower(cadena): retorna la cadena enviada como argumento en min�sculas.

select lower('Buenas tardes ALUMNO') from dual;

-- upper(cadena): retorna la cadena con todos los caracteres en may�sculas.

select upper('www.oracle.com') from dual;

-- lpad(cadena,longitud,cadenarelleno): retorna la cantidad de caracteres especificados por el argumento "longitud", 
-- de la cadena enviada como primer argumento (comenzando desde el primer caracter); si "longitud" es mayor que el 
-- tama�o de la cadena enviada, rellena los espacios restantes con la cadena enviada como tercer argumento 
-- (en caso de omitir el tercer argumento rellena con espacios); el relleno comienza desde la izquierda. 

select lpad('alumno',10,'xyz') from dual;

select lpad('alumno',10,'xyz') from dual;

-- rpad(cadena,longitud,cadenarelleno): retorna la cantidad de caracteres especificados por el argumento "longitud", 
-- de la cadena enviada como primer argumento (comenzando desde el primer caracter); si "longitud" es mayor que 
-- el tama�o de la cadena enviada, rellena los espacios restantes con la cadena enviada como tercer argumento 
-- (en caso de omitir el tercer argumento rellena con espacios); el relleno comienza desde la derecha (�ltimo caracter). 

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

select rtrim('la casa lila ','la') from dual;-- no borra ning�n caracter

select rtrim('la casa lila    ') from dual;

-- trim(cadena): retorna la cadena con los espacios de la izquierda y derecha eliminados. "Trim" significa recortar. 

select trim('   oracle     ') from dual;

-- replace(cadena,subcade1,subcade2): retorna la cadena con todas las ocurrencias de la subcadena de reemplazo 
-- (subcade2) por la subcadena a reemplazar (subcae1). 

select replace('xxx.oracle.com','x','w') from dual;

-- substr(cadena,inicio,longitud): devuelve una parte de la cadena especificada como primer argumento, 
-- empezando desde la posici�n especificada por el segundo argumento y de tantos caracteres de longitud como 
-- indica el tercer argumento.


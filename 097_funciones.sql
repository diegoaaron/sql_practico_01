/*
Oracle ofrece varios tipos de funciones para realizar distintas operaciones. Hemos empleado varias de ellas.

Se pueden emplear las funciones del sistema en cualquier lugar en el que se permita una expresión en una sentencia "select".

Ahora aprenderemos a crear nuestras propias funciones.

Las funciones, como los procedimientos almacenados son bloques de código que permiten agrupar y organizar sentencias 
SQL que se ejecutan al invocar la función.

Las funciones tienen una estructura similar a la de los procedimientos. Como los procedimientos, las funciones tienen una 
cabecera, una sección de declaración de variables y el bloque "begin...end" que encierra las acciones. Una función, además 
contiene la cláusula "return".

Una función acepta parámetros, se invoca con su nombre y retorna un valor.

Para crear una función empleamos la instrucción "create function" o "create or replace function". Si empleamos "or replace", 
se sobreescribe (se reemplaza) una función existente; si se omite y existe una función con el nombre que le asignamos, 
Oracle mostrará un mensaje de error indicando tal situación.

La sintaxis básica parcial es:

create o replace function NOMBREFUNCION(PARAMETRO1 TIPODATO, PARAMETRON TIPODATO)
 return TIPODEDATO is
  DECLARACION DE VARIABLES
 begin
  ACCIONES;
  return VALOR;
 end;
 /
La siguiente funcion recibe 1 parámetro, un valor a incrementar y retorna el valor ingresado como argumento con el incremento 
del 10%:

create or replace function f_incremento10 (avalor number)
  return number
 is
 begin 
   return avalor+(avalor*0.1);
 end;
 /
 
Es importante el caracter '/' que al igual que los procedimientos almacenados se le informa al SQL Developer el fin de la función.

Podemos emplear las funciones en cualquier lugar en el que se permita una expresión en una sentencia "select", por ejemplo:

 select titulo,precio,f_incremento10(precio) from libros;
 
El resultado mostrará el título de cada libro, el precio y el precio incrementado en un 10% devuelto por la función.

La siguiente funcion recibe 2 parámetros, un valor a incrementar y el incremento y retorna el valor ingresado como primer 
argumento con el incremento especificado por el segundo argumento:

create or replace function f_incremento (avalor number, aincremento number)
  return number
 is
  begin 
   return avalor+(avalor*aincremento/100);
  end;
  /
  
Realizamos un "select" y llamamos a la función creada anteriormente, enviando como primer argumento el campo "precio" y 
como segundo argumento el valor "20", es decir, incrementará en un 20" los precios de los libros:

 select titulo,precio,f_incremento(precio,20) from libros;
El resultado nos mostrará el título de cada libro, el precio y el precio incrementado en un 20% devuelto por la función.

Podemos realizar otros "select" llamando a la función con otro valor como segundo argumento, por ejemplo:

 select titulo,precio,f_incremento(precio,50) from libros;
La siguiente función recibe un parámetro de tipo numérico y retorna una cadena de caracteres. Se define una variable en la 
zona de definición de variables denominada "valorretornado" de tipo varchar. En el cuerpo de la función empleamos una 
estructura condicional (if) para averiguar si el valor enviado como argumento es menor o igual a 20, si lo es, almacenamos 
en la variable "valorretornado" la cadena "economico", en caso contrario guardamos en tal variable la cadena "costoso"; 
al finalizar la estructura condicional retornamos la variable "valorretornado":

create or replace function f_costoso (avalor number)
  return varchar
 is
  valorretornado varchar(20);
 begin
   valorretornado:='';
   if avalor<=20 then
    valorretornado:='economico';
   else valorretornado:='costoso';
   end if;
   return valorretornado;
 end;
 /
 
Realizamos un "select" y llamamos a la función creada anteriormente, enviando como argumento el campo "precio":

 select titulo,precio,f_costoso(precio) from libros;
El resultado mostrará el título de cada libro, el precio y el resultado devuelto por la función (si el precio es menor o mayor a 
$20, la cadena "economico" o "costoso" respectivamente).

Entonces, una función es un bloque de código que implementa acciones y que es referenciado por un nombre. Puede recibir 
argumentos. La diferencia con los procedimientos es que retornan un valor siempre.

Para asignar un valor a una variable, dentro de una función DEBE usarse ":=" (dos puntos e igual).

Si no se le definen parámetros a una función, no deben colocarse los paréntesis.

Podemos emplear una función sin incluir campos de una tabla. Por ejemplo:

 select f_costoso (10) from dual;
Para almacenar los valores de un "select" debemos tipear:

 select ...into VARIABLE from...
Por ejemplo:

 select sum(precio) into variable from libros where autor='';
La siguiente función recibe dos valores numéricos como parámetros y retorna el promedio:

create or replace function f_promedio (avalor1 number, avalor2 number)
 return number
 is
 begin 
   return (avalor1+avalor2)/2;
 end;
 /
Llamamos a la función "f_promedio":

 select f_promedio (10,20) from dual;
*/

 drop table libros;

 create table libros(
  codigo number(3),
  titulo varchar2(40),
  autor varchar2(30),
  precio number(5,2)
);

 insert into libros values(100,'Uno','Richard Bach',15);
 insert into libros values(300,'Aprenda PHP','Mario Molina',55);
 insert into libros values(102,'Matematica estas ahi','Paenza',18);
 insert into libros values(105,'El aleph','Borges',25);
 insert into libros values(109,'El experto en laberintos','Gaskin',20);
 insert into libros values(204,'Alicia en el pais de las maravillas','Carroll',31);
 
 -- Creamos o reemplazamos una función que reciba 1 parámetro (un valor numérico a incrementar) y retorne el valor 
 -- ingresado como argumento con el incremento del 10%:

create or replace function f_incremento10 (avalor number) 
return number is 
begin 
return avalor + (avalor*0.1);
end;
/

-- Realizamos un "select" sobre "libros" que muestre el título, precio y llamamos a la función creada anteriormente para que 
-- nos devuelva el precio incrementado en un 10%:

select titulo, precio, f_incremento10(precio) from libros;
 
 -- Creamos otra función que reciba 2 parámetros, un valor a incrementar y el incremento, y que nos retorne el valor ingresado 
 -- como primer argumento con el incremento especificado por el segundo argumento:

create or replace function f_incremento (avalor number, aincremento number) 
return number is 
begin 
return avalor + (avalor * aincremento/100);
end;
/

--  Realizamos un "select" sobre "libros" que muestre el título, precio y el precio incrementado en un 20% (llamando a la 
-- función creada anteriormente, enviando como primer argumento el campo "precio" y como segundo argumento el valor "20"):

select titulo, precio, f_incremento(precio, 20) from libros;

-- Realizamos otro "select" similar al anterior, pero en esta ocasión le enviamos a la función otro valor como segundo argumento:

select titulo, precio, f_incremento(precio,50) from libros;

-- Creamos o reemplazamos una función que recibe un parámetro de tipo numérico y retorna una cadena de caracteres. 
-- Se define una variable en la zona de definición de variables denominada "valorretornado" de tipo varchar. En el cuerpo 
-- de la función empleamos una estructura condicional (if) para averiguar si el valor enviado como argumento es menor o 
-- igual a 20, si lo es, almacenamos en la variable "valorretornado" la cadena "economico", en caso contrario guardamos en 
-- tal variable la cadena "costoso"; al finalizar la estructura condicional retornamos la variable "valorretornado":

create or replace function f_costoso (avalor number) 
return varchar2 is
valorretornado varchar2(20);
begin
valorretornado := '';
if avalor <= 20 then
valorretornado := 'economico';
else valorretornado:= 'costoso';
end if;
return valorretornado;
end;
/

-- Realizamos un "select" para mostrar el título, precio y una cadena que indique si el libro es económico o costoso (llamando 
-- a la función creada anteriormente):

select titulo, precio, f_costoso(precio) from libros;

-- Podemos emplear la función "f_costoso" sin incluir campos de una tabla. Por ejemplo:

select f_costoso(100) from dual;

 
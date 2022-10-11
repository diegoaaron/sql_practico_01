/*
Las estructuras de control pueden ser condicionales y repetitivas.

Estructuras de control de flujo, bifurcaciones condicionales y bucles. Veremos las condicionales. existen 2: if y case.

Existen palabras especiales que pertenecen al lenguaje de control de flujo que controlan la ejecución de las sentencias, los 
bloques de sentencias y procedimientos almacenados. Tales palabras son: "begin... end", "if... else", "while", "break" y 
"continue", "return" y "waitfor".

"if... else" testea una condición; se emplea cuando un bloque de sentencias debe ser ejecutado si una condición se cumple y 
si no se cumple, se debe ejecutar otro bloque de sentencias diferente.

Sintaxis:

 if (CONDICION) then
   SENTENCIAS-- si la condición se cumple
 else
   SENTENCIAS-- si la condición resulta falsa
 end if; 
*/
 drop table notas;

 create table notas(
  nombre varchar2(30),
  nota number(4,2)
 );

 insert into notas values('Acosta Ana', 6.7);
 insert into notas values('Bustos Brenda', 9.5);
 insert into notas values('Caseros Carlos', 3.7);
 insert into notas values('Dominguez Daniel', 2);
 insert into notas values('Fuentes Federico', 8);
 insert into notas values('Gonzalez Gaston', 7);
 insert into notas values('Juarez Juana', 4);
 insert into notas values('Lopez Luisa',5.3);

-- Creamos o reemplazamos la función "f_condicion" que recibe una nota y retorna una cadena de caracteres indicando 
-- si aprueba o no:



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

create or replace function f_condicion (anota number) 
return varchar2 is
condicion varchar2(20);
begin 
condicion := '';
if anota <4 then
condicion := 'desaprobado';
else condicion := 'aprobado';
end if;
return condicion;
end;
/

-- Realizamos un "select" sobre "notas" mostrando el nombre y nota del alumno y en una columna su condición (empleando 
-- la función creada anteriormente):

select nombre, nota, f_condicion(nota) from notas;

-- En el siguiente ejemplo omitimos la cláusula "else" porque sólo indicaremos acciones en caso que el "if" sea verdadero:

create or replace function f_condicion (anota number) 
return varchar2 is
condicion varchar2(20);
begin
condicion := 'aprobado';
if anota < 4 then
condicion := 'desaprobado';
end if;
return condicion;
end;
/

-- Realizamos el "select" sobre "notas" mostrando la misma información que antes:

select nombre, nota, f_condicion(nota) from notas;

-- En el siguiente ejemplo colocamos un "if" dentro de otro "if". En el cuerpo de la función controlamos si la nota es menor a 
-- 4 (retorna "desaprobado"), luego, dentro del "else", controlamos si la nota es menor a 8 (retorna "regular") y si no lo es 
-- ("else"), retorna "promocionado":

create or replace function f_condicion(anota number) 
return varchar2 is
condicion varchar2(20);
begin
condicion := '';
if anota < 4 then
condicion := 'desaprobado';
else 
if anota < 8 then
condicion := 'regular';
else 
condicion := 'promocionado';
end if;
end if;
return condicion;
end;
/

-- Realizamos el "select" sobre "notas" mostrando la misma información que antes:

select nombre, nota, f_condicion(nota) from notas;

-- Simplificamos la función anteriormente creada empleando la sintaxis "if...elsif":

create or replace function f_condicion (anota number)
return varchar2 is
condicion varchar2(20);
begin
condicion := '';
if anota <4 then 
condicion := 'desaprobado';
elsif anota < 8 then
condicion := 'regular';
else
condicion := 'promocionado';
end if;
return condicion;
end;
/

-- Realizamos el "select sobre "notas" mostrando la misma información de antes:

select nombre, nota, f_condicion(nota) from notas;

-- Ejercicio 1 



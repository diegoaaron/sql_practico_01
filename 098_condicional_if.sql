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

 drop table productos;

 create table productos(
  codigo number(5),
  precio number(6,2),
  stockminimo number(4),
  stockactual number(4)
 );

 insert into productos values(100,10,100,200);
 insert into productos values(102,15,200,500);
 insert into productos values(130,8,100,0);
 insert into productos values(240,23,100,20);
 insert into productos values(356,12,100,250);
 insert into productos values(360,7,100,100);
 insert into productos values(400,18,150,100);
 
 -- Cree una función que reciba dos valores numéricos correspondientes a ambos stosks. Debe comparar ambos 
 -- stocks y retornar una cadena de caracteres indicando el estado de cada producto, si stock actual es:
 -- cero: "faltante",
 -- menor al stock mínimo: "reponer",
 -- igual o superior al stock mínimo: "normal".


-- Realice un "select" mostrando el código del producto, ambos stocks y, empleando la función creada anteriormente, una 
-- columna que muestre el estado del producto


-- Realice la misma función que en el punto 4, pero esta vez empleando en la estructura condicional la sintaxis "if... elsif...end if"


-- Realice un "select" mostrando el código del producto, ambos stocks y, empleando la función creada anteriormente, una 
-- columna que muestre el estado del producto


-- Realice una función similar a las anteriores, pero esta vez, si el estado es "reponer" o "faltante", debe especificar la 
-- cantidad necesaria (valor necesario para llegar al stock mínimo)


-- Realice un "select" mostrando el código del producto, ambos stocks y, empleando la función creada anteriormente, una 
-- columna que muestre el estado del producto



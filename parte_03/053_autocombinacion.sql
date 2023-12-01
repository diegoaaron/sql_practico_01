/*
Dijimos que es posible combinar una tabla consigo misma.
Un pequeño restaurante tiene almacenadas sus comidas en una tabla llamada "comidas" que consta de los siguientes campos:

- nombre varchar(20) 
- precio decimal (4,2) 
- rubro char(6)  que indica con 'plato' si es un plato principal y 'postre' si es postre.

Podemos obtener la combinación de todos los platos empleando un "cross join" con una sola tabla:

select c1.nombre,
c2.nombre,
c1.precio + c2.precio as total
from comidas c1
cross join comidas c2;

En la consulta anterior aparecerán filas duplicadas, para evitarlo debemos emplear un "where":

select c1.nombre as "plato principal",
c2.nombre as postre,
c1.precio+c2.precio as total
from comidas c1
cross join comidas c2
where c1.rubro='plato' and
c2.rubro='postre';

En la consulta anterior se empleó un "where" que especifica que se combine "plato" con "postre".

En una autocombinación se combina una tabla con una copia de si misma. Para ello debemos utilizar 2 alias para la tabla. 
Para evitar que aparezcan filas duplicadas, debemos emplear un "where".

También se puede realizar una autocombinación con "join":

select c1.nombre as "plato principal",
c2.nombre as postre,
c1.precio + c2.precio as total
from comidas c1
join comidas c2
on c1.codigo<>c2.codigo
where c1.rubro='plato' and
c2.rubro='postre';

Para que no aparezcan filas duplicadas se agrega un "where".
*/

drop table comidas;

create table comidas(
codigo number(2),
nombre varchar2(30),
precio number(4,2),
rubro char(6),-- 'plato'=plato principal', 'postre'=postre
primary key(codigo)
);

insert into comidas values(1,'ravioles',5,'plato');
insert into comidas values(2,'tallarines',4,'plato');
insert into comidas values(3,'milanesa',7,'plato');
insert into comidas values(4,'cuarto de pollo',6,'plato');
insert into comidas values(5,'flan',2.5,'postre');
insert into comidas values(6,'porcion torta',3.5,'postre');

-- Realizamos un "cross join":

select c1.nombre,
c2.nombre,
c1.precio + c2.precio as total
from comidas c1
cross join comidas c2;

-- Note que aparecen filas duplicadas, por ejemplo, "ravioles" se combina con "ravioles" y la combinación "ravioles- flan" 
-- se repite como "flan- ravioles". Debemos especificar que combine el rubro "plato" con "postre":

select c1.nombre as "plato principal",
c2.nombre as postre,
c1.precio + c2.precio as total
from comidas c1
cross join comidas c2
where c1.rubro = 'plato' and
c2.rubro = 'postre';

-- La salida muestra cada plato combinado con cada postre, y una columna extra que calcula el total del menú.

-- También se puede realizar una autocombinación con "join":

select c1.nombre as "plato principal",
c2.nombre as postre,
c1.precio + c2.precio total
from comidas c1
join comidas c2
on c1.codigo <> c2.codigo
where c1.rubro='plato' and
c2.rubro='postre';

-- Para que no aparezcan filas duplicadas se agrega un "where".

-- Ejercicio 1

 drop table clientes;

 create table clientes(
  nombre varchar2(30),
  sexo char(1),--'f'=femenino, 'm'=masculino
  edad number(2),
  domicilio varchar2(30)
 );

 insert into clientes values('Maria Lopez','f',45,'Colon 123');
 insert into clientes values('Liliana Garcia','f',35,'Sucre 456');
 insert into clientes values('Susana Lopez','f',41,'Avellaneda 98');
 insert into clientes values('Juan Torres','m',44,'Sarmiento 755');
 insert into clientes values('Marcelo Oliva','m',56,'San Martin 874');
 insert into clientes values('Federico Pereyra','m',38,'Colon 234');
 insert into clientes values('Juan Garcia','m',50,'Peru 333');

-- La agencia necesita la combinación de todas las personas de sexo femenino con las de sexo masculino. Use un 
-- "cross join" (12 filas)

select c1.nombre, c2.nombre
from clientes c1
cross join clientes c2
where c1.sexo ='f' and c2.sexo='m';

-- Obtenga la misma salida anterior pero realizando un "join"

select c1.nombre, c2.nombre
from clientes c1
join clientes c2
on c1.nombre <> c2.nombre
where c1.sexo ='f' and c2.sexo='m';

-- Realice la misma autocombinación que el punto 3 pero agregue la condición que las parejas no tengan una diferencia 
-- superior a 5 años (5 filas)

select c1.nombre, c2.nombre
from clientes c1
cross join clientes c2
where c1.sexo ='f' and c2.sexo='m' and (c1.edad - c2.edad between -5 and 5);

-- Ejercicio 2

 drop table equipos;

 create table equipos(
  nombre varchar2(30),
  barrio varchar2(20),
  domicilio varchar2(30),
  entrenador varchar2(30)
 );

 insert into equipos values('Los tigres','Gral. Paz','Sarmiento 234','Juan Lopez');
 insert into equipos values('Los leones','Centro','Colon 123','Gustavo Fuentes');
 insert into equipos values('Campeones','Pueyrredon','Guemes 346','Carlos Moreno');
 insert into equipos values('Cebollitas','Alberdi','Colon 1234','Luis Duarte');
  insert into equipos values('Campeonas','AAlberdi','CColon 11234','LLuis Duarte');
 
 -- Cada equipo jugará con todos los demás 2 veces, una vez en cada sede. Realice un "cross join" para combinar los 
 -- equipos teniendo en cuenta que un equipo no juega consigo mismo (12 filas)

select e1.nombre, e2.nombre
from equipos e1
cross join equipos e2
where e1.nombre <> e2.nombre;

-- Obtenga el mismo resultado empleando un "join".

select e1.nombre, e2.nombre
from equipos e1
join equipos e2
on e1.nombre <> e2.nombre;

-- Realice un "cross join" para combinar los equipos para que cada equipo juegue con cada uno de los otros una sola vez (6 filas)

select e1.nombre, e2.nombre
from equipos e1
cross join equipos e2
where e1.nombre > e2.nombre;
 
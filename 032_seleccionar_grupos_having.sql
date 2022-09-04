-- Así como la cláusula "where" permite seleccionar (o rechazar) registros individuales; la cláusula "having" 
-- permite seleccionar (o rechazar) un grupo de registros.

-- Se utiliza "having", seguido de la condición de búsqueda, para seleccionar ciertas filas retornadas por la cláusula "group by".

-- En algunos casos es posible confundir las cláusulas "where" y "having". 
-- Queremos contar los registros agrupados por editorial sin tener en cuenta a la editorial "Planeta".

select editorial, count(*) from libros  where editorial<>'Planeta' group by editorial;

select editorial, count(*) from libros group by editorial having editorial<>'Planeta';

-- Ambas devuelven el mismo resultado, pero son diferentes. La primera, selecciona todos los registros rechazando los 
-- de editorial "Planeta" y luego los agrupa para contarlos. La segunda, selecciona todos los registros, los agrupa para 
-- contarlos y finalmente rechaza fila con la cuenta correspondiente a la editorial "Planeta".

select editorial, count(*) from libros where precio is not null group by editorial having editorial<>'Planeta';

-- Aquí, selecciona los registros rechazando los que no cumplan con la condición dada en "where", luego los agrupa 
-- por "editorial" y finalmente rechaza los grupos que no cumplan con la condición dada en el "having".

-- En una cláusula "having" puede haber varias condiciones. Cuando utilice varias condiciones, tiene que combinarlas 
-- con operadores lógicos (and, or, not).

-- Podemos encontrar el mayor valor de los libros agrupados y ordenados por editorial y seleccionar las filas que tengan un 
-- valor menor a 100 y mayor a 30:

 select editorial, max(precio) as mayor from libros group by editorial having max(precio)<100 
 and max(precio)>30 order by editorial; 

 
drop table libros;

create table libros(
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar2(15),
  precio number(5,2),
  cantidad number(3)
);

insert into libros values('El aleph','Borges','Planeta',35,null);
insert into libros values('Martin Fierro','Jose Hernandez','Emece',22.20,200);
insert into libros values('Martin Fierro','Jose Hernandez','Planeta',40,200);
insert into libros values('Antologia poetica','J.L. Borges','Planeta',null,150);
insert into libros values('Aprenda PHP','Mario Molina','Emece',18,null);
insert into libros values('Manual de PHP', 'J.C. Paez', 'Siglo XXI',56,120);
insert into libros values('Cervantes y el quijote','Bioy Casares- J.L. Borges','Paidos',null,100);
insert into libros values('Harry Potter y la piedra filosofal','J.K. Rowling',default,45.00,90);
insert into libros values('Harry Potter y la camara secreta','J.K. Rowling','Emece',null,100);
insert into libros values('Alicia en el pais de las maravillas','Lewis Carroll','Paidos',42,80);
insert into libros values('PHP de la A a la Z',null,null,110,0);
insert into libros values('Uno','Richard Bach','Planeta',25,null);

-- Queremos saber la cantidad de libros agrupados por editorial:

select editorial, count(*) from libros group by editorial;

-- Queremos saber la cantidad de libros agrupados por editorial pero considerando sólo algunos grupos, 
-- por ejemplo, los que devuelvan un valor mayor a 2

select editorial, count(*) from libros group by editorial having count(*) > 2;

-- Queremos el promedio de los precios de los libros agrupados por editorial, pero solamente de aquellos grupos 
-- cuyo promedio supere los 25 pesos:

select editorial, avg(precio) from libros group by editorial having avg(precio) > 25;

-- Queremos la cantidad de libros, sin considerar los que tienen precio no nulo (where), agrupados por editorial (group by), 
-- sin considerar la editorial "Planeta".

select editorial, count(*) from libros where precio is not null group by editorial having editorial <> 'Planeta';

-- Necesitamos el promedio de los precios agrupados por editorial, de aquellas editoriales que tienen más de 2 libros:

select editorial, avg(precio) from libros group by editorial having count(*) > 2;

-- Buscamos el mayor valor de los libros agrupados y ordenados por editorial y seleccionamos las filas que tienen un valor 
-- menor a 100 y mayor a 30:

select editorial, max(precio) from libros group by editorial having max(precio) < 100 and max(precio) > 30 
order by editorial;

-- Ejercicios 1

drop table clientes;

create table clientes (
  nombre varchar2(30) not null,
  domicilio varchar2(30),
  ciudad varchar2(20),
  provincia varchar2(20),
  telefono varchar2(11)
);

insert into clientes values ('Lopez Marcos','Colon 111','Cordoba','Cordoba','null');
insert into clientes values ('Perez Ana','San Martin 222','Cruz del Eje','Cordoba','4578585');
insert into clientes values ('Garcia Juan','Rivadavia 333','Villa del Rosario','Cordoba','4578445');
insert into clientes values ('Perez Luis','Sarmiento 444','Rosario','Santa Fe',null);
insert into clientes values ('Pereyra Lucas','San Martin 555','Cruz del Eje','Cordoba','4253685');
insert into clientes values ('Gomez Ines','San Martin 666','Santa Fe','Santa Fe','0345252525');
insert into clientes values ('Torres Fabiola','Alem 777','Villa del Rosario','Cordoba','4554455');
insert into clientes values ('Lopez Carlos',null,'Cruz del Eje','Cordoba',null);
insert into clientes values ('Ramos Betina','San Martin 999','Cordoba','Cordoba','4223366');
insert into clientes values ('Lopez Lucas','San Martin 1010','Posadas','Misiones','0457858745');

-- Obtenga el total de los registros agrupados por ciudad y provincia

select provincia, ciudad, count(*) from clientes group by provincia, ciudad;

-- Obtenga el total de los registros agrupados por ciudad y provincia sin considerar los que tienen menos de 2 clientes

select provincia, ciudad, count(*) from clientes group by provincia, ciudad having count(*) >= 2; 

-- Obtenga el total de los clientes que viven en calle "San Martin" (where), agrupados por provincia (group by), de aquellas 
-- ciudades que tengan menos de 2 clientes (having) y omitiendo la fila correspondiente a la ciudad de "Cordoba" (having)

select ciudad, count(ciudad) from clientes  where domicilio like '%San Martin%'  group by  ciudad 
having count(*) < 2 and ciudad <> 'Cordoba'; 

-- Ejercicio 2

drop table visitantes;

create table visitantes(
  nombre varchar2(30),
  edad number(2),
  sexo char(1),
  domicilio varchar2(30),
  ciudad varchar2(20),
  telefono varchar2(11),
  montocompra number(6,2) not null
);

insert into visitantes values ('Susana Molina',28,'f',null,'Cordoba',null,45.50); 
insert into visitantes values ('Marcela Mercado',36,'f','Avellaneda 345','Cordoba','4545454',22.40);
insert into visitantes values ('Alberto Garcia',35,'m','Gral. Paz 123','Alta Gracia','03547123456',25); 
insert into visitantes values ('Teresa Garcia',33,'f',default,'Alta Gracia','03547123456',120);
insert into visitantes values ('Roberto Perez',45,'m','Urquiza 335','Cordoba','4123456',33.20);
insert into visitantes values ('Marina Torres',22,'f','Colon 222','Villa Dolores','03544112233',95);
insert into visitantes values ('Julieta Gomez',24,'f','San Martin 333','Alta Gracia',null,53.50);
insert into visitantes values ('Roxana Lopez',20,'f','null','Alta Gracia',null,240);
insert into visitantes values ('Liliana Garcia',50,'f','Paso 999','Cordoba','4588778',48);
insert into visitantes values ('Juan Torres',43,'m','Sarmiento 876','Cordoba',null,15.30);

-- Obtenga el total de las compras agrupados por ciudad y sexo de aquellas filas que devuelvan un valor superior a 50

select ciudad, sexo, sum(montocompra) from visitantes group by ciudad, sexo having sum(montocompra)  > 50;

-- Obtenga el total de las compras agrupados por ciudad y sexo (group by), considerando sólo los montos de compra 
-- superiores a 50 (where), los visitantes con teléfono (where), sin considerar la ciudad de "Cordoba" (having), 
-- ordenados por ciudad (order by) (2 filas) 

select ciudad, sexo, sum(montocompra) from visitantes where montocompra > 0 and telefono is not null 
group by ciudad, sexo having ciudad <> 'Cordoba' order by ciudad;

-- Muestre el monto mayor de compra agrupado por ciudad, siempre que dicho valor supere los 50 pesos (having), 
-- considerando sólo los visitantes de sexo femenino y domicilio conocido (where)

select ciudad, max(montocompra) from visitantes where sexo = 'f' and domicilio is not null group by ciudad 
having max(montocompra) > 50;

-- Agrupe por ciudad y sexo, muestre para cada grupo el total de visitantes, la suma de sus compras y el promedio de compras, 
-- ordenado por la suma total y considerando las filas con promedio superior a 30 

select ciudad, sexo, count(*), sum(montocompra), avg(montocompra) from visitantes group by ciudad, sexo
having avg(montocompra) > 30 order by sum(montocompra);




-- Con la cláusula "distinct" se especifica que los registros con ciertos datos duplicados sean obviadas en el resultado

-- La cláusula "distinct" afecta a todos los campos presentados. Para mostrar los títulos y editoriales 
-- de los libros sin repetir títulos ni editoriales, usamos:

 select distinct titulo,editorial from libros order by titulo;
 
drop table libros;

create table libros(
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar2(15)
);

insert into libros values('El aleph','Borges','Planeta');
insert into libros values('Martin Fierro','Jose Hernandez','Emece');
insert into libros values('Martin Fierro','Jose Hernandez','Planeta');
insert into libros values('Antologia poetica','Borges','Planeta');
insert into libros values('Aprenda PHP','Mario Molina','Emece');
insert into libros values('Aprenda PHP','Lopez','Emece');
insert into libros values('Manual de PHP', 'J. Paez', null);
insert into libros values('Cervantes y el quijote',null,'Paidos');
insert into libros values('Harry Potter y la piedra filosofal','J.K. Rowling','Emece');
insert into libros values('Harry Potter y la camara secreta','J.K. Rowling','Emece');
insert into libros values('Alicia en el pais de las maravillas','Lewis Carroll','Paidos');
insert into libros values('Alicia en el pais de las maravillas','Lewis Carroll','Planeta');
insert into libros values('PHP de la A a la Z',null,null);
insert into libros values('Uno','Richard Bach','Planeta');

-- Para obtener la lista de autores sin repetición

select distinct autor from libros;

-- Note que aparece "null" como un valor para "autor", para que no aparezca: 

select distinct autor from libros where autor is not null;

-- Contar los autores diferentes

select count(distinct autor) from libros;

-- La combinamos con "where" para obtener los distintos autores de la editorial "Planeta":

select distinct autor from libros where editorial <> 'Planeta';

-- Contamos los distintos autores que tiene cada editorial empleando "group by":

 select editorial, count(distinct autor) from libros group by editorial;
 
 -- Mostramos los títulos y editoriales de los libros sin repetir títulos ni editoriales:

select distinct titulo, editorial from libros order by titulo;

-- Note que los registros no están duplicados, aparecen títulos iguales pero con editorial diferente, cada registro es diferente.

-- Ejercicio 1

drop table clientes;

create table clientes (
  nombre varchar2(30) not null,
  domicilio varchar2(30),
  ciudad varchar2(20),
  provincia varchar2(20)
);
 
insert into clientes values ('Lopez Marcos','Colon 111','Cordoba','Cordoba');
insert into clientes values ('Perez Ana','San Martin 222','Cruz del Eje','Cordoba');
insert into clientes values ('Garcia Juan','Rivadavia 333','Villa del Rosario','Cordoba');
insert into clientes values ('Perez Luis','Sarmiento 444','Rosario','Santa Fe');
insert into clientes values ('Pereyra Lucas','San Martin 555','Cruz del Eje','Cordoba');
insert into clientes values ('Gomez Ines','San Martin 666','Santa Fe','Santa Fe');
insert into clientes values ('Torres Fabiola','Alem 777','Villa del Rosario','Cordoba');
insert into clientes values ('Lopez Carlos',null,'Cruz del Eje','Cordoba');
insert into clientes values ('Ramos Betina','San Martin 999','Cordoba','Cordoba');
insert into clientes values ('Lopez Lucas','San Martin 1010','Posadas','Misiones'); 
 
-- Obtenga las provincias sin repetir 

select distinct provincia from clientes;

-- Cuente las distintas provincias

select count(distinct provincia) from clientes;

-- Se necesitan los nombres de las ciudades sin repetir 

select distinct ciudad from clientes;

-- Obtenga la cantidad de ciudades distintas 

select count(distinct ciudad) from clientes;

-- Combine con "where" para obtener las distintas ciudades de la provincia de Cordoba 

select distinct ciudad from clientes where provincia = 'Cordoba';

-- Contamos las distintas ciudades de cada provincia empleando "group by" 

select provincia, count(distinct ciudad) from clientes group by provincia;

-- Ejercicio 2 

drop table inmuebles;

create table inmuebles (
  documento varchar2(8) not null,
  apellido varchar2(30),
  nombre varchar2(30),
  domicilio varchar2(20),
  barrio varchar2(20),
  ciudad varchar2(20),
  tipo char(1),--b=baldio, e: edificado
  superficie number(8,2)
);
 
insert into inmuebles values ('11000000','Perez','Alberto','San Martin 800','Centro','Cordoba','e',100);
insert into inmuebles values ('11000000','Perez','Alberto','Sarmiento 245','Gral. Paz','Cordoba','e',200);
insert into inmuebles values ('12222222','Lopez','Maria','San Martin 202','Centro','Cordoba','e',250);
insert into inmuebles values ('13333333','Garcia','Carlos','Paso 1234','Alberdi','Cordoba','b',200);
insert into inmuebles values ('13333333','Garcia','Carlos','Guemes 876','Alberdi','Cordoba','b',300);
insert into inmuebles values ('14444444','Perez','Mariana','Caseros 456','Flores','Cordoba','b',200);
insert into inmuebles values ('15555555','Lopez','Luis','San Martin 321','Centro','Carlos Paz','e',500);
insert into inmuebles values ('15555555','Lopez','Luis','Lopez y Planes 853','Flores','Carlos Paz','e',350);
insert into inmuebles values ('16666666','Perez','Alberto','Sucre 1877','Flores','Cordoba','e',150);

-- Muestre los distintos apellidos de los propietarios, sin repetir 

select distinct apellido from inmuebles;

-- Recupere los distintos documentos de los propietarios y luego muestre los distintos documentos 
-- de los propietarios, sin repetir y vea la diferencia

select documento from inmuebles;

select distinct documento from inmuebles;

-- Cuente, sin repetir, la cantidad de propietarios de inmuebles de la ciudad de Cordoba 

select count(distinct documento) from inmuebles where ciudad = 'Cordoba';

-- Cuente la cantidad de inmuebles con domicilio en 'San Martin' 

select count(ciudad) from inmuebles where domicilio like '%San Martin%';

-- Cuente la cantidad de inmuebles con domicilio en 'San Martin', sin repetir la ciudad. Compare con la sentencia anterior.

select count(distinct ciudad) from inmuebles where domicilio like '%San Martin%';

-- Muestre los apellidos y nombres de todos los registros

select nombre, apellido from inmuebles;

-- Muestre los apellidos y nombres, sin repetir 

select distinct nombre, apellido from inmuebles;

-- Muestre la cantidad de inmuebles que tiene cada propietario en barrios conocidos, agrupando por documento 

select documento, count(barrio) from inmuebles group by documento;

-- Realice la misma consulta anterior pero en esta oportunidad, sin repetir barrio 
-- Compare los valores con los obtenidos en el punto 11.

select documento, count(distinct barrio) from inmuebles group by documento;


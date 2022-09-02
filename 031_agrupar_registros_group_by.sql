-- Podemos generar valores de resumen para un solo campo, combinando las funciones de agregado
-- con la cláusula "group by", que agrupa registros para consultas detalladas.

drop table libros;

create table libros(
  codigo number(5),
  titulo varchar2(40),
  autor varchar2(30) default 'Desconocido',
  editorial varchar2(15),
  precio number(5,2),
  cantidad number(3),
  primary key(codigo)
);

insert into libros values(100,'El aleph','Borges','Planeta',15,null);
insert into libros values(234,'Martin Fierro','Jose Hernandez','Emece',22.20,200);
insert into libros values(354,'Antologia poetica',default,'Planeta',null,150);
insert into libros values(478,'Aprenda PHP','Mario Molina','Emece',18.20,null);
insert into libros values(512,'Cervantes y el quijote','Bioy Casares- J.L. Borges','Paidos',28,100);
insert into libros values(643,'Manual de PHP', default, 'Siglo XXI',31.80,120);
insert into libros values(646,'Harry Potter y la piedra filosofal','J.K. Rowling',default,45.00,90);
insert into libros values(753,'Harry Potter y la camara secreta','J.K. Rowling','Emece',null,100);
insert into libros values(889,'Alicia en el pais de las maravillas','Lewis Carroll','Paidos',22.50,200);
insert into libros values(893,'PHP de la A a la Z',null,null,55.90,0);

-- queremos saber la cantidad de libros de cada editorial

select editorial, count(*) from libros group by editorial;

-- obtenemos la cantidad libros con precio no nulo de cada editorial

select editorial, count(precio) from libros group by editorial;

-- para conocer el total de libros agrupados por editorial

select editorial, sum(cantidad) from libros group by editorial;

-- obtenemos el máximo y mínimo valor de los libros agrupados por editorial, en una sola sentencia

select editorial, max(precio) as mayor, min(precio) as menor from libros group by editorial;

-- calculamos el promedio del valor de los libros agrupados por editorial

select editorial, avg(precio) from libros group by editorial;

-- contar y agrupar por editorial considerando solamente los libros cuyo precio es menor a 30

select editorial, count(*) from libros where precio > 30 group by editorial;

-- Ejercicio 1

drop table visitantes;

create table visitantes(
  nombre varchar2(30),
  edad number(2),
  sexo char(1) default 'f',
  domicilio varchar2(30),
  ciudad varchar2(20) default 'Cordoba',
  telefono varchar2(11),
  mail varchar2(30) default 'no tiene',
  montocompra number(6,2)
);

insert into visitantes values ('Susana Molina',35,default,'Colon 123',default,null,null,59.80);
insert into visitantes values ('Marcos Torres',29,'m',default,'Carlos Paz',default,'marcostorres@hotmail.com',150.50);
insert into visitantes values ('Mariana Juarez',45,default,default,'Carlos Paz',null,default,23.90);
insert into visitantes (nombre, edad,sexo,telefono, mail) values ('Fabian Perez',36,'m','4556677','fabianperez@xaxamail.com');
insert into visitantes (nombre, ciudad, montocompra) values ('Alejandra Gonzalez','La Falda',280.50);
insert into visitantes (nombre, edad,sexo, ciudad, mail,montocompra) values ('Gaston Perez',29,'m','Carlos Paz','gastonperez1@gmail.com',95.40);
insert into visitantes values ('Liliana Torres',40,default,'Sarmiento 876',default,default,default,85);
insert into visitantes values ('Gabriela Duarte',21,null,null,'Rio Tercero',default,'gabrielaltorres@hotmail.com',321.50);

-- Queremos saber la cantidad de visitantes de cada ciudad

select ciudad, count(*) from visitantes group by ciudad;

-- Queremos la cantidad visitantes con teléfono no nulo, de cada ciudad

select ciudad, count(telefono) from visitantes group by ciudad;

-- Necesitamos el total del monto de las compras agrupadas por sexo

select sexo, sum(montocompra) from visitantes group by sexo;

-- Se necesita saber el máximo y mínimo valor de compra agrupados por sexo y ciudad

select sexo, ciudad, max(montocompra) as "mayor" , min(montocompra) as "menor" from visitantes group by sexo, ciudad;

-- Calcule el promedio del valor de compra agrupados por ciudad

select ciudad, avg(montocompra) from visitantes group by ciudad;

-- Cuente y agrupe por ciudad sin tener en cuenta los visitantes que no tienen mail

select ciudad, count(*) from visitantes where mail is not null and mail <> 'no tiene'  group by ciudad;

commit;

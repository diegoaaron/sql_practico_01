/*
Los operadores aritméticos permiten realizar cálculos con valores numéricos.

Son: multiplicación (*), división (/), suma (+) y resta (-).

Es posible obtener salidas en las cuales una columna sea el resultado de un cálculo y no un campo de una tabla.

*/

insert into libros (titulo, precio, cantidad) values('el librito',22.3,5);

select titulo,precio,cantidad from libros;
 
select titulo,precio,cantidad, precio*cantidad as total from libros;

select titulo,precio,  precio - (precio*0.1) as descuento from libros;

-- tambien se puede actualizar los datos utilizando operadores aritmeticos

update libros set precio = precio - (precio * 0.1);

-- el operador || permite concatenar campos

select titulo || ' - ' || autor from libros;

select titulo || ' $ ' || precio from libros;

-- Ejercicio 1 

drop table articulos;

create table articulos(
  codigo number(4),
  nombre varchar2(20),
  descripcion varchar2(30),
  precio number(8,2),
  cantidad number(3) default 0,
  primary key (codigo)
);

insert into articulos values (101,'impresora','Epson Stylus C45',400.80,20);
insert into articulos values (203,'impresora','Epson Stylus C85',500,30);
insert into articulos values (205,'monitor','Samsung 14',800,10);
insert into articulos values (300,'teclado','ingles Biswal',100,50);

update articulos set precio = precio + (0.15*precio);

select nombre || ',' || descripcion from articulos;

update articulos set cantidad = cantidad - 5 where nombre = 'impresora';

select 'Cod.' || codigo || ' ' || descripcion || '$ ' || precio || '(' || cantidad || ')' from articulos;

select * from articulos;
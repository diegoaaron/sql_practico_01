-- cambioando la cabecera de una conlumna con 'as'

select titulo, cantidad as stock, precio from libros;

select titulo, cantidad as "stock disponible", precio from libros;

select titulo, precio, precio * 0.1 as descuento, precio - (precio * 0.1) as "precio final" from libros;

-- Ejercicio 1

drop table articulos;

create table articulos(
    codigo number(4),
    nombre varchar2(20),
    descripcion varchar2(30),
    precio number(8,2),
    cantidad number(3) default 0,
    primary key(codigo)
);

insert into articulos values (101,'impresora','Epson Stylus C45',400.80,20);
insert into articulos values (203,'impresora','Epson Stylus C85',500,30);
insert into articulos values (205,'monitor','Samsung 14',800,10);
insert into articulos values (300,'teclado','ingles Biswal',100,50);

select codigo, nombre, descripcion, precio - (precio*0.15) as "precio mayorista" from articulos;

select nombre | |' ' || descripcion articulo, precio from articulos;

select codigo, nombre, descripcion, precio * cantidad as "monto total" from articulos;

select descripcion, precio * 1.2 as "precio con aumento" from articulos;

 
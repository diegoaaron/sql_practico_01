-- 'DELETE' permite borrar los registros de una tabla (pero no la tabla en si). 

delete from usuarios;

delete from usuarios where nombre = 'Marcelo';

delete from usuarios where clave = 'Boca';

delete from usuarios;

commit;

select * from usuarios;

-- Ejercicio 1

drop table agenda; 

create table agenda(
    apellido varchar2(30),
    nombre varchar2(20),
    domicilio varchar2(30),
    telefono varchar2(11)
);

insert into agenda (apellido, nombre, domicilio, telefono) values ('Alvarez','Alberto','Colon 123','4234567');
insert into agenda (apellido, nombre, domicilio, telefono) values ('Juarez','Juan','Avellaneda 135','4458787');
insert into agenda (apellido, nombre, domicilio, telefono) values ('Lopez','Maria','Urquiza 333','4545454');
insert into agenda (apellido, nombre, domicilio, telefono) values ('Lopez','Jose','Urquiza 333','4545454');
insert into agenda (apellido, nombre, domicilio, telefono) values ('Salas','Susana','Gral. Paz 1234','4123456');

delete from agenda where nombre = 'Juan';

delete from agenda where telefono = '4545454';

delete from agenda;

commit;

-- Ejercicio 2

drop table articulos;

create table articulos(
    codigo number(4,0),
    nombre varchar2(20),
    descripcion varchar2(30),
    precio number(7,2),
    cantidad number(3)
);

describe articulos;

insert into articulos (codigo, nombre, descripcion, precio, cantidad) values (1,'impresora','Epson Stylus C45',400.80,20);
insert into articulos (codigo, nombre, descripcion, precio, cantidad) values (2,'impresora','Epson Stylus C85',500,30);
insert into articulos (codigo, nombre, descripcion, precio, cantidad) values (3,'monitor','Samsung 14',800,10);
insert into articulos (codigo, nombre, descripcion, precio, cantidad) values (4,'teclado','ingles Biswal',100,50);
insert into articulos (codigo, nombre, descripcion, precio, cantidad) values (5,'teclado','español Biswal',90,50);

commit;

delete from articulos where precio >= 500;

delete from articulos where codigo <> 1;

delete from articulos;

select * from articulos;

commit;



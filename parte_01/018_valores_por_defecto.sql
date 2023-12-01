-- Un valor por defecto o predeterminado se ingresa cuando no se definida nada para un campo.

/*

Un valor por defecto se inserta cuando no está presente al ingresar un registro.

Para campos de cualquier tipo no declarados "not null", es decir, que admiten valores nulos, el valor por defecto es "null". 
Para campos declarados "not null", no existe valor por defecto, a menos que se declare explícitamente con la cláusula "default".

*/

-- Podemos ver los valores por defecto de un tabla a través de la siguiente query.

select column_name,nullable,data_default   from user_tab_columns where TABLE_NAME = 'LIBROS';
  
-- Muestra una fila por cada campo, en la columna "data_default" aparece el valor por defecto (si lo tiene), 
-- en la columna "nullable" aparece "N" si el campo no está definido "not null" y "Y" si admite valores "null".


drop table libros;

create table libros(
    titulo varchar2(40) not null,
    autor varchar2(30) default 'Desconocido' not null,
    editorial varchar2(20),
    precio number(5,2),
    cantidad number(3) default 0
);

insert into libros (titulo,editorial,precio) values('mi libro', 'el librero', 22.5);
  
-- se puede ingresar valores por defecto indicando la palabra 'default'
insert into libros (titulo,autor,editorial,precio,cantidad)   values ('El gato con botas',default,default,default,default);

-- se puede ingresar valores nulos en vez de los valores por defecto utilizando la palabra reservada 'null'
insert into libros (titulo,autor,cantidad)   values ('El gato con botas','Lewis Carroll',null);
  
select * from libros;  

commit;

-- Ejercicio 1

drop table visitantes;

create table visitantes(
    nombre varchar2(30),
    edad number(2),
    sexo char(1) default 'f',
    domicilio varchar2(30),
    ciudad varchar2(20) default 'Cordova',
    telefono varchar(11),
    mail varchar(30) default 'no tiene',
    montocompra number(6,2)
);

select column_name, nullable, data_default from user_tab_columns where table_name = 'VISITANTES';

insert into visitantes (domicilio,ciudad,telefono,mail,montocompra)
  values ('Colon 123','Cordoba','4334455','juanlopez@hotmail.com',59.80);

insert into visitantes (nombre,edad,sexo,telefono,mail,montocompra)
  values ('Marcos Torres',29,'m','4112233','marcostorres@hotmail.com',60);

insert into visitantes (nombre,edad,sexo,domicilio,ciudad)
  values ('Susana Molina',43,'f','Bulnes 345','Carlos Paz');

insert into visitantes (nombre, edad, sexo, domicilio, ciudad, telefono, mail, montocompra)
    values('luis',22,default,'las palmeras',default,'2223333',default,12);

select * from visitantes;

commit;

-- Ejercicio 2

drop table prestamos;

create table prestamos(
  titulo varchar2(40) not null,
  documento char(8) not null,
  fechaprestamo date not null,
  fechadevolucion date,
  devuelto char(1) default 'n'
);
 
select column_name, nullable, data_default from user_tab_columns where table_name = 'PRESTAMOS';

insert into prestamos(titulo, documento, fechaprestamo, fechadevolucion) 
    values('mi libro', 'aaaabbbb',TO_DATE('01/03/2022', 'dd/mm/yyyy'),TO_DATE('01/03/2022', 'dd/mm/yyyy'));

insert into prestamos(titulo, documento, fechaprestamo, fechadevolucion) 
    values('segundo libro', 'ccccbbbb',TO_DATE('01/11/2022', 'dd/mm/yyyy'),TO_DATE('01/03/2023', 'dd/mm/yyyy'));

insert into prestamos(titulo, documento, fechaprestamo, fechadevolucion,devuelto) 
    values('segundo libro', 'ccccbbbb',TO_DATE('01/11/2022', 'dd/mm/yyyy'),TO_DATE('01/03/2023', 'dd/mm/yyyy'),default);

-- error, por intentar ingresar un valor por defecto a un campo que no acepta nulos y no tiene un valor por defecto, definido. 
insert into prestamos(titulo, documento, fechaprestamo, fechadevolucion,devuelto) 
    values('segundo libro', default',TO_DATE('01/11/2022', 'dd/mm/yyyy'),TO_DATE('01/03/2023', 'dd/mm/yyyy'),default);


select * from prestamos;

commit;
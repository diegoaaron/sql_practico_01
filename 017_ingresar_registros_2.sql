/*

Al ingresar registros debemos tener en cuenta:

La lista de campos debe coincidir en cantidad y tipo de valores con la lista de valores luego de "values". 
Si se listan más (o menos) campos que los valores ingresados, aparece un mensaje de error y la sentencia no se ejecuta.

Si ingresamos valores para todos los campos podemos obviar la lista de campos.

insert into libros values ('Uno','Richard Bach','Planeta');

Podemos omitir valores para los campos que permitan valores nulos (se guardará "null"); 
si omitimos el valor para un campo "not null", la sentencia no se ejecuta.

insert into libros (titulo, autor) values ('El aleph','Borges'); 
 
Oracle almacenará el valor "null" en el campo "editorial", para el cual no hemos explicitado un valor.

*/

drop table libros;

create table libros(
    codigo number(5) not null,
    titulo varchar2(40) not null,
    autor varchar2(30),
    editorial varchar2(15)
);

insert into libros values (1,'Uno','Richard Bach','Planeta');

insert into libros (codigo, titulo, autor)  values (2,'El aleph','Borges');

-- error, no se puede omitir un campo definido como "not null"
insert into libros (titulo, editorial, autor) values ('Alicia en el pais de las maravillas','Lewis Carroll','Planeta');

select * from libros;

-- Ejercicio 1 

drop table cuentas;

create table cuentas(
    numero number(10) not null,
    documento char(8) not null,
    nombre varchar2(30),
    saldo number(9,2)
);

insert into cuentas values (1234567890, '41450207', 'luis', 222.22);

insert into cuentas (numero, documento)  values (1234567890, '41450207');

-- error, mas valores que los campos definidos
insert into cuentas (numero, documento, nombre)  values (1234567890, '41450207', 'luis', 222.22);

-- error, mas campos que valores definidos
insert into cuentas (numero, documento, nombre)  values (1234567890, '41450207');

-- error, no se ingreso un campo definido como "not null"
insert into cuentas values ('41450207', 'luis', 222.22);

select * from cuentas;

commit;
-- Un valor por defecto o predeterminado se ingresa cuando no se definida nada para un campo.

/*

Un valor por defecto se inserta cuando no est� presente al ingresar un registro.

Para campos de cualquier tipo no declarados "not null", es decir, que admiten valores nulos, el valor por defecto es "null". 
Para campos declarados "not null", no existe valor por defecto, a menos que se declare expl�citamente con la cl�usula "default".

*/

-- Podemos ver los valores por defecto de un tabla a trav�s de la siguiente query.

select column_name,nullable,data_default   from user_tab_columns where TABLE_NAME = 'LIBROS';
  
-- Muestra una fila por cada campo, en la columna "data_default" aparece el valor por defecto (si lo tiene), 
-- en la columna "nullable" aparece "N" si el campo no est� definido "not null" y "Y" si admite valores "null".


drop table libros;

create table libros(
    titulo varchar2(40) not null,
    autor varchar2(30) default 'Desconocido' not null,
    editorial varchar2(20),
    precio number(5,2),
    cantidad number(3) default 0
);

insert into libros (titulo,editorial,precio) values('mi libro', 'el librero', 22.5);
  
insert into libros (titulo,autor,editorial,precio,cantidad)   values ('El gato con botas',default,default,default,default);
  
select * from libros;  


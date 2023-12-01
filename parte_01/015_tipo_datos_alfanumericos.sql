-- Tipos de datos alfanumericos

-- Para almacenar valores alfanumericos utilizamos cadenas de texto. 

/*

char(x): define una cadena de caracteres de longitud fija determinada por el argumento "x". 
Si se omite el argumento, por defecto coloca 1. Su rango es de 1 a 2000 caracteres.

Que sea una cadena de longitud fija significa que, si definimos un campo como "char(10)" y almacenamos 
el valor "hola" (4 caracteres), Oracle rellenará las 6 posiciones restantes con espacios, es decir, 
ocupará las 10 posiciones; por lo tanto, si la longitud es invariable, es conveniente utilizar el tipo char; 
caso contrario, el tipo varchar2.

varchar2(x): almacena cadenas de caracteres de longitud variable determinada por el argumento "x" (obligatorio). 
Que sea una cadena de longitud variable significa que, si definimos un campo como "varchar2(10)" y almacenamos 
el valor "hola" (4 caracteres), Oracle solamente ocupa las 4 posiciones (4 bytes y no 10 como en el caso de "char"); 
por lo tanto, si la longitud es variable, es conveniente utilizar este tipo de dato y no "char". Su rango es de 1 a 4000 caracteres.

nchar(x): es similar a "char" excepto que permite almacenar caracteres ASCII, EBCDIC y Unicode; 
su rango va de 1 a 1000 caracteres porque se emplean 2 bytes por cada caracter.

nvarchar2(x): es similar a "varchar2", excepto que permite almacenar caracteres Unicode; 
su rango va de 1 a 2000 caracteres porque se emplean 2 bytes por cada caracter.

varchar(x) y char2(x): disponibles en Oracle8.

long: guarda caracteres de longitud variable; puede contener hasta 2000000000 caracteres (2 Gb). 
No admite argumento para especificar su longitud. En Oracle8 y siguientes versiones conviene 
emplear "clob" y "nlob" para almacenar grandes cantidades de datos alfanuméricos.

clob (Character Large OBject) y nclob: puede almacenar hasta 128 terabytes de datos de caracteres en la base de datos.

blob (Binary Large OBject): puede almacenar hasta 128 terabytes de datos de binarios (imágenes, video clips, sonidos etc.)

Si ingresamos un valor numérico (omitiendo las comillas), lo convierte a cadena y lo ingresa como tal.

Por ejemplo, si en un campo definido como varchar2(5) ingresamos el valor 12345, lo toma como si 
hubiésemos tipeado '12345', igualmente, si ingresamos el valor 23.56, lo convierte a '23.56'. Si el valor numérico, 
al ser convertido a cadena supera la longitud definida, aparece un mensaje de error y la sentencia no se ejecuta.

*/

drop table visitantes;

create table visitantes(
    nombre varchar2(30),
    edad number(2),
    sexo char(1),
    domicilio varchar2(30),
    ciudad varchar2(30),
    telefono varchar2(11)
);

insert into visitantes (nombre,edad,sexo,domicilio,ciudad,telefono) values ('Ana Acosta',25,'f','Avellaneda 123','Cordoba','4223344');

insert into visitantes (nombre,edad,sexo,domicilio,ciudad,telefono) values ('Betina Bustos',32,'fem','Bulnes 234','Cordoba','4515151'); -- error

insert into visitantes (nombre,edad,sexo,domicilio,ciudad,telefono)  values ('Carlos Caseres',43,'m','Colon 345','Cordoba',03514555666); -- observacion en campo "telefono"

select * from visitantes;

-- Ejercicio 1

drop table autos;

create table autos(
    patente char(6),
    marca varchar2(20),
    modelo char(4),
    precio number(8,2),
    primary key(patente)
);

insert into autos (patente,marca,modelo,precio)  values('ABC123','Fiat 128','1970',15000);
insert into autos (patente,marca,modelo,precio)  values('BCD456','Renault 11','1990',40000);
insert into autos (patente,marca,modelo,precio)  values('CDE789','Peugeot 505','1990',80000);
insert into autos (patente,marca,modelo,precio)  values('DEF012','Renault Megane','1998',95000);

insert into autos (patente, marca, modelo,  precio) values('DEF022','Renault 198',1991,14000); --falta comillas en "modelo"

insert into autos (patente,marca,modelo,precio)  values('DEF0412','Renault Megane','1998',95000); -- error

insert into autos (patente,marca,modelo,precio)  values('DEF012','Renault Megane','1998',95000); -- error

select * from autos where modelo = '1990';

-- Ejercicio 2

drop table clientes;

create table clientes(
  documento char(8) not null,
  apellido varchar2(20),
  nombre varchar2(20),
  domicilio varchar2(30),
  telefono varchar2 (11)
);

insert into clientes (documento,apellido,nombre,domicilio,telefono)
  values('22333444','Perez','Juan','Sarmiento 980','4223344');
insert into clientes (documento,apellido,nombre,domicilio,telefono)
  values('23444555','Perez','Ana','Colon 234',null);
insert into clientes (documento,apellido,nombre,domicilio,telefono)
  values('30444555','Garcia','Luciana','Caseros 634',null);


insert into clientes (documento,apellido,nombre,domicilio,telefono)
  values('30444555','Garcia','Luciana','Caseros 634',4145020765232); -- error
  
insert into clientes (documento,apellido,nombre,domicilio,telefono)
  values('3044455533','Garcia','Luciana','Caseros 634',null); -- error 

insert into clientes (documento,apellido,nombre,domicilio,telefono)
  values('3044455533','Garcia',Lopez,'Caseros 634',null); -- error 

select * from clientes where apellido = 'Perez';
/*
Aprendimos que una subconsulta puede estar dentro de un "select", "update" y "delete"; también puede estar dentro de un "insert".

Podemos ingresar registros en una tabla empleando un subselect.

La sintaxis básica es la siguiente:

 insert into TABLAENQUESEINGRESA (CAMPOSTABLA1)
  select (CAMPOSTABLACONSULTADA)
  from TABLACONSULTADA;
  
Un profesor almacena las notas de sus alumnos en una tabla llamada "alumnos". Tiene otra tabla llamada "aprobados", 
con algunos campos iguales a la tabla "alumnos" pero en ella solamente almacenará los alumnos que han aprobado el ciclo.

Ingresamos registros en la tabla "aprobados" seleccionando registros de la tabla "alumnos":

 insert into aprobados (documento,nota)
  select (documento,nota)
   from alumnos;

Entonces, se puede insertar registros en una tabla con la salida devuelta por una consulta a otra tabla; para ello escribimos 
la consulta y le anteponemos "insert into" junto al nombre de la tabla en la cual ingresaremos los registros y los campos que 
se cargarán (si se ingresan todos los campos no es necesario listarlos).

La cantidad de columnas devueltas en la consulta debe ser la misma que la cantidad de campos a cargar en el "insert".

Se pueden insertar valores en una tabla con el resultado de una consulta que incluya cualquier tipo de "join".
*/

 drop table alumnos;
 drop table aprobados;

 create table alumnos(
  documento char(8) not null,
  nombre varchar2(30),
  nota number(4,2)
   constraint CK_alumnos_nota_valores check (nota>=0 and nota <=10),
  primary key(documento)
 );

 create table aprobados(
  documento char(8) not null,
  nota number(4,2)
   constraint CK_aprobados_nota_valores check (nota>=0 and nota <=10),
  primary key(documento)
 );

 insert into alumnos values('30000000','Ana Acosta',8);
 insert into alumnos values('30111111','Betina Bustos',9);
 insert into alumnos values('30222222','Carlos Caseros',2.5); 
 insert into alumnos values('30333333','Daniel Duarte',7.7);
 insert into alumnos values('30444444','Estela Esper',3.4);

-- Ingresamos registros en la tabla "aprobados" seleccionando registros de la tabla "alumnos":
-- Note que no se listan los campos en los cuales se cargan los datos porque tienen el mismo 
-- nombre que los de la tabla de la cual extraemos la información.

insert into aprobados 
select documento, nota from alumnos
where nota >=4;

-- Veamos si los registros se han cargado:

select * from aprobados;

-- Ejercicio 1

 drop table facturas cascade constraints;
 drop table clientes;

 create table clientes(
  codigo number(5),
  nombre varchar2(30),
  domicilio varchar2(30),
  primary key(codigo)
 );

 create table facturas(
  numero number(6) not null,
  fecha date,
  codigocliente number(5) not null,
  total number(6,2),
  primary key(numero),
  constraint FK_facturas_cliente
   foreign key (codigocliente)
   references clientes(codigo)
 );

 insert into clientes values(1,'Juan Lopez','Colon 123');
 insert into clientes values(2,'Luis Torres','Sucre 987');
 insert into clientes values(3,'Ana Garcia','Sarmiento 576');
 insert into clientes values(4,'Susana Molina','San Martin 555');

 insert into facturas values(1200,'15/04/2017',1,300);
 insert into facturas values(1201,'15/04/2017',2,550);
 insert into facturas values(1202,'15/04/2017',3,150);
 insert into facturas values(1300,'20/04/2017',1,350);
 insert into facturas values(1310,'22/04/2017',3,100);

-- El comercio necesita una tabla llamada "clientespref" en la cual quiere almacenar el nombre y domicilio de aquellos 
-- clientes que han comprado hasta el momento más de 500 pesos en mercaderías. Elimine la tabla y créela con 
-- esos 2 campos:

 drop table clientespref;
 create table clientespref(
  nombre varchar2(30),
  domicilio varchar2(30)
 );

-- Ingrese los registros en la tabla "clientespref" seleccionando registros de la tabla "clientes" y "facturas"

select * from clientes;

select * from facturas;

insert into clientespref 
select distinct c.nombre, c.domicilio from clientes c
join facturas f
on c.codigo = f.codigocliente
where f.codigocliente in (select codigocliente from facturas group by codigocliente having sum(total) > 500);

 insert into clientespref
  select nombre,domicilio
   from clientes 
   where codigo in 
    (select codigocliente
     from clientes c
     join facturas f
     on codigocliente=codigo
     group by codigocliente
     having sum(total)>500);

-- Vea los registros de "clientespref" (2 registros)

select * from clientespref;


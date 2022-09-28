/*
Un almacén almacena la información de sus ventas en una tabla llamada "facturas" en la cual guarda el número de factura, la 
fecha y el nombre del cliente y una tabla denominada "detalles" en la cual se almacenan los distintos items correspondientes a 
cada factura: el nombre del artículo, el precio (unitario) y la cantidad.

Se necesita una lista de todas las facturas que incluya el número, la fecha, el cliente, la cantidad de artículos comprados y el total:

select f.*,
  (select count(d.numeroitem)
    from Detalles d
    where f.numero=d.numerofactura) as cantidad,
  (select sum(d.preciounitario*cantidad)
    from Detalles d
    where f.numero=d.numerofactura) as total
from facturas f;

El segundo "select" retorna una lista de valores de una sola columna con la cantidad de items por factura (el número de factura 
lo toma del "select" exterior); el tercer "select" retorna una lista de valores de una sola columna con el total por factura 
(el número de factura lo toma del "select" exterior); el primer "select" (externo) devuelve todos los datos de cada factura.

A este tipo de subconsulta se la denomina consulta correlacionada. La consulta interna se evalúa tantas veces como registros 
tiene la consulta externa, se realiza la subconsulta para cada registro de la consulta externa. El campo de la tabla dentro de la 
subconsulta (f.numero) se compara con el campo de la tabla externa.

En este caso, específicamente, la consulta externa pasa un valor de "numero" a la consulta interna. La consulta interna toma 
ese valor y determina si existe en "detalles", si existe, la consulta interna devuelve la suma. El proceso se repite para el 
registro de la consulta externa, la consulta externa pasa otro "numero" a la consulta interna y Oracle repite la evaluación.
*/

 drop table detalles;
 drop table facturas;

 create table facturas(
  numero number(5) not null,
  fecha date,
  cliente varchar2(30),
  primary key(numero)
 );

 create table detalles(
  numerofactura number(5) not null,
  numeroitem number(3) not null, 
  articulo varchar2(30),
  precio number(5,2),
  cantidad number(4),
  primary key(numerofactura,numeroitem),
   constraint FK_detalles_numerofactura
   foreign key (numerofactura)
   references facturas(numero)
   on delete cascade
 );

 insert into facturas values(1200,'15/01/2017','Juan Lopez');
 insert into facturas values(1201,'15/01/2017','Luis Torres');
 insert into facturas values(1202,'15/01/2017','Ana Garcia');
 insert into facturas values(1300,'20/01/2017','Juan Lopez');

 insert into detalles values(1200,1,'lapiz',1,100);
 insert into detalles values(1200,2,'goma',0.5,150);
 insert into detalles values(1201,1,'regla',1.5,80);
 insert into detalles values(1201,2,'goma',0.5,200);
 insert into detalles values(1201,3,'cuaderno',4,90);
 insert into detalles values(1202,1,'lapiz',1,200);
 insert into detalles values(1202,2,'escuadra',2,100);
 insert into detalles values(1300,1,'lapiz',1,300);

-- Se necesita una lista de todas las facturas que incluya el número, la fecha, el cliente, la cantidad de artículos 
-- comprados y el total en dinero:

select f.*,
(select count(d.numeroitem) from detalles d
where f.numero = d.numerofactura) as cantidad,
(select sum(d.precio*cantidad) from detalles d
where f.numero = d.numerofactura) as total
from facturas f;

-- Ejercicio 1


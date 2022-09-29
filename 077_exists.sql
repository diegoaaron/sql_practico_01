/*
Los operadores "exists" y "not exists" se emplean para determinar si hay o no datos en una lista de valores.

Estos operadores pueden emplearse con subconsultas correlacionadas para restringir el resultado de una consulta exterior 
a los registros que cumplen la subconsulta (consulta interior). Estos operadores retornan "true" (si las subconsultas retornan 
registros) o "false" (si las subconsultas no retornan registros).

Cuando se coloca en una subconsulta el operador "exists", Oracle analiza si hay datos que coinciden con la subconsulta, no 
se devuelve ningún registro, es como un test de existencia; Oracle termina la recuperación de registros cuando por lo menos 
un registro cumple la condición "where" de la subconsulta.

La sintaxis básica es la siguiente:

 ... where exists (SUBCONSULTA);
En este ejemplo se usa una subconsulta correlacionada con un operador "exists" en la cláusula "where" para devolver una 
lista de clientes que compraron el artículo "lapiz":

 select cliente,numero
  from facturas f
  where exists
   (select *from Detalles d
     where f.numero=d.numerofactura
     and d.articulo='lapiz');
     
Puede obtener el mismo resultado empleando una combinación.

Podemos buscar los clientes que no han adquirido el artículo "lapiz" empleando "if not exists":

 select cliente,numero
  from facturas f
  where not exists
   (select *from Detalles d
     where f.numero=d.numerofactura
     and d.articulo='lapiz');
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
  numeroitem number(4) not null, 
  articulo varchar2(30),
  precio number(5,2),
  cantidad number(3),
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

-- Empleamos una subconsulta correlacionada con un operador "exists" en la cláusula "where" para devolver la lista de 
-- clientes que compraron el artículo "lapiz":

select cliente, numero from facturas f
where exists
(select * from detalles d
where f.numero = d.numerofactura
and d.articulo='lapiz');

-- Obtenemos el mismo resultado empleando una combinación:

select * from facturas f
join detalles d
on f.numero = d.numerofactura
where d.articulo = 'lapiz';

-- Buscamos los clientes que NO han comprado el artículo "lapiz":



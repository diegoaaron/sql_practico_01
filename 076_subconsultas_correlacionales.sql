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






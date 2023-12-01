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

select cliente, numero from facturas f
where not exists
(select * from detalles d
where f.numero =d.numerofactura
and d.articulo='lapiz');

-- Ejercicio 1 

 drop table inscriptos;
 drop table socios;

 create table socios(
  numero number(4),
  documento char(8),
  nombre varchar2(30),
  domicilio varchar2(30),
  primary key (numero)
 );
 
 create table inscriptos (
  numerosocio number(4) not null,
  deporte varchar2(20) not null,
  cuotas number(2) default 0,
  constraint CK_inscriptos_cuotas
   check (cuotas>=0 and cuotas<=10),
  primary key(numerosocio,deporte),
  constraint FK_inscriptos_socio
   foreign key (numerosocio)
   references socios(numero)
   on delete cascade
 );

 insert into socios values(1,'23333333','Alberto Paredes','Colon 111');
 insert into socios values(2,'24444444','Carlos Conte','Sarmiento 755');
 insert into socios values(3,'25555555','Fabian Fuentes','Caseros 987');
 insert into socios values(4,'26666666','Hector Lopez','Sucre 344');

 insert into inscriptos values(1,'tenis',1);
 insert into inscriptos values(1,'basquet',2);
 insert into inscriptos values(1,'natacion',1);
 insert into inscriptos values(2,'tenis',9);
 insert into inscriptos values(2,'natacion',1);
 insert into inscriptos values(2,'basquet',default);
 insert into inscriptos values(2,'futbol',2);
 insert into inscriptos values(3,'tenis',8);
 insert into inscriptos values(3,'basquet',9);
 insert into inscriptos values(3,'natacion',0);
 insert into inscriptos values(4,'basquet',10);

-- Emplee una subconsulta con el operador "exists" para devolver la lista de socios que se inscribieron en un determinado 
-- deporte.

select nombre from socios s
where exists 
(select deporte from inscriptos i
where s.numero = i.numerosocio
and i.deporte='natacion');

-- Busque los socios que NO se han inscripto en un deporte determinado empleando "not exists".

select nombre from socios s
where not exists 
(select deporte from inscriptos i
where s.numero = i.numerosocio
and i.deporte='natacion');

-- Muestre todos los datos de los socios que han pagado todas las cuotas.

select nombre from socios s
where exists 
(select deporte from inscriptos i
where s.numero = i.numerosocio
and i.cuotas=10);


-- Obtenga el mismo resultado de la consulta anterior pero esta vez emplee una combinación.

select s.nombre from socios s
inner join inscriptos i
on s.numero = i.numerosocio
where i.cuotas = 10;

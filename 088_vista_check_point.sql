/*
Es posible obligar a todas las instrucciones de modificaci�n de datos que se ejecutan en una vista a cumplir ciertos criterios.

Por ejemplo, creamos la siguiente vista:

 create view vista_empleados
 as
  select apellido, nombre, sexo, seccion
  from empleados
  where seccion='Administracion'
  with check option;
La vista definida anteriormente muestra solamente algunos registros y algunos campos de "empleados", los de la secci�n "Administracion".

Con la cl�usula "with check option", no se permiten modificaciones en aquellos campos que afecten a los registros que retorna la vista. Es decir, 
no podemos modificar el campo "secci�n" porque al hacerlo, tal registro ya no aparecer�a en la vista; si podemos actualizar los dem�s campos. 
Por ejemplo, si intentamos actualizar a "Sistemas" el campo "seccion" de un registro mediante la vista, Oracle muestra un mensaje de error.

La misma restricci�n surge al ejecutar un "insert" sobre la vista; solamente podemos ingresar registros con el valor "Administracion" para "seccion"; 
si intentamos ingresar un registro con un valor diferente de "Administracion" para el campo "seccion", Oracle mostrar� un mensaje de error.

Sintaxis b�sica:

 create view NOMBREVISTA
  as SUBCONSULTA
  with check option;
*/

 drop table empleados;

 create table empleados(
  documento char(8),
  sexo char(1)
   constraint CK_empleados_sexo check (sexo in ('f','m')),
  apellido varchar2(20),
  nombre varchar2(20),
  seccion varchar2(30),
  cantidadhijos number(2),
  constraint CK_empleados_hijos check (cantidadhijos>=0),
  estadocivil char(10)
  constraint CK_empleados_estadocivil check (estadocivil in ('casado','divorciado','soltero','viudo'))
);

 insert into empleados values('22222222','f','Lopez','Ana','Administracion',2,'casado');
 insert into empleados values('23333333','m','Lopez','Luis','Administracion',0,'soltero');
 insert into empleados values('24444444','m','Garcia','Marcos','Sistemas',3,'divorciado');
 insert into empleados values('25555555','m','Gomez','Pablo','Sistemas',2,'casado');
 insert into empleados values('26666666','f','Perez','Laura','Contaduria',3,'casado');

-- Creamos o reemplazamos (si existe) la vista "vista_empleados", para que muestre el nombre, apellido, sexo y secci�n de todos los empleados de 
-- "Administracion" agregando la cl�usula "with check option" para evitar que se modifique la secci�n de tales empleados a trav�s de la vista y que 
-- se ingresen empleados de otra secci�n:

create or replace view vista_empleados as 
select apellido, nombre, sexo, seccion from empleados 
where seccion = 'Administracion' 
with check option;

-- Consultamos la vista:

select * from vista_empleados;

-- Actualizarmos el nombre de un empleado a trav�s de la vista:
-- Oracle acept� la actualizaci�n porque el campo "nombre" no est� restringido.

update vista_empleados set nombre = 'Beatriz' 
where nombre = 'Ana';

-- Veamos si la modificaci�n se realiz� en la tabla:

 select *from empleados;

-- Intentamos actualizar la secci�n de un empleado a trav�s de la vista:
-- Oracle no acept� la actualizaci�n porque el campo "nombre" est� restringido.

update vista_empleados set seccion = 'Sistemas' 
where nombre = 'Beatriz';

-- Ingresamos un registro mediante la vista:
-- Oracle acepta la inserci�n porque ingresamos un valor para "seccion" que incluir� el registro en la vista.

insert into vista_empleados values ('Gomez', 'Gabriela', 'f', 'Administracion');

-- Intentamos ingresar un empleado de otra secci�n:
-- Oracle no acepta la inserci�n porque ingresamos un valor para "seccion" que excluir� el nuevo registro de la vista.

insert into vista_empleados values ('Torres', 'Tatiana', 'f', 'Sistemas');

-- Ejercicio 1 

 drop table clientes;

 create table clientes(
  nombre varchar2(40),
  documento char(8),
  domicilio varchar2(30),
  ciudad varchar2(30)
 );

 insert into clientes values('Juan Perez','22222222','Colon 1123','Cordoba');
 insert into clientes values('Karina Lopez','23333333','San Martin 254','Cordoba');
 insert into clientes values('Luis Garcia','24444444','Caseros 345','Cordoba');
 insert into clientes values('Marcos Gonzalez','25555555','Sucre 458','Santa Fe');
 insert into clientes values('Nora Torres','26666666','Bulnes 567','Santa Fe');
 insert into clientes values('Oscar Luque','27777777','San Martin 786','Santa Fe');
 insert into clientes values('Pedro Perez','28888888','Colon 234','Buenos Aires');
 insert into clientes values('Rosa Rodriguez','29999999','Avellaneda 23','Buenos Aires');
 
 -- Cree o reemplace la vista "vista_clientes" para que recupere el nombre y ciudad de todos los clientes que no sean de "Cordoba" sin emplear 
 -- "with check option"

 create or replace view vista_clientes
 as
  select nombre, ciudad
  from clientes
  where ciudad <>'Cordoba';

 create or replace view vista_clientes2
 as
  select nombre, ciudad
  from clientes
  where ciudad <>'Cordoba'
  with check option;

 select *from vista_clientes;
 select *from vista_clientes2;

 update vista_clientes2 set ciudad='Cordoba' where nombre='Pedro Perez';

 update vista_clientes set ciudad='Cordoba' where nombre='Pedro Perez';

 update vista_clientes2 set ciudad='Buenos Aires' where nombre='Oscar Luque';

 select *from vista_clientes2;

 insert into vista_clientes2 values('Viviana Valdez','Cordoba');

 insert into vista_clientes values('Viviana Valdez','Cordoba');

 insert into vista_clientes2 values('Viviana Valdez','Salta');

 select *from vista_clientes2;

-- Cree o reemplace la vista "vista_clientes2" para que recupere el nombre y ciudad de todos los clientes que no sean de "Cordoba" empleando 
-- "with check option"

-- Consulte ambas vistas

-- Intente modificar la ciudad del cliente "Pedro Perez" a "Cordoba" trav�s de la vista que est� restringida.

-- Realice la misma modificaci�n que intent� en el punto anterior a trav�s de la vista que no est� restringida

-- Actualice la ciudad del cliente "Oscar Luque" a "Buenos Aires" mediante la vista restringida

-- Verifique que "Oscar Luque" a�n se incluye en la vista

-- Intente ingresar un empleado de "Cordoba" en la vista restringida

-- Ingrese el empleado anterior a trav�s de la vista no restringida

-- Ingrese un empleado de "Salta" en la vista restringida

-- Verifique que el nuevo registro est� incluido en la vista
 
 
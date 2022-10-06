/*
Es posible obligar a todas las instrucciones de modificación de datos que se ejecutan en una vista a cumplir ciertos criterios.

Por ejemplo, creamos la siguiente vista:

 create view vista_empleados
 as
  select apellido, nombre, sexo, seccion
  from empleados
  where seccion='Administracion'
  with check option;
La vista definida anteriormente muestra solamente algunos registros y algunos campos de "empleados", los de la sección "Administracion".

Con la cláusula "with check option", no se permiten modificaciones en aquellos campos que afecten a los registros que retorna la vista. Es decir, 
no podemos modificar el campo "sección" porque al hacerlo, tal registro ya no aparecería en la vista; si podemos actualizar los demás campos. 
Por ejemplo, si intentamos actualizar a "Sistemas" el campo "seccion" de un registro mediante la vista, Oracle muestra un mensaje de error.

La misma restricción surge al ejecutar un "insert" sobre la vista; solamente podemos ingresar registros con el valor "Administracion" para "seccion"; 
si intentamos ingresar un registro con un valor diferente de "Administracion" para el campo "seccion", Oracle mostrará un mensaje de error.

Sintaxis básica:

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

-- Creamos o reemplazamos (si existe) la vista "vista_empleados", para que muestre el nombre, apellido, sexo y sección de todos los empleados de 
-- "Administracion" agregando la cláusula "with check option" para evitar que se modifique la sección de tales empleados a través de la vista y que 
-- se ingresen empleados de otra sección:

create or replace view vista_empleados as 
select apellido, nombre, sexo, seccion from empleados 
where seccion = 'Administracion' 
with check option;

-- Consultamos la vista:

select * from vista_empleados;

-- 

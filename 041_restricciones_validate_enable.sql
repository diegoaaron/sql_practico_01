/*
Sabemos que si agregamos una restricci�n a una tabla que contiene datos, Oracle los controla para asegurarse que 
cumplen con la condici�n de la restricci�n, si alg�n registro no la cumple, la restricci�n no se establecece.

Es posible deshabilitar esta comprobaci�n estableciendo una restricci�n sin comprobar los datos existentes en la tabla.

Podemos hacerlo cuando agregamos la restricci�n (de cualquier tipo) a una tabla para que Oracle acepte los valores 
ya almacenados que infringen la restricci�n. Para ello debemos incluir la opci�n "novalidate" en la instrucci�n "alter table":

alter table libros
add constraint PK_libros_codigo
primary key (codigo) novalidate;

"novalidate" indica que la restricci�n no se aplique en los datos existentes, pero si intentamos 
ingresar un nuevo valor que no cumpla la restricci�n (o actualizarlo), Oracle no lo permite.

Para saber si una restricci�n est� validada o no, podemos consultar el cat�logo "user_constraints" y 
fijarnos lo que informa la columna "validated".

Tambi�n podemos deshabilitar las restricciones para agregar o actualizar datos sin comprobarla:

Entonces, para evitar la comprobaci�n de datos existentes y futuros al crear la restricci�n, la sintaxis b�sica 
es la siguiente:

alter table TABLA
add constraint NOMBRERESTRICCION
TIPO de RESTRICCION (CAMPO o CONDICION)
disable novalidate;

CAMPO si es primary key o unique; CONDICION si es check

Por defecto las restricciones incluyen la opci�n "VALIDATE" (controla los datos existentes) y "ENABLE" (controla 
futuros ingresos de informaci�n)

Los estados "validate" y "novalidate" son relativamente independientes de los estados "enabled" y "disabled".

Cuando habilitamos una restricci�n "primary key" o "unique" con "enable", los datos existentes DEBEN 
cumplir con la restricci�n; aunque coloquemos "novalidate" junto a "enable", Oracle no permite que se 
habilite la restrici�n y valida los datos existentes de todas maneras. No sucede lo mismo con una 
restricci�n "check"; podemos habilitar una restricci�n de control con "enable" y "novalidate", 
Oracle habilita la restricci�n para futuros ingresos y actualizaciones y NO valida los datos existentes.

Entonces, "enable" o "disable" activa o desactiva la restricci�n para los nuevos datos ("enable" es la opci�n 
predeterminada si no se especifica); "validate" o "novalidate" es la opci�n para validar la restricci�n en los 
datos existentes ("validate" es la predetermidada si se omite).

Una restricci�n puede estar en los siguientes estados:

- validate y enabled: comprueba los valores existentes y los posteriores ingresos y actualizaciones;

- validate y disable: comprueba los valores existentes pero no las posteriores inserciones y actualizaciones;

- novalidate y enabled: no comprueba los datos existentes, pero si los posteriores ingresos y actualizaciones;

- novalidate y disabled: no comprueba los valores existentes ni los posteriores ingresos y actualizaciones.

*/

drop table libros;

create table libros(
  codigo number(5),
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar2(15),
  precio number(5,2)
);

insert into libros values (1,'Uno','Bach','Planeta',22);
insert into libros values (2,'El quijote','Cervantes','Emece',15);
insert into libros values (2,'Aprenda PHP','Mario Molina','Siglo XXI',-40);

-- Intentamos agregar una restricci�n "primary key" para asegurar que los c�digos no se repitan, pero como 
-- ya tenemos almacenado registros que infringen la restricci�n, Oracle nos mostrar� un mensaje de error:

alter table libros
add constraint PK_LIBROS_CODIGO
primary key(codigo);

-- Vamos a especificar que no haya comprobaci�n de datos existentes agregando "disable" y "novalidate":

alter table libros
add constraint  PK_LIBROS_CODIGO
primary key (codigo) disable novalidate;

-- Veamos lo que nos informa "user_constraints":

select constraint_name, constraint_type, status, validated from user_constraints where table_name = 'LIBROS';

-- Si ingresamos un registro con c�digo existente, Oracle lo permite, porque la restricci�n est� en estado "disabled":

insert into libros values (2,'Momo','Michael Ende','Alfaragua',25);

-- Intentamos habilitar la restricci�n sin verificar los datos ya almacenados:

alter table libros
enable novalidate constraint PK_LIBROS_CODIGO;

-- No lo permite, aun cuando especificamos que no valide los datos existentes, Oracle realiza la verificaci�n igualmente.
-- Eliminamos los registros con clave duplicada:

delete libros where titulo='El quijote';

delete libros where titulo='Momo';

-- Ahora Oracle permite habilitar la restricci�n:

alter table libros
enable novalidate constraint PK_LIBROS_CODIGO;

-- Si intentamos actualizar un registro repitiendo la clave primaria, Oracle no lo permite:

insert into libros values (2,'Momo','Michael Ende','Alfaragua',25);

-- Veamos lo que nos informa "user_constraints"

select constraint_name, constraint_type, validated from user_constraints where table_name = 'LIBROS';

-- Intentamos agregamos una restricci�n "check" que no permita valores negativos para el precio:

alter table libros
add constraint CK_LIBROS_PRECIO
check (precio >= 0);

-- Oracle no lo permite porque, por defecto, la opci�n es "validate" y existen precios que violan la 
-- restricci�n que intentamos establecer.

-- Agregamos la restricci�n especificando que no valide los datos almacenados:

alter table libros
add constraint CK_LIBROS_PRECIO
check(precio >= 0) novalidate;

-- Veamos el estado de la restricci�n de control:

select constraint_type, status, validated from user_constraints
where table_name='LIBROS' and constraint_name='CK_LIBROS_PRECIO';

-- Si intentamos ingresar un valor negativo para el precio, aparecer� un mensaje de error, 
-- porque la restricci�n de control creada est� habilitada:

insert into libros values (3,'Momo','Michael Ende','Alfaragua',-25);

-- Deshabilitamos la restricci�n "CK_LIBROS_PRECIO":

alter table libros
disable constraint CK_LIBROS_PRECIO;

-- Veamos el estado actual:

select constraint_type, status, validated
from user_constraints
where table_name='LIBROS' and
constraint_name='CK_LIBROS_PRECIO';

-- Nos muestra que est� deshabilitada y no valida los datos existentes.

-- Ahora si podemos ingresar el registro:

insert into libros values (3,'Momo','Michael Ende','Alfaragua',-25);

-- Habilitamos la restricci�n para futuros ingresos pero no para los existentes:

alter table libros
enable novalidate constraint CK_LIBROS_PRECIO;

-- Note que Oracle lo permite, no valida los datos existentes, pero si fuera otro tipo de restricci�n, no lo permitir�a.

-- Consultamos "user_constraints":

select constraint_type, status, validated
from user_constraints
where table_name='LIBROS' and
constraint_name='CK_LIBROS_PRECIO';

-- Nos muestra que est� habilitada y no valida los datos existentes.

-- Ejercicio 1

drop table empleados;

create table empleados (
  codigo number(6),
  documento char(8),
  nombre varchar2(30),
  seccion varchar2(20),
  sueldo number(6,2)
);

insert into empleados  values (1,'22222222','Alberto Acosta','Sistemas',-10);
insert into empleados values (2,'33333333','Beatriz Benitez','Recursos',3000);
insert into empleados values (3,'34444444','Carlos Caseres','Contaduria',4000);

-- Intente agregar una restricci�n "check" para asegurarse que no se 
-- ingresen valores negativos para el sueldo sin especificar validaci�n ni estado:

alter table empleados
add constraint CK_EMPLEADOS_SUELDO_POSITIVO
check (sueldo >= 0);

-- No se permite porque hay un valor negativo almacenado y por defecto la opci�n es "validate".

-- Vuelva a intentarlo agregando la opci�n "novalidate".

alter table empleados
add constraint CK_EMPLEADOS_SUELDO_POSITIVO
check (sueldo >= 0) novalidate;

-- Intente ingresar un valor negativo para sueldo.

insert into empleados  values (1,'22222222','Alberto Acosta','Sistemas',-10);

-- Deshabilite la restricci�n e ingrese el registro anterior.

alter table empleados
disable constraint CK_EMPLEADOS_SUELDO_POSITIVO;

-- Intente establecer una restricci�n "check" para "seccion" que permita solamente los valores 
-- "Sistemas", "Administracion" y "Contadur�a" sin especificar validaci�n:

alter table empleados
add constraint CK_EMPLEADOS_SECCION_LISTA
check (seccion in ('Sistemas','Administracion','Contaduria'));

-- No lo permite porque existe un valor fuera de la lista.

-- Establezca la restricci�n anterior evitando que se controlen los datos existentes.

alter table empleados
add constraint CK_EMPLEADOS_SECCION_LISTA
check (seccion in ('Sistemas','Administracion','Contaduria')) novalidate;

-- Vea si las restricciones de la tabla est�n o no habilitadas y validadas.
-- Muestra 2 filas, una por cada restricci�n; ambas son de control, ninguna valida los datos existentes,
-- "CK_empleados_sueldo_positivo" est� deshabilitada, la otra habilitada.

select constraint_type, status, validated, constraint_name
from user_constraints
where table_name='EMPLEADOS' and
constraint_name like '%EMPLEADOS%';

-- Habilite la restricci�n deshabilitada.
-- Note que existe un sueldo que infringe la condici�n.

alter table empleados
enable constraint CK_EMPLEADOS_SUELDO_POSITIVO;

-- Intente modificar la secci�n del empleado "Carlos Caseres" a "Recursos"
-- No lo permite.

update empleados set seccion = 'Recursos' where nombre = 'Carlos Caseres';

-- Deshabilite la restricci�n para poder realizar la actualizaci�n del punto precedente.

alter table empleados
disable constraint CK_EMPLEADOS_SECCION_LISTA;

-- Agregue una restricci�n "primary key" para el campo "codigo" deshabilitada.

alter table empleados
add constraint PK_EMPLEADOS
primary key(codigo) disable;

-- Ingrese un registro con c�digo existente.

insert into empleados values (2,'33333344','Beatriz Benitez','Recursos',3000);

-- Intente habilitar la restricci�n.
-- No se permite porque aun cuando se especifica que no lo haga, Oracle verifica los 
-- datos existentes, y existe un c�digo repetido

alter table empleados 
enable constraint PK_EMPLEADOS;

-- Modifique el registro con clave primaria repetida.

delete from empleados where codigo = 2;

-- Habilite la restricci�n "primary key"

alter table empleados 
enable constraint PK_EMPLEADOS;

-- Agregue una restricci�n "unique" para el campo "documento"

alter table empleados
add constraint UQ_EMPLEADOS_DOCUMENTO
unique (documento);

-- Vea todas las restricciones de la tabla "empleados"

select constraint_type, status, validated, constraint_name
from user_constraints
where table_name='EMPLEADOS' and
constraint_name like '%EMPLEADOS%';

-- Deshabilite todas las restricciones de "empleados"



select * from empleados;

update empleados set  codigo = 5 where documento = '33333344';
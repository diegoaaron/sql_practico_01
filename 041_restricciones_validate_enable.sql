/*
Sabemos que si agregamos una restricción a una tabla que contiene datos, Oracle los controla para asegurarse que 
cumplen con la condición de la restricción, si algún registro no la cumple, la restricción no se establecece.

Es posible deshabilitar esta comprobación estableciendo una restricción sin comprobar los datos existentes en la tabla.

Podemos hacerlo cuando agregamos la restricción (de cualquier tipo) a una tabla para que Oracle acepte los valores 
ya almacenados que infringen la restricción. Para ello debemos incluir la opción "novalidate" en la instrucción "alter table":

alter table libros
add constraint PK_libros_codigo
primary key (codigo) novalidate;

"novalidate" indica que la restricción no se aplique en los datos existentes, pero si intentamos 
ingresar un nuevo valor que no cumpla la restricción (o actualizarlo), Oracle no lo permite.

Para saber si una restricción está validada o no, podemos consultar el catálogo "user_constraints" y 
fijarnos lo que informa la columna "validated".

También podemos deshabilitar las restricciones para agregar o actualizar datos sin comprobarla:

Entonces, para evitar la comprobación de datos existentes y futuros al crear la restricción, la sintaxis básica 
es la siguiente:

alter table TABLA
add constraint NOMBRERESTRICCION
TIPO de RESTRICCION (CAMPO o CONDICION)
disable novalidate;

CAMPO si es primary key o unique; CONDICION si es check

Por defecto las restricciones incluyen la opción "VALIDATE" (controla los datos existentes) y "ENABLE" (controla 
futuros ingresos de información)

Los estados "validate" y "novalidate" son relativamente independientes de los estados "enabled" y "disabled".

Cuando habilitamos una restricción "primary key" o "unique" con "enable", los datos existentes DEBEN 
cumplir con la restricción; aunque coloquemos "novalidate" junto a "enable", Oracle no permite que se 
habilite la restrición y valida los datos existentes de todas maneras. No sucede lo mismo con una 
restricción "check"; podemos habilitar una restricción de control con "enable" y "novalidate", 
Oracle habilita la restricción para futuros ingresos y actualizaciones y NO valida los datos existentes.

Entonces, "enable" o "disable" activa o desactiva la restricción para los nuevos datos ("enable" es la opción 
predeterminada si no se especifica); "validate" o "novalidate" es la opción para validar la restricción en los 
datos existentes ("validate" es la predetermidada si se omite).

Una restricción puede estar en los siguientes estados:

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

-- Intentamos agregar una restricción "primary key" para asegurar que los códigos no se repitan, pero como 
-- ya tenemos almacenado registros que infringen la restricción, Oracle nos mostrará un mensaje de error:

alter table libros
add constraint PK_LIBROS_CODIGO
primary key(codigo);

-- Vamos a especificar que no haya comprobación de datos existentes agregando "disable" y "novalidate":

alter table libros
add constraint  PK_LIBROS_CODIGO
primary key (codigo) disable novalidate;

-- Veamos lo que nos informa "user_constraints":

select constraint_name, constraint_type, status, validated from user_constraints where table_name = 'LIBROS';

-- Si ingresamos un registro con código existente, Oracle lo permite, porque la restricción está en estado "disabled":

insert into libros values (2,'Momo','Michael Ende','Alfaragua',25);

-- Intentamos habilitar la restricción sin verificar los datos ya almacenados:

alter table libros
enable novalidate constraint PK_LIBROS_CODIGO;

-- No lo permite, aun cuando especificamos que no valide los datos existentes, Oracle realiza la verificación igualmente.
-- Eliminamos los registros con clave duplicada:

delete libros where titulo='El quijote';

delete libros where titulo='Momo';

-- Ahora Oracle permite habilitar la restricción:

alter table libros
enable novalidate constraint PK_LIBROS_CODIGO;

-- Si intentamos actualizar un registro repitiendo la clave primaria, Oracle no lo permite:

insert into libros values (2,'Momo','Michael Ende','Alfaragua',25);

-- Veamos lo que nos informa "user_constraints"

select constraint_name, constraint_type, validated from user_constraints where table_name = 'LIBROS';

-- Intentamos agregamos una restricción "check" que no permita valores negativos para el precio:

alter table libros
add constraint CK_LIBROS_PRECIO
check (precio >= 0);

-- Oracle no lo permite porque, por defecto, la opción es "validate" y existen precios que violan la 
-- restricción que intentamos establecer.

-- Agregamos la restricción especificando que no valide los datos almacenados:

alter table libros
add constraint CK_LIBROS_PRECIO
check(precio >= 0) novalidate;

-- Veamos el estado de la restricción de control:

select constraint_type, status, validated from user_constraints
where table_name='LIBROS' and constraint_name='CK_LIBROS_PRECIO';

-- Si intentamos ingresar un valor negativo para el precio, aparecerá un mensaje de error, 
-- porque la restricción de control creada está habilitada:

insert into libros values (3,'Momo','Michael Ende','Alfaragua',-25);

-- Deshabilitamos la restricción "CK_LIBROS_PRECIO":

alter table libros
disable constraint CK_LIBROS_PRECIO;

-- Veamos el estado actual:

select constraint_type, status, validated
from user_constraints
where table_name='LIBROS' and
constraint_name='CK_LIBROS_PRECIO';

-- Nos muestra que está deshabilitada y no valida los datos existentes.

-- Ahora si podemos ingresar el registro:

insert into libros values (3,'Momo','Michael Ende','Alfaragua',-25);

-- Habilitamos la restricción para futuros ingresos pero no para los existentes:

alter table libros
enable novalidate constraint CK_LIBROS_PRECIO;

-- Note que Oracle lo permite, no valida los datos existentes, pero si fuera otro tipo de restricción, no lo permitiría.

-- Consultamos "user_constraints":

select constraint_type, status, validated
from user_constraints
where table_name='LIBROS' and
constraint_name='CK_LIBROS_PRECIO';

-- Nos muestra que está habilitada y no valida los datos existentes.

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

-- Intente agregar una restricción "check" para asegurarse que no se 
-- ingresen valores negativos para el sueldo sin especificar validación ni estado:

alter table empleados
add constraint CK_EMPLEADOS_SUELDO_POSITIVO
check (sueldo >= 0);

-- No se permite porque hay un valor negativo almacenado y por defecto la opción es "validate".

-- Vuelva a intentarlo agregando la opción "novalidate".

alter table empleados
add constraint CK_EMPLEADOS_SUELDO_POSITIVO
check (sueldo >= 0) novalidate;

-- Intente ingresar un valor negativo para sueldo.

insert into empleados  values (1,'22222222','Alberto Acosta','Sistemas',-10);

-- Deshabilite la restricción e ingrese el registro anterior.

alter table empleados
disable constraint CK_EMPLEADOS_SUELDO_POSITIVO;

-- Intente establecer una restricción "check" para "seccion" que permita solamente los valores 
-- "Sistemas", "Administracion" y "Contaduría" sin especificar validación:

alter table empleados
add constraint CK_EMPLEADOS_SECCION_LISTA
check (seccion in ('Sistemas','Administracion','Contaduria'));

-- No lo permite porque existe un valor fuera de la lista.

-- Establezca la restricción anterior evitando que se controlen los datos existentes.

alter table empleados
add constraint CK_EMPLEADOS_SECCION_LISTA
check (seccion in ('Sistemas','Administracion','Contaduria')) novalidate;

-- Vea si las restricciones de la tabla están o no habilitadas y validadas.
-- Muestra 2 filas, una por cada restricción; ambas son de control, ninguna valida los datos existentes,
-- "CK_empleados_sueldo_positivo" está deshabilitada, la otra habilitada.

select constraint_type, status, validated, constraint_name
from user_constraints
where table_name='EMPLEADOS' and
constraint_name like '%EMPLEADOS%';

-- Habilite la restricción deshabilitada.
-- Note que existe un sueldo que infringe la condición.

alter table empleados
enable constraint CK_EMPLEADOS_SUELDO_POSITIVO;

-- Intente modificar la sección del empleado "Carlos Caseres" a "Recursos"
-- No lo permite.

update empleados set seccion = 'Recursos' where nombre = 'Carlos Caseres';

-- Deshabilite la restricción para poder realizar la actualización del punto precedente.

alter table empleados
disable constraint CK_EMPLEADOS_SECCION_LISTA;

-- Agregue una restricción "primary key" para el campo "codigo" deshabilitada.

alter table empleados
add constraint PK_EMPLEADOS
primary key(codigo) disable;

-- Ingrese un registro con código existente.

insert into empleados values (2,'33333344','Beatriz Benitez','Recursos',3000);

-- Intente habilitar la restricción.
-- No se permite porque aun cuando se especifica que no lo haga, Oracle verifica los 
-- datos existentes, y existe un código repetido

alter table empleados 
enable constraint PK_EMPLEADOS;

-- Modifique el registro con clave primaria repetida.

delete from empleados where codigo = 2;

-- Habilite la restricción "primary key"

alter table empleados 
enable constraint PK_EMPLEADOS;

-- Agregue una restricción "unique" para el campo "documento"

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
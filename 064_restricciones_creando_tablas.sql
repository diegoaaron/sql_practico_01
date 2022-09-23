/*
Hasta el momento hemos agregado restricciones a tablas existentes con "alter table"; también pueden 
establecerse al momento de crear una tabla (en la instrucción "create table").

En el siguiente ejemplo creamos la tabla "libros" con varias restricciones:

 create table libros(
  codigo number(5),
  titulo varchar2(40),
  codigoautor number(4),
  codigoeditorial number(3),
  precio number(5,2) default 0,
  constraint PK_libros_codigo
   primary key (codigo),
  constraint UQ_libros_tituloautor
    unique (titulo,codigoautor),
  constraint CK_libros_codigoeditorial
   check (codigoeditorial is not null),
  constraint FK_libros_editorial
   foreign key (codigoeditorial)
   references editoriales(codigo)
   on delete cascade,
  constraint FK_libros_autores
   foreign key (codigoautor)
   references autores(codigo)
   on delete set null,
  constraint CK_libros_preciononulo
   check (precio is not null) disable,
  constraint CK_precio_positivo
   check (precio>=0)
);
En el ejemplo definimos las siguientes restricciones:

- "primary key" sobre el campo "codigo";

- "unique" para los campos "titulo" y "codigoautor";

- de control sobre "codigoeditorial" que no permite valores nulos;

- "foreign key" para establecer el campo "codigoeditorial" como clave externa que haga referencia al campo "codigo" de 
"editoriales y permita eliminaciones en cascada;

- "foreign key" para establecer el campo "codigoautor" como clave externa que haga referencia al campo "codigo" de 
"autores" y permita eliminaciones "set null";

- de control sobre "precio" para que no admita valores nulos, deshabilitada;

- "check" para el campo "precio" que no admita valores negativos.

Las restricciones se agregan a la tabla, separadas por comas; colocando "constraint" seguido del nombre de la restricción, 
el tipo y los campos (si es una "primary key", "unique" o "foreign key") o la condición (si es de control); también puede 
especificarse el estado y la validación de datos (por defecto es "enable" y "validate"); y en el caso de las "foreign key", 
la opción para eliminaciones.

Si definimos una restricción "foreign key" al crear una tabla, la tabla referenciada debe existir y debe tener definida la clave 
primaria o única a la cual hace referencia la "foreign key".
*/

 drop table libros;
 drop table editoriales;
 drop table autores;
 
  create table editoriales(
  codigo number(3) not null,
  nombre varchar2(30),
  constraint PK_editoriales
   primary key (codigo)
);
 
create table autores(
codigo number(4) not null
constraint CK_autores_codigo
check (codigo>=0),
nombre varchar2(30) not null,
constraint PK_autores_codigo
primary key(codigo),
constraint UQ_autores_nombre
unique(nombre)
);
 
 create table libros(
 codigo number(5),
 titulo varchar2(40),
 codigoautor number(4),
 codigoeditorial number(3),
 precio number(5,2) default 0,
 constraint PK_libros_codigo
 primary key(codigo),
 constraint UQ_libros_tituloautor
 unique (titulo,codigoautor),
 constraint CK_libros_codigoeditorial
 check (codigoeditorial is not null),
 constraint FK_libros_editorial
 foreign key (codigoeditorial)
references editoriales(codigo)
on delete cascade,
constraint FK_libros_autores
foreign key (codigoautor)
references autores(codigo)
on delete set null,
constraint CK_libros_preciononulo
check (precio is not null) disable,
constraint CK_precio_positivo
check(precio >= 0)
);
 
 -- Recuerde que si definimos una restricción "foreign key" al crear una tabla, la tabla referenciada debe existir, por ello 
 -- creamos las tablas "editoriales" y "autores" antes que "libros".

-- Veamos las restricciones de "editoriales":
-- Una tabla nos informa que hay una restricción de control y una "primary key", ambas habilitadas y validan los datos existentes.

 select constraint_name, constraint_type, search_condition, status, validated
  from user_constraints
  where table_name='EDITORIALES';
 
 -- Veamos las restricciones de "autores":
-- Oracle nos informa que hay 3 restricciones de control, una "primary key" y una única.

 select constraint_name, constraint_type, search_condition, status, validated
  from user_constraints
  where table_name='AUTORES';
 
--  Veamos las restricciones de "libros":
-- la tabla tiene 7 restricciones: 3 de control (2 "enabled" y "validated" y 1 "disabled" y "not validated"), 1 "primary key" 
-- ("enabled" "validated"), 1 "unique" ("enabled" "validated") y 2 "foreign key" ("enabled" "validated").

  select constraint_name, constraint_type, search_condition, status, validated
  from user_constraints
  where table_name='LIBROS';
 
 -- Ingresamos algunos registros en las tres tablas.
-- Recuerde que debemos ingresar registros en las tablas "autores" y "editoriales" antes que en "libros", a menos que 
-- deshabilitemos las restricciones "foreign key".

-- Note que un libro tiene precio nulo, la tabla "libros" tiene una restricción de control que no admite precios nulos, 
--pero está deshabilitada.

 insert into editoriales values(1,'Emece');
 insert into editoriales values(2,'Planeta');
 insert into editoriales values(3,'Norma');

 insert into autores values(100,'Borges');
 insert into autores values(101,'Bach Richard');
 insert into autores values(102,'Cervantes');
 insert into autores values(103,'Gaskin');

 insert into libros values(200,'El aleph',100,1,40);
 insert into libros values(300,'Uno',101,2,20);
 insert into libros values(400,'El quijote',102,3,20);
 insert into libros values(500,'El experto en laberintos',103,3,null);

 -- Realizamos un "join" para mostrar todos los datos de los libros:

select l.codigo, a.nombre as autor, e.nombre as editorial, precio
from libros l
join autores a
on codigoautor = a.codigo
join editoriales e
on codigoeditorial = e.codigo;

-- Habilitamos la restricción de control deshabilitada sin controlar los datos ya cargados:

alter table libros
enable novalidate
constraint CK_libros_preciononulo;

-- Intentamos ingresar un libro con precio nulo:
-- Oracle no lo permite, la restricción está habilitada.

 insert into libros values(600,'El anillo del hechicero',103,3,null);

-- Eliminamos un autor:

delete autores where codigo = 100;

-- Veamos si se setearon a "null" los libros de tal autor (la restricción "FK_LIBROS_AUTORES" así lo especifica):
-- El libro con código 200 tiene el valor "null" en "autor".

select * from libros;

-- Eliminamos una editorial:

delete editoriales where codigo = 1;

-- Veamos si se eliminaron los libros de tal editorial (la restricción "FK_LIBROS_EDITORIALES" fue establecida "cascade"):
-- Ya no está el libro "200".

select * from libros;

-- Ejercicio 1

/*
Un club de barrio tiene en su sistema 4 tablas:

- "socios": en la cual almacena documento, número, nombre y domicilio de cada socio;

- "deportes": que guarda un código, nombre del deporte, día de la semana que se dicta y documento del profesor instructor;

- "profesores": donde se guarda el documento, nombre y domicilio de los profesores e

- "inscriptos": que almacena el número de socio, el código de deporte y si la matricula está paga o no.

Considere que:

- un socio puede inscribirse en varios deportes, pero no dos veces en el mismo.
- un socio tiene un documento único y un número de socio único.
- un deporte debe tener asignado un profesor que exista en "profesores" o "null" si aún no tiene un instructor definido.
- el campo "dia" de "deportes" puede ser: lunes, martes, miercoles, jueves, viernes o sabado.
- el campo "dia" de "deportes" por defecto debe almacenar 'sabado'.
- un profesor puede ser instructor de varios deportes o puede no dictar ningún deporte.
- un profesor no puede estar repetido en "profesores".
- un inscripto debe ser socio, un socio puede no estar inscripto en ningún deporte.
- una inscripción debe tener un valor en socio existente en "socios" y un deporte que exista en "deportes".
- el campo "matricula" de "inscriptos" debe aceptar solamente los caracteres 's' o'n'.
- si se elimina un profesor de "profesores", el "documentoprofesor" coincidente en "deportes" debe quedar seteado a null.
- no se puede eliminar un deporte de "deportes" si existen inscriptos para tal deporte en "inscriptos".
- si se elimina un socio de "socios", el registro con "numerosocio" coincidente en "inscriptos" debe eliminarse.

*/

 drop table inscriptos;
 drop table socios;
 drop table deportes;
 drop table profesores;
 
 create table profesores(
 documento char(8) not null,
 nombre varchar2(30),
 domicilio varchar2(30),
 constraint PK_profesores_documento
primary key (documento)
);
 
 create table deportes(
 codigo number(2),
 nombre varchar2(20) not null,
 dia varchar2(9) default 'sabado',
 documentoprofesor char(8),
 constraint CK_deportes_dia_lista
 check (dia in ('lunes', 'martes', 'miercoles', 'jueves', 'viernes', 'sabado')),
 constraint PK_deportes_codigo
 primary key(codigo),
 constraint FK_deportes_profesor
 foreign key (documentoprofesor)
 references profesores(documento)
 on delete set null
 );
 
 create table socios(
 numero number(4),
 documento char(8),
 nombre varchar2(30),
 domicilio varchar2(30),
 constraint PK_socios_numero
 primary key(numero),
 constraint UQ_socios_documento
 unique (documento)
 );
 
 create table inscriptos(
  numerosocio number(4),
  codigodeporte number(2),
  matricula char(1),
  constraint PK_inscriptos_numerodeporte
   primary key (numerosocio,codigodeporte),
  constraint FK_inscriptos_deporte
   foreign key (codigodeporte)
   references deportes(codigo),
  constraint FK_inscriptos_socios
   foreign key (numerosocio)
   references socios(numero)
   on delete cascade,
  constraint CK_matricula_valores
   check (matricula in ('s','n'))
);

-- Ingrese registros en "profesores":

 insert into profesores values('21111111','Andres Acosta','Avellaneda 111');
 insert into profesores values('22222222','Betina Bustos','Bulnes 222');
 insert into profesores values('23333333','Carlos Caseros','Colon 333');

-- Ingrese registros en "deportes". Ingrese el mismo día para distintos deportes, un deporte sin día confirmado, un deporte 
-- sin profesor definido:

 insert into deportes values(1,'basquet','lunes',null);
 insert into deportes values(2,'futbol','lunes','23333333');
 insert into deportes values(3,'natacion',null,'22222222');
 insert into deportes values(4,'padle',default,'23333333');
 insert into deportes values(5,'tenis','jueves',null);

-- Ingrese registros en "socios":

 insert into socios values(100,'30111111','Martina Moreno','America 111');
 insert into socios values(200,'30222222','Natalia Norte','Bolivia 222');
 insert into socios values(300,'30333333','Oscar Oviedo','Caseros 333');
 insert into socios values(400,'30444444','Pedro Perez','Dinamarca 444');

-- Ingrese registros en "inscriptos". Inscriba a un socio en distintos deportes, inscriba varios socios en el mismo deporte.

 insert into inscriptos values(100,3,'s');
 insert into inscriptos values(100,5,'s');
 insert into inscriptos values(200,1,'s');
 insert into inscriptos values(400,1,'n');
 insert into inscriptos values(400,4,'s');

-- Realice un "join" (del tipo que sea necesario) para mostrar todos los datos del socio junto con el nombre de los deportes 
-- en los cuales está inscripto, el día que tiene que asistir y el nombre del profesor que lo instruirá (5 registros)

select so.numero, so.documento, so.nombre, so.domicilio, de.nombre, de.dia, pr.nombre
from inscriptos ins
join socios so
on ins.numerosocio = so.numero
join deportes de
on ins.codigodeporte = de.codigo
left join profesores pr
on de.documentoprofesor = pr.documento;

-- Realice la misma consulta anterior pero incluya los socios que no están inscriptos en ningún deporte (6 registros)

  select s.*,d.nombre as deporte,d.dia,p.nombre as profesor
  from socios s
  full join inscriptos i
  on numero=i.numerosocio
 left join deportes d
  on d.codigo=i.codigodeporte
  left join profesores p
  on d.documentoprofesor=p.documento;

-- Muestre todos los datos de los profesores, incluido el deporte que dicta y el día, incluyendo los profesores que no tienen 
-- asignado ningún deporte, ordenados por documento (4 registros)

select pro.*, de.nombre as deporte, de.dia
from profesores pro
left join deportes de
on pro.documento = de.documentoprofesor
order by pro.documento;

-- Muestre todos los deportes y la cantidad de inscriptos en cada uno de ellos, incluyendo aquellos deportes para los cuales 
-- no hay inscriptos, ordenados por nombre de deporte (5 registros)

select de.nombre, count(ins.codigodeporte) as "num inscritos" 
from deportes de
left join inscriptos ins
on de.codigo = ins.codigodeporte
group by de.nombre
order by de.nombre;

-- Muestre las restricciones de "socios"

 select constraint_name, constraint_type, status, validated
  from user_constraints where table_name='SOCIOS';

-- Muestre las restricciones de "deportes"

select constraint_name, constraint_type, status, validated, search_condition
  from user_constraints where table_name='DEPORTES';

-- Obtenga información sobre la restricción "foreign key" de "deportes"

select *from user_cons_columns
  where constraint_name='FK_DEPORTES_PROFESOR';

-- Muestre las restricciones de "profesores"

 select constraint_name, constraint_type, status, validated, search_condition
from user_constraints where table_name='PROFESORES';

-- Muestre las restricciones de "inscriptos"

 select constraint_name, constraint_type, status, validated, search_condition
  from user_constraints
  where table_name='INSCRIPTOS';

-- Consulte "user_cons_columns" y analice la información retornada sobre las restricciones de "inscriptos"

 select *from user_cons_columns
  where table_name='INSCRIPTOS';

-- Elimine un profesor al cual haga referencia algún registro de "deportes"

delete from profesores where documento = '22222222';

-- Vea qué sucedió con los registros de "deportes" cuyo "documentoprofesor" existía en "profesores"
-- Fue seteado a null porque la restricción "foreign key" sobre "documentoprofesor" de "deportes" fue definida "on delete set null".

-- Elimine un socio que esté inscripto

-- Vea qué sucedió con los registros de "inscriptos" cuyo "numerosocio" existía en "socios"
-- Fue eliminado porque la restricción "foreign key" sobre "numerosocio" de "inscriptos" fue definida "on delete cascade".

-- Intente eliminar un deporte para el cual haya inscriptos
-- Mensaje de error porque la restricción "foreign key sobre "codigodeporte" de "inscriptos" fue establecida "no action".

-- Intente eliminar la tabla "socios"
-- No puede eliminarse, mensaje de error, una "foreign key" sobre "inscriptos" hace referencia a esta tabla.

-- Elimine la tabla "inscriptos"

-- Elimine la tabla "socios"

-- Intente eliminar la tabla "profesores"
-- No puede eliminarse, mensaje de error, una "foreign key" sobre "deportes" hace referencia a esta tabla.

-- Elimine la tabla "deportes"

-- Elimine la tabla "profesores"




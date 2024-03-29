/*
Una vista es un objeto. Una vista es una alternativa para mostrar datos de varias tablas; es como una tabla virtual que 
almacena una consulta. Los datos accesibles a trav�s de la vista no est�n almacenados en la base de datos, en la base de 
datos se guarda la definici�n de la vista y no el resultado de ella.

Entonces, una vista almacena una consulta como un objeto para utilizarse posteriormente. Las tablas consultadas en 
una vista se llaman tablas base. En general, se puede dar un nombre a cualquier consulta y almacenarla como una vista.

Una vista suele llamarse tambi�n tabla virtual porque los resultados que retorna y la manera de referenciarlas es la 
misma que para una tabla.

Las vistas permiten:

- simplificar la administraci�n de los permisos de usuario: se pueden dar al usuario permisos para que solamente pueda 
acceder a los datos a trav�s de vistas, en lugar de concederle permisos para acceder a ciertos campos, as� se protegen 
las tablas base de cambios en su estructura.

- mejorar el rendimiento: se puede evitar tipear instrucciones repetidamente almacenando en una vista el resultado de 
una consulta compleja que incluya informaci�n de varias tablas.

Podemos crear vistas con: un subconjunto de registros y campos de una tabla; una uni�n de varias tablas; una combinaci�n 
de varias tablas; un subconjunto de otra vista, combinaci�n de vistas y tablas.

Una vista se define usando un "create view".

La sintaxis b�sica para crear una vista es la siguiente:

create view NOMBREVISTA as
  SUBCONSULTA;

El contenido de una vista se muestra con un "select":

 select *from NOMBREVISTA;
En el siguiente ejemplo creamos la vista "vista_empleados", que es resultado de una combinaci�n en la cual se muestran 
4 campos:

 create view vista_empleados as
  select (apellido||' '||e.nombre) as nombre,sexo,
   s.nombre as seccion, cantidadhijos
   from empleados e
   join secciones s
   on codigo=seccion;
   
Para ver la informaci�n contenida en la vista creada anteriormente tipeamos:

 select *from vista_empleados;
Podemos realizar consultas a una vista como si se tratara de una tabla:

 select seccion,count(*) as cantidad
  from vista_empleados
  group by seccion;
Los nombres para vistas deben seguir las mismas reglas que cualquier identificador. Para distinguir una tabla de una 
vista podemos fijar una convenci�n para darle nombres, por ejemplo, colocar el sufijo �vista� y luego el nombre de las tablas 
consultadas en ellas.

Los campos y expresiones de la consulta que define una vista DEBEN tener un nombre. Se debe colocar nombre de campo 
cuando es un campo calculado o si hay 2 campos con el mismo nombre. Note que en el ejemplo, al concatenar los 
campos "apellido" y "nombre" colocamos un alias; si no lo hubi�semos hecho aparecer�a un mensaje de error porque 
dicha expresi�n DEBE tener un encabezado, Oracle no lo coloca por defecto.

Los nombres de los campos y expresiones de la consulta que define una vista DEBEN ser �nicos (no puede haber dos 
campos o encabezados con igual nombre). Note que en la vista definida en el ejemplo, al campo "s.nombre" le colocamos 
un alias porque ya hab�a un encabezado (el alias de la concatenaci�n) llamado "nombre" y no pueden repetirse, si 
sucediera, aparecer�a un mensaje de error.

Otra sintaxis es la siguiente:

 create view NOMBREVISTA (NOMBRESDEENCABEZADOS)
  as
  SUBCONSULTA;
  
Creamos otra vista de "empleados" denominada "vista_empleados_ingreso" que almacena la cantidad de empleados 
por a�o:

 create view vista_empleados_ingreso (fecha,cantidad)
  as
  select extract(year from fechaingreso),count(*)
   from empleados
   group by extract(year from fechaingreso);
   
La diferencia es que se colocan entre par�ntesis los encabezados de las columnas que aparecer�n en la vista. Si no los 
colocamos y empleamos la sintaxis vista anteriormente, se emplean los nombres de los campos o alias (que en este caso 
habr�a que agregar) colocados en el "select" que define la vista. Los nombres que se colocan entre par�ntesis deben 
ser tantos como los campos o expresiones que se definen en la vista.

Las vistas se crean en la base de datos activa.

Al crear una vista, Oracle verifica que existan las tablas a las que se hacen referencia en ella; no se puede crear una vista 
que referencie tablas inexistentes. No se puede crear una vista si existe un objeto con ese nombre.

Se aconseja probar la sentencia "select" con la cual definiremos la vista antes de crearla para asegurarnos que el resultado 
que retorna es el imaginado.

Una vista siempre est� actualizada; si modificamos las tablas base (a las cuales referencia la vista), la vista mostrar� los cambios.

Se pueden construir vistas sobre otras vistas.
*/

 drop table empleados;
 drop table secciones;

 create table secciones(
  codigo number(2),
  nombre varchar2(20),
  sueldo number(5,2)
   constraint CK_secciones_sueldo check (sueldo>=0),
  constraint PK_secciones primary key (codigo)
 );

 create table empleados(
  legajo number(5),
  documento char(8),
  sexo char(1)
   constraint CK_empleados_sexo check (sexo in ('f','m')),
  apellido varchar2(20),
  nombre varchar2(20),
  domicilio varchar2(30),
  seccion number(2) not null,
  cantidadhijos number(2)
   constraint CK_empleados_hijos check (cantidadhijos>=0),
  estadocivil char(10)
   constraint CK_empleados_estadocivil check (estadocivil in ('casado','divorciado','soltero','viudo')),
  fechaingreso date,
   constraint PK_empleados primary key (legajo),
  constraint FK_empleados_seccion
   foreign key (seccion)
   references secciones(codigo),
  constraint UQ_empleados_documento
   unique(documento)
);

 insert into secciones values(1,'Administracion',300);
 insert into secciones values(2,'Contadur�a',400);
 insert into secciones values(3,'Sistemas',500);

 insert into empleados values(100,'22222222','f','Lopez','Ana','Colon 123',1,2,'casado','10/10/1990');
 insert into empleados values(102,'23333333','m','Lopez','Luis','Sucre 235',1,0,'soltero','02/10/1990');
 insert into empleados values(103,'24444444','m','Garcia','Marcos','Sarmiento 1234',2,3,'divorciado','12/07/1998');
 insert into empleados values(104,'25555555','m','Gomez','Pablo','Bulnes 321',3,2,'casado','10/09/1998');
 insert into empleados values(105,'26666666','f','Perez','Laura','Peru 1254',3,3,'casado','05/09/2000');

-- Eliminamos la vista "vista_empleados". A�n no hemos aprendido a eliminar vistas, lo veremos pr�ximamente:

drop view vista_empleados;

-- Creamos la vista "vista_empleados", que es resultado de una combinaci�n en la cual se muestran 5 campos:

create view vista_empleados as 
select (apellido || ' ' || e.nombre) as nombre, sexo, s.nombre as seccion, cantidadhijos from empleados e
inner join secciones s
on codigo = seccion;

-- Veamos la informacion de la vista

select * from vista_empleados;

-- Realizamos una consulta a la vista como si se tratara de una tabla:

select seccion, count(*) as cantidad from vista_empleados
group by seccion;

-- Eliminamos la vista "vista_empleados_ingreso":

drop view vista_empleados_ingreso;

-- Creamos otra vista de "empleados" denominada "vista_empleados_ingreso" que almacena la cantidad de empleados por a�o:

create view vista_empleados_ingreso 
(fecha, cantidad) as select extract(year from fechaingreso), count(*) from empleados
group by extract(year from fechaingreso);

-- Vemos la informaci�n:

select * from vista_empleados_ingreso;

-- Hemos aprendido que los registros resultantes de una vista no se almacena en la base de datos, sino la definici�n de 
-- la vista, por lo tanto, al modificar las tablas referenciadas por la vista, el resultado de la vista cambia.

-- Modificamos una fecha en la tabla "empleados" y luego consultamos la vista para verificar que est� actualizada:

update empleados set fechaingreso = '10/09/2000' where fechaingreso = '10/09/1998';

select * from vista_empleados_ingreso;

-- Ejercicio 1

 drop table inscriptos;
 drop table cursos;
 drop table socios;
 drop table profesores; 

 create table socios(
  documento char(8) not null,
  nombre varchar2(40),
  domicilio varchar2(30),
  primary key (documento)
 );

 create table profesores(
  documento char(8) not null,
  nombre varchar2(40),
  domicilio varchar2(30),
  primary key (documento)
 );

 create table cursos(
  numero number(2),
  deporte varchar2(20),
  dia varchar2(15),
  documentoprofesor char(8),
  constraint CK_inscriptos_dia
    check (dia in('lunes','martes','miercoles','jueves','viernes','sabado')),
  constraint FK_documentoprofesor 
   foreign key (documentoprofesor)
   references profesores(documento),
   primary key (numero)
 );

 create table inscriptos(
  documentosocio char(8) not null,
  numero number(2) not null,
  matricula char(1),
  constraint CK_inscriptos_matricula check (matricula in('s','n')),
  constraint FK_documentosocio 
   foreign key (documentosocio)
   references socios(documento),
  constraint FK_numerocurso 
   foreign key (numero)
   references cursos(numero),
  primary key (documentosocio,numero)
 );

 insert into socios values('30000000','Fabian Fuentes','Caseros 987');
 insert into socios values('31111111','Gaston Garcia','Guemes 65');
 insert into socios values('32222222','Hector Huerta','Sucre 534');
 insert into socios values('33333333','Ines Irala','Bulnes 345');

 insert into profesores values('22222222','Ana Acosta','Avellaneda 231');
 insert into profesores values('23333333','Carlos Caseres','Colon 245');
 insert into profesores values('24444444','Daniel Duarte','Sarmiento 987');
 insert into profesores values('25555555','Esteban Lopez','Sucre 1204');

 insert into cursos values(1,'tenis','lunes','22222222');
 insert into cursos values(2,'tenis','martes','22222222');
 insert into cursos values(3,'natacion','miercoles','22222222');
 insert into cursos values(4,'natacion','jueves','23333333');
 insert into cursos values(5,'natacion','viernes','23333333');
 insert into cursos values(6,'futbol','sabado','24444444');
 insert into cursos values(7,'futbol','lunes','24444444');
 insert into cursos values(8,'basquet','martes','24444444');

 insert into inscriptos values('30000000',1,'s');
 insert into inscriptos values('30000000',3,'n');
 insert into inscriptos values('30000000',6,null);
 insert into inscriptos values('31111111',1,'s');
 insert into inscriptos values('31111111',4,'s');
 insert into inscriptos values('32222222',8,'s');

-- Elimine la vista "vista_club":

 drop view vista_club;
 
-- Cree una vista en la que aparezca el nombre del socio, el deporte, el d�a, el nombre del profesor y el estado de la 
-- matr�cula (deben incluirse los socios que no est�n inscriptos en ning�n deporte, los cursos para los cuales no hay 
-- inscriptos y los profesores que no tienen designado deporte tambi�n)
 
 create view vista_club as
 select s.nombre as socio, c.deporte, dia, p.nombre as profesor, matricula from socios s
 full join inscriptos i
 on s.documento = i.documentosocio
 full join cursos c
 on i.numero = c.numero
 full join profesores p
 on c.documentoprofesor = p.documento;
 
 -- Muestre la informaci�n contenida en la vista (11 registros)

 select * from vista_club;

-- Realice una consulta a la vista donde muestre la cantidad de socios inscriptos en cada deporte (agrupe por deporte y 
-- d�a) ordenados por cantidad

 select deporte,dia,count(socio) as cantidad
  from vista_club
  where deporte is not null
  group by deporte,dia
  order by cantidad;

-- Muestre (consultando la vista) los cursos (deporte y d�a) para los cuales no hay inscriptos (3 registros)

select deporte, dia from vista_club
where socio is null and deporte is not null;

-- Muestre los nombres de los socios que no se han inscripto en ning�n curso (consultando la vista) (1 registro)

select socio from vista_club
where deporte is null and socio is not null;

-- Muestre (consultando la vista) los profesores que no tienen asignado ning�n deporte a�n (1 registro)

select profesor from vista_club
where deporte is null and profesor is not null;

-- Muestre (consultando la vista) el nombre de los socios que deben matr�culas (1 registro)

select socio from vista_club 
where deporte is not null and matricula <> 's';

-- Consulte la vista y muestre los nombres de los profesores y los d�as en que asisten al club para dictar sus clases (9 registros)

select distinct profesor, dia from vista_club
where profesor is not null;

-- Muestre la misma informaci�n anterior pero ordenada por d�a

select distinct profesor, dia from vista_club
where profesor is not null
order by dia;

-- Muestre todos los socios que son compa�eros en tenis los lunes (2 registros)

select socio from vista_club
where deporte = 'tenis' and dia = 'lunes';

-- Intente crear una vista denominada "vista_inscriptos" que muestre la cantidad de inscriptos por curso, incluyendo el 
-- n�mero del curso, el nombre del deporte y el d�a

create view vista_inscriptos as
select deporte, dia, (select count(*) from inscriptos i where i.numero = c.numero) as cantidad 
from cursos c;

-- Elimine la vista "vista_inscriptos" y cr�ela para que muestre la cantidad de inscriptos por curso, incluyendo el 
-- n�mero del curso, el nombre del deporte y el d�a

drop view vista_inscriptos;

create view vista_inscriptos as
select deporte, dia, (select count(*) from inscriptos i where i.numero = c.numero) as cantidad
from cursos c;

-- Consulte la vista (9 registros)

select * from vista_inscriptos;


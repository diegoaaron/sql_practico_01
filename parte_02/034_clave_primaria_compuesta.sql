-- Las claves primarias pueden ser simples, formadas por un solo campo o compuestas, más de un campo.

-- Recordemos que una clave primaria identifica un solo registro en una tabla.

-- Para un valor del campo clave existe solamente un registro. Los valores no se repiten ni pueden ser nulos.

/*
Existe una playa de estacionamiento que almacena cada día los datos de los vehículos que ingresan en la 
tabla llamada "vehiculos" con los siguientes campos:

 - patente char(6) not null,
 - tipo char (1), 'a'= auto, 'm'=moto,
 - horallegada date,
 - horasalida date,

Definimos una clave compuesta cuando ningún campo por si solo cumple con la condición para ser clave.

Usamos 2 campos como clave, la patente junto con la hora de llegada, así identificamos unívocamente cada registro.

*/

create table vehiculos(
    patente char(6) not null,
    tipo char(1), -- 'a'= auto, 'm' moto
    horallegada date,
    horasalida date,
    primary key(patente, horallegada)
);

-- Para ver la clave primaria de una tabla podemos realizar la siguiente consulta

select uc.table_name, column_name, position from user_cons_columns ucc
join user_constraints uc
on ucc.constraint_name=uc.constraint_name
where uc.constraint_type='P' and
uc.table_name='VEHICULOS';

-- Una playa de estacionamiento almacena cada día los datos de los vehículos 
-- que ingresan en la tabla llamada "vehiculos".

-- Seteamos el formato de "date" para que nos muestre únicamente la hora y los minutos, 
-- ya que en esta playa, se almacenan los datos de los vehículos diariamente:

ALTER SESSION SET NLS_DATE_FORMAT = 'HH24:MI';

drop table vehiculos;

create table vehiculos(
  patente char(6) not null,
  tipo char(1),--'a'=auto, 'm'=moto
  horallegada date,
  horasalida date,
  primary key(patente,horallegada)
);

insert into vehiculos values('AIC124','a','8:05','12:30');
insert into vehiculos values('CAA258','a','8:05',null);
insert into vehiculos values('DSE367','m','8:30','18:00');
insert into vehiculos values('FGT458','a','9:00',null);
insert into vehiculos values('AIC124','a','16:00',null);
insert into vehiculos values('LOI587','m','18:05','19:55');

-- Si intentamos ingresar un registro con clave primaria repetida

insert into vehiculos values('LOI587','m','18:05',null);

-- Si uno de los campos es repetidos si lo acepta, ya que la llave primaria es compuesta

insert into vehiculos values('LOI587','m','21:30',null);

select * from vehiculos;

-- Si intentamos actualizar un registro repitiendo la clave primaria, mostrar un error

update vehiculos set horallegada = '08:05' where patente='AIC124' and horallegada='16:00';

-- la llaves primarias no aceptan null aunque no se definiera en la creación de la tabla

insert into vehiculos values('HUO690','m',null,null);

describe vehiculos;

-- Ejercicio 1

drop table consultas;

/*
  - fechayhora: date not null, fecha y hora de la consulta,
  - medico: varchar2(30), not null, nombre del médico (Perez,Lopez,Duarte),
  - documento: char(8) not null, documento del paciente,
  - paciente: varchar2(30), nombre del paciente,
  - obrasocial: varchar2(30), nombre de la obra social (IPAM,PAMI, etc.).
*/

ALTER SESSION SET NLS_DATE_FORMAT = 'DD/MM/YYYY HH24:MI';

create table consultas(
  fechayhora date not null,
  medico varchar2(30) not null,
  documento char(8) not null,
  paciente varchar2(30),
  obrasocial varchar2(30),
  primary key(fechayhora,medico)
);

insert into consultas values ('05/11/2006 8:00','Lopez','12222222','Acosta Betina','PAMI');
insert into consultas values ('05/11/2006 8:30','Lopez','23333333','Fuentes Carlos','PAMI');
insert into consultas values ('05/11/2006 8:00','Perez','34444444','Garcia Marisa','IPAM');
insert into consultas values ('05/11/2006 8:00','Duarte','45555555','Pereyra Luis','PAMI');

-- Intente ingresar una consulta para un mismo médico en la misma hora el mismo día (mensaje de error)

insert into consultas values('05/11/2006 8:00','Lopez','88888888','Luis Palacios','IPAMI');

-- Intente cambiar la hora de la consulta de "Acosta Betina" por una no disponible ("8:30") (error)

update consultas set fechayhora = '05/11/2006 8:30' where paciente='Acosta Betina';

-- Cambie la hora de la consulta de "Acosta Betina" por una disponible ("9:30")

update consultas set fechayhora = '05/11/2006 9:30', medico='Lopez' where paciente='Acosta Betina';

-- Ingrese una consulta para el día "06/11/2006" a las 10 hs. para el doctor "Perez"

insert into consultas values('06/11/2006 10:00','Perez','34444444','Garcia Marisa','IPAM');

-- Recupere todos los datos de las consultas de "Lopez" (3 registros)

select * from consultas where medico = 'Lopez';

-- Recupere todos los datos de las consultas programadas para el "05/11/2006 8:00" (2 registros)

select * from consultas where fechayhora = '05/11/2006 8:00';

-- Muestre día y mes de todas las consultas de "Lopez"

select extract(month from fechayhora) as mes,  extract(day from fechayhora) as dia 
from consultas where medico = 'Lopez';

-- Ejercicio 2

drop table inscriptos;

/*
 - documento del socio alumno: char(8) not null
 - nombre del socio: varchar2(30),
 - nombre del deporte (tenis, futbol, natación, basquet): varchar2(15) not null,
 - año de inscripcion: date,
 - matrícula: si la matrícula ha sido o no pagada ('s' o 'n').
 
 Necesitamos una clave primaria que identifique cada registro. Un socio puede inscribirse en varios deportes 
 en distintos años. Un socio no puede inscribirse en el mismo deporte el mismo año. Varios socios se inscriben 
 en un mismo deporte en distintos años. Cree la tabla con una clave compuesta
 
*/

create table inscriptos(
  documento char(8) not null, 
  nombre varchar2(30),
  deporte varchar2(15) not null,
  año date,
  matricula char(1),
  primary key(documento,deporte,año)
);

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY';

-- Inscriba a varios alumnos en el mismo deporte en el mismo año

insert into inscriptos values ('12222222','Juan Perez','tenis','2005','s');
insert into inscriptos values ('23333333','Marta Garcia','tenis','2005','s');
insert into inscriptos values ('34444444','Luis Perez','tenis','2005','n');

-- Inscriba a un mismo alumno en varios deportes en el mismo año

insert into inscriptos values ('12222222','Juan Perez','futbol','2005','s');
insert into inscriptos values ('12222222','Juan Perez','natacion','2005','s');
insert into inscriptos values ('12222222','Juan Perez','basquet','2005','n');

-- Ingrese un registro con el mismo documento de socio en el mismo deporte en distintos años

insert into inscriptos values ('12222222','Juan Perez','tenis','2006','s');
insert into inscriptos values ('12222222','Juan Perez','tenis','2007','s');

-- Intente inscribir a un socio alumno en un deporte en el cual ya esté inscripto en un año en el cual 
-- ya se haya inscripto (mensaje de error)

insert into inscriptos values('12222222','Juan Perez','tenis','2006','s');

-- Intente actualizar un registro para que la clave primaria se repita (error)

update inscriptos set documento='12222222', deporte='futbol', año = '2005' where nombre='Juan Perez' and
documento='12222222' and deporte='tenis' and año = '2005';

-- Muestre los nombres y años de los inscriptos en "tenis" (5 registros)

select * from inscriptos where deporte='tenis';

-- Muestre los nombres y deportes de los inscriptos en el año 2005 (6 registros)

select nombre, deporte from inscriptos where año = '2005';

-- Muestre el deporte y año de todas las inscripciones del socio documento "12222222" (6 registros)

select deporte, año from inscriptos where documento = '12222222';

commit;
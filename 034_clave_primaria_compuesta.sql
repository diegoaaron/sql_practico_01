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















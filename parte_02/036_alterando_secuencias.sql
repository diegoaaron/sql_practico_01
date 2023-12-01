-- Es posible modificar una secuencia, su valor de incremento, los valores mínimo y máximo y el 
-- atributo "cycle" (el valor de inicio no puede modificarse); para ello empleamos la sentencia "alter sequence".

--  alter sequence NOMBRESECUENCIA ATRIBUTOSAMODIFICAR;

create sequence sec_codigolibros
    start with 1
    increment by 12
    maxvalue 999
    minvalue 1
    nocycle;
    
-- Para modificar el máximo valor a 99999 y el incremento a 2, tipeamos:

alter sequence sec_codigolibros
    increment by 2
    maxvalue 99999;
    
select sec_codigolibros.nextval from dual;

select sec_codigolibros.currval from dual;

-- Veamos la información de la secuencia modificada consultando "all_sequences":

select * from all_sequences where sequence_name = 'SEC_CODIGOLIBROS';

-- Ejercicio 1

drop table empleados;

create table empleados(
  legajo number(3),
  documento char(8) not null,
  nombre varchar2(30) not null,
  primary key(legajo)
);

drop sequence sec_legajoempleados;

create sequence sec_legajoempleados
    start with 206
    increment by 2
    maxvalue 210
    minvalue 1
    nocycle;

insert into empleados values (sec_legajoempleados.nextval,'22333444','Ana Acosta');
insert into empleados values (sec_legajoempleados.nextval,'23444555','Betina Bustamante');
insert into empleados values (sec_legajoempleados.nextval,'24555666','Carlos Caseros');

-- Recupere los registros de "empleados" para ver los valores de clave primaria.

select * from empleados;

-- Vea el valor actual de la secuencia empleando la tabla "dual"

select sec_legajoempleados.currval from dual;

-- Intente ingresar un registro empleando "nextval": (oracle muestra un mensaje de error)

insert into empleados values (sec_legajoempleados.nextval, '25666777','Diana Dominguez');

-- Altere la secuencia modificando el atributo "maxvalue" a 999.

alter sequence sec_legajoempleados
    maxvalue 999;

-- Obtenga información de la secuencia.

select * from all_sequences where sequence_name = 'SEC_LEGAJOEMPLEADOS';

-- Modifique la secuencia para que sus valores se incrementen en 1.

alter sequence sec_legajoempleados
    increment by 1;

-- Ingrese un nuevo registro:

insert into empleados values (sec_legajoempleados.nextval,'26777888','Federico Fuentes');

-- Elimine la secuencia creada.

drop sequence sec_legajoempleados;

-- Consulte todos los objetos de la base de datos que sean secuencias y verifique que "sec_legajoempleados" ya no existe.

select object_name, object_type from all_objects where object_name like '%EMPLEADOS%';


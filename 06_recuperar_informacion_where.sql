describe usuarios;

insert into usuarios (nombre, clave) values ('Marcelo','Boca');
insert into usuarios (nombre, clave) values ('Juan Perez','Juancito');
insert into usuarios (nombre, clave) values ('Susana','River');
insert into usuarios (nombre, clave) values ('Luis','River');

commit;

select * from usuarios;

select nombre, clave from usuarios where nombre = 'Marcelo';

select nombre from usuarios where clave = 'River';

select nombre from usuarios where clave = 'Santi';


-- Ejercicio 1

drop table agenda;

create table agenda(
    apellido varchar2(30),
    nombre varchar2(30),
    domicilio varchar2(30),
    telefono varchar2(11)
);

describe agenda;

insert into agenda (apellido, nombre, domicilio, telefono) values ('Acosta', 'Ana', 'Colon 123', '4234567');
insert into agenda (apellido, nombre, domicilio, telefono) values ('Bustamante', 'Benita', 'Avellaneda 135', '4887788');
insert into agenda (apellido, nombre, domicilio, telefono) values ('Lopez', 'Hector', 'Salta 545', '4887788');
insert into agenda (apellido, nombre, domicilio, telefono) values ('Lopez', 'Luis', 'Urquiza 333', '4545454');
insert into agenda (apellido, nombre, domicilio, telefono) values ('Acosta', 'Marisa', 'Urquiza 333', '4545454');

commit;

select * from agenda;

select * from agenda where nombre = 'Marisa';

select nombre, domicilio from agenda where apellido = 'Lopez';

select nombre, domicilio from agenda where apellido = 'lopez';

select nombre from agenda where telefono = '4545454';

-- Ejercicio 2 


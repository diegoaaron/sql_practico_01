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



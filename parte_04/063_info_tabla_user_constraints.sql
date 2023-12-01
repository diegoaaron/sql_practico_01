/*
El diccionario "user_constraints" devuelve mucha información referente a las restricciones, las que estudiamos son las 
siguientes columnas:

- owner: propietario de la restricción;

- constraint_name: nombre de la restricción;

- constraint_type: tipo de restricción. Si es una restricción "primary key" aparece "P", si es de control, "C", si es única, "U", 
si es una "foreign key" "R";

- table_name: nombre de la tabla sobre la cual está aplicada la restricción;

- search_condition: solamente es aplicable a restricciones de control; indica la condición de chequeo a cumplirse.

- delete_rule: solamente aplicable a restricciones "foreign key". Puede contener 3 valores: 1) "set null": indica que si 
eliminamos un registro de la tabla referenciada (TABLA2) cuyo valor existe en la tabla principal (TABLA1), dicho registro 
se elimina y los valores coincidentes en la tabla principal se seteen a "null"; 2) "cascade": indica que si eliminamos un 
registro de la tabla referenciada en una "foreign key" (TABLA2), los registros coincidentes en la tabla principal (TABLA1), 
también se eliminan; 3) "no action": indica que si se intenta eliminar un registro de la tabla referenciada por una "foreign key", 
Oracle no lo permite.

- status: indica si está habilitada (enabled) para futuras inserciones y actualizaciones o deshabilitada (disabled)

- validated: indica si valida los datos existentes en la tabla (validated) o no (no validate).
*/
/*
El catálogo "user_constraints" muestra la información referente a todas las restricciones establecidas en las tablas 
del usuario actual, devuelve varias columnas, explicaremos algunas de ellas:

- owner: propietario de la restricción

- constraints_name: el nombre de la restricción

- constraint_type: tipo de restricción. Si es una restricción de control muestra el caracter "C", 
si es "primary key" muestra "P", si es "unique" el caracter "U".

- table_name: nombre de la tabla en la cual se estableció la restricción

- search_condition: solamente es aplicable a restricciones de control; indica la condición de chequeo a cumplirse.

- status: indica si está habilitada (enabled) para futuras inserciones y actualizaciones o deshabilitada (disabled)

- validated: indica si valida los datos existentes en la tabla (validated) o no (no validate)

El catálogo "user_cons_columns" muestra la información referente a todas las restricciones establecidas en 
las tablas del usuario actual, devuelve las siguientes columnas:

- owner: propietario de la restricción;

- constraints_name: el nombre de la restricción;

- table_name: nombre de la tabla en la cual se estableció;

- column_name: muestra cada campo en el cual la restricción fue aplicada.

- position: solamente es aplicable a restricciones "primary key" y "unique"; indica el orden en que fueron definidos 
los campos que componen la clave (primaria o única).

*/

select * from user_constraints where table_name = 'LIBROS'; -- muestra las restriccione asociada a la tabla

select * from user_cons_columns where table_name = 'LIBROS'; -- muetra las restricciones asociadas a las columnas de la tabla

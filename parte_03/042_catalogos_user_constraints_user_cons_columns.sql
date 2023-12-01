/*
El cat�logo "user_constraints" muestra la informaci�n referente a todas las restricciones establecidas en las tablas 
del usuario actual, devuelve varias columnas, explicaremos algunas de ellas:

- owner: propietario de la restricci�n

- constraints_name: el nombre de la restricci�n

- constraint_type: tipo de restricci�n. Si es una restricci�n de control muestra el caracter "C", 
si es "primary key" muestra "P", si es "unique" el caracter "U".

- table_name: nombre de la tabla en la cual se estableci� la restricci�n

- search_condition: solamente es aplicable a restricciones de control; indica la condici�n de chequeo a cumplirse.

- status: indica si est� habilitada (enabled) para futuras inserciones y actualizaciones o deshabilitada (disabled)

- validated: indica si valida los datos existentes en la tabla (validated) o no (no validate)

El cat�logo "user_cons_columns" muestra la informaci�n referente a todas las restricciones establecidas en 
las tablas del usuario actual, devuelve las siguientes columnas:

- owner: propietario de la restricci�n;

- constraints_name: el nombre de la restricci�n;

- table_name: nombre de la tabla en la cual se estableci�;

- column_name: muestra cada campo en el cual la restricci�n fue aplicada.

- position: solamente es aplicable a restricciones "primary key" y "unique"; indica el orden en que fueron definidos 
los campos que componen la clave (primaria o �nica).

*/

select * from user_constraints where table_name = 'LIBROS'; -- muestra las restriccione asociada a la tabla

select * from user_cons_columns where table_name = 'LIBROS'; -- muetra las restricciones asociadas a las columnas de la tabla

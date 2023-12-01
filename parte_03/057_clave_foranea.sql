/*
Un campo que no es clave primaria en una tabla y sirve para enlazar sus valores con otra tabla en la cual es clave primaria 
se denomina clave for�nea, externa o ajena.

En el ejemplo de la librer�a en que utilizamos las tablas "libros" y "editoriales" con estos campos:

libros: codigo (clave primaria), titulo, autor, codigoeditorial, precio y editoriales: codigo (clave primaria), nombre.

el campo "codigoeditorial" de "libros" es una clave for�nea, se emplea para enlazar la tabla "libros" con "editoriales" y es 
clave primaria en "editoriales" con el nombre "codigo".

Las claves for�neas y las claves primarias deben ser del mismo tipo para poder enlazarse. Si modificamos una, debemos 
modificar la otra para que los valores se correspondan.

Cuando alteramos una tabla, debemos tener cuidado con las claves for�neas. Si modificamos el tipo, longitud o atributos de 
una clave for�nea, �sta puede quedar inhabilitada para hacer los enlaces.

Entonces, una clave for�nea es un campo (o varios) empleados para enlazar datos de 2 tablas, para establecer un "join" 
con otra tabla en la cual es clave primaria.
*/
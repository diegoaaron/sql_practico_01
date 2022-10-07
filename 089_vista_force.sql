/*
Cuando creamos una vista, Oracle verifica que las tablas a las cuales se hace referencia en ella existan. Si la vista que se 
intenta crear hace referencia a tablas inexistentes, Oracle muestra un mensaje de error.

Podemos "forzar" a Oracle a crear una vista aunque no existan los objetos (tablas, vistas, etc.) que referenciamos en la misma. 
Para ello debemos agregar "force" al crearla:

 create force view NOMBREVISTA
  as SUBCONSULTA;

De esta manera, podemos crear una vista y después las tablas involucradas; luego, al consultar la vista, DEBEN existir las tablas.

Al crear la vista la opción predeterminada es "no force". Se recomienda crear las tablas y luego las vistas necesarias.

Otra cuestión a considerar es la siguiente: si crea una vista con "select *" y luego agrega campos a la estructura de las tablas 
involucradas, los nuevos campos no aparecerán en la vista; esto es porque los campos se seleccionan al ejecutar "create view"; 
debe volver a crear la vista (con "create view" o "create or replace view").
*/

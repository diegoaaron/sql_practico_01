/*
Un procedimiento almacenado es un conjunto de instrucciones a las que se les da un nombre, se almacena en la base de 
datos activa. Permiten agrupar y organizar tareas repetitivas.

Ventajas:

- comparten la l�gica de la aplicaci�n con las otras aplicaciones, con lo cual el acceso y las modificaciones de los datos 
se hacen en un solo sitio.

- permiten realizar todas las operaciones que los usuarios necesitan evitando que tengan acceso directo a las tablas.

- reducen el tr�fico de red; en vez de enviar muchas instrucciones, los usuarios realizan operaciones enviando una �nica 
instrucci�n, lo cual disminuye el n�mero de solicitudes entre el cliente y el servidor.

Un procedimiento almacenados puede hacer referencia a objetos que no existen al momento de crearlo. Los objetos deben 
existir cuando se ejecute el procedimiento almacenado.

Desventajas:

- Las instrucciones que podemos utilizar dentro de un procedimiento almacenado no est�n preparadas para implementar 
l�gicas de negocios muy complejas.

- Son dif�ciles de depurar.
*/
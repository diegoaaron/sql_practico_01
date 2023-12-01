/*
Otros objetos de base de datos son los índices.

Los índices sirven para acceder a los registros de una tabla rápidamente, acelerando la localización de la información.

Los índices se emplean para facilitar la obtención de información de una tabla. El indice de una tabla desempeña 
la misma función que el índice de un libro: permite encontrar datos rápidamente; en el caso de las tablas, localiza registros.

Oracle accede a los datos de dos maneras:

1) recorriendo las tablas; comenzando el principio y extrayendo los registros que cumplen las condiciones de la consulta; 
lo cual implica posicionar las cabezas lectoras, leer el dato, controlar si coincide con lo que se busca (como si pasáramos 
una a una las páginas de un libro buscando un tema específico).

2) empleando índices; recorriendo la estructura de árbol del índice para localizar los registros y extrayendo los que cumplen 
las condiciones de la consulta (comparando con un libro, diremos que es como leer el índice y luego de encontrar el tema 
buscado, ir directamente a la página indicada).

Un índice posibilita el acceso directo y rápido haciendo más eficiente las búsquedas. Sin índice, Oracle debe recorrer 
secuencialmente toda la tabla para encontrar un registro.

Los índices son estructuras asociadas a tablas, una tabla que almacena los campos indexados y se crean para 
acelerar las consultas.

Entonces, el objetivo de un indice es acelerar la recuperación de información. La indexación es una técnica que 
optimiza el acceso a los datos, mejora el rendimiento acelerando las consultas y otras operaciones. 
Es útil cuando la tabla contiene miles de registros, cuando se realizan operaciones de ordenamiento y agrupamiento y 
cuando se combinan varias tablas (tema que veremos más adelante).

La desventaja es que consume espacio en el disco y genera costo de mantenimiento (tiempo y recursos).

Es importante identificar el o los campos por los que sería útil crear un índice, aquellos campos por los cuales se realizan 
búsquedas con frecuencia: claves primarias, claves externas o campos que combinan tablas.

No se recomienda crear índices sobre campos que no se usan con frecuencia en consultas o en tablas muy pequeñas.

Los cambios sobre la tabla, como inserción, actualización o eliminación de registros, son incorporados automáticamente.

Cuando creamos una restricción "primary key" o "unique" a una tabla, Oracle automáticamente crea un índice sobre 
el campo (o los campos) de la restricción y le da el mismo nombre que la restricción. En caso que la tabla ya tenga 
un índice, Oracle lo usa, no crea otro.

Oracle permite crear distintos tipos de índices. "Normal" es el standard de Oracle, son índices tipo árbol binario; 
contiene una entrada por cada valor de clave que almacena la dirección donde se encuentra el dato. 
Es el tipo predeterminado y el más común (el único que estudiaremos).
*/
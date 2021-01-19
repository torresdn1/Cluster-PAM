# Cluster - PAM
 Este repositorio contiene un ejercicio de clustering a través del método Partitioning Around Medoids (PAM). El ejercicio busca responder, ¿cuáles sitios dentro del territorio mexicano son los más adecuados para establecer almacenes para la atención de emergencias?. A través del método k-medoides, establezco una muy elemental respuesta. 

El método de PAM es un algoritmo de agrupamiento que divide un conjunto de datos en un número K de clusters y medoides (definidos arbitrariamente: para este ejercicio fueron definidos 25 clusters) según las disimilitudes que presentan cada una de las observaciones.

Un medoide puede definirse como el dato dentro del grupo cuya disimilaridad media a todos los objetos en el grupo es mínima o como el punto ubicado más al centro de cada uno de los clusters. La clasificación fue realizada con base en una matriz de datos compuesta por la latitud y la longitud de los centroides de cada municipio. 

Estos datos fueron obtenidos a partir de las herramientas de la paquetería `sf` y `cluster` de R. 

![mapa_medoids](https://user-images.githubusercontent.com/47362216/104989234-9bb76a80-59df-11eb-89c5-09b50728ca76.png)

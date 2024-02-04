CREATE TABLE usuarios (id SERIAL,email VARCHAR(20), nombre VARCHAR(30), apellido VARCHAR(30), rol VARCHAR(20)); 
INSERT INTO usuarios (email,nombre, apellido,rol) VALUES('juan@mail.com','Juan','Martinez','administrador');
INSERT INTO usuarios (email,nombre, apellido, rol) VALUES ('margarita@mail.com','Margarita','Gomez','administrador');
INSERT INTO usuarios (email,nombre, apellido, rol) VALUES ('alicia@mail.com','Alicia','Espinosa','usuario');
INSERT INTO usuarios (email,nombre, apellido, rol) VALUES ('bruno@mail.com','Bruno','Fuentes','usuario');
INSERT INTO usuarios (email,nombre, apellido, rol) VALUES ('carmen@mail.com','Carmen','Sandiego','usuario');

CREATE TABLE posts (id SERIAL, titulo VARCHAR(100),contenido text,fecha_creacion TIMESTAMP,fecha_actualizacion TIMESTAMP,destacado BOOLEAN, usuario_id BIGINT);
INSERT INTO posts (titulo, contenido,fecha_creacion,fecha_actualizacion,destacado,usuario_id)VALUES('Estreno en cines de Poor Things','Se ha estrenado en cines la nueva película protagonizada por Emma Stone, Poor Things, que ha tenido un 93% de aprobación según Rotten Tomatos',NOW() - INTERVAL '10 days', NULL,TRUE,1);
INSERT INTO posts (titulo, contenido,fecha_creacion,fecha_actualizacion,destacado,usuario_id)VALUES('Altas temperaturas en la RM','Se han registrado las más altas temperaturas en 20 años en la Región Metropolitana donde se ha alcazado la máxima de 37 grados Celsius',NOW() - INTERVAL '7 days', NULL,TRUE,1);
INSERT INTO posts (titulo, contenido,fecha_creacion,fecha_actualizacion,destacado,usuario_id)VALUES('Actividades en Vacaciones','En el centro cultural Gabriela Mistral se están realizando talleres artísticos y de lectura para niños durante este verano',NOW()  - INTERVAL '15 days', NULL,TRUE,3);
INSERT INTO posts (titulo, contenido,fecha_creacion,fecha_actualizacion,destacado,usuario_id)VALUES('Alimentación Saludable','Sabías que las legumbres con carbohidratos de bajo índice glicémico y que por lo tanto mantienes tus niveles de azucar en la sangre más estables',NOW() - INTERVAL '15 days', NULL,TRUE,4);
INSERT INTO posts (titulo, contenido,fecha_creacion,fecha_actualizacion,destacado,usuario_id)VALUES('Iron Maiden en Chile','Iron Maiden estará en Chile durante Noviembre de este año',NOW()- INTERVAL '15 days', NULL,TRUE,NULL);

CREATE TABLE comentarios(id SERIAL, contenido TEXT, fecha_creacion TIMESTAMP, usuario_id BIGINT, post_id BIGINT);
INSERT INTO comentarios (contenido, fecha_creacion,usuario_id,post_id)VALUES('Me gustaría verla',NOW()- INTERVAL '7 days',1,1);
INSERT INTO comentarios (contenido, fecha_creacion,usuario_id,post_id)VALUES('Parece chistosa',NOW()- INTERVAL '5 days',2,1);
INSERT INTO comentarios (contenido, fecha_creacion,usuario_id,post_id)VALUES('Me recuerda a Frankenstein',NOW(),3,1);
INSERT INTO comentarios (contenido, fecha_creacion,usuario_id,post_id)VALUES('Vamos a la playa oh oh',NOW() - INTERVAL '2 days',1,2);
INSERT INTO comentarios (contenido, fecha_creacion,usuario_id,post_id)VALUES('Me gusta, o a la piscina',NOW()- INTERVAL '1 days',2,2);

SELECT usuarios.nombre, usuarios.email, posts.titulo, posts.contenido FROM  usuarios
INNER JOIN posts ON usuarios.id=posts.usuario_id;

SELECT posts.id, posts.titulo, posts.contenido FROM  usuarios
INNER JOIN posts ON usuarios.id=posts.usuario_id WHERE usuarios.rol='administrador';

SELECT usuarios.id, usuarios.email, COUNT(posts.*) as cantidadPosts FROM  usuarios
LEFT JOIN posts ON usuarios.id=posts.usuario_id GROUP BY usuarios.id, usuarios.email;

SELECT usuarios.id, usuarios.email, COUNT(posts.*) as cantidadPosts FROM  usuarios
LEFT JOIN posts ON usuarios.id=posts.usuario_id GROUP BY usuarios.id, usuarios.email ORDER BY COUNT(posts.*) DESC LIMIT 1;

--falta la del max

SELECT usuarios.id, MAX(posts.fecha_creacion) as fechaPosts FROM  usuarios
LEFT JOIN posts ON usuarios.id=posts.usuario_id GROUP BY usuarios.id;

SELECT  posts.titulo, posts.contenido, COUNT(comentarios.*) FROM  posts
LEFT JOIN comentarios ON posts.id=comentarios.post_id GROUP BY posts.id,posts.titulo, posts.contenido ORDER BY COUNT(comentarios.*) DESC LIMIT 1;

SELECT  posts.titulo, posts.contenido, comentarios.contenido, usuarios.email FROM  posts
INNER JOIN comentarios ON posts.id=comentarios.post_id
INNER JOIN usuarios ON usuarios.id=posts.usuario_id; 

SELECT  usuarios.email, COUNT(comentarios.*) FROM  usuarios
LEFT JOIN comentarios ON usuarios.id=comentarios.usuario_id GROUP BY usuarios.email  HAVING COUNT(comentarios.*)=0 ;


SELECT t.id, comentarios.contenido FROM
(SELECT usuarios.id AS id, MAX(comentarios.fecha_creacion) AS fecha  FROM  usuarios
INNER JOIN comentarios ON usuarios.id=comentarios.usuario_id GROUP BY usuarios.id)
t INNER JOIN comentarios ON t.fecha=comentarios.fecha_creacion AND t.id=comentarios.usuario_id;






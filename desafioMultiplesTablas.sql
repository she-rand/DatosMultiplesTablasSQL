CREATE DATABASE desafio_liliana_zurita_123;

CREATE TABLE usuarios (id SERIAL,email VARCHAR(20), nombre VARCHAR(30), apellido VARCHAR(30), rol VARCHAR(20)); 
INSERT INTO usuarios (email,nombre, apellido,rol) VALUES('juan@mail.com','Juan','Martinez','administrador');
INSERT INTO usuarios (email,nombre, apellido, rol) VALUES ('margarita@mail.com','Margarita','Gomez','administrador');
INSERT INTO usuarios (email,nombre, apellido, rol) VALUES ('alicia@mail.com','Alicia','Espinosa','usuario');
INSERT INTO usuarios (email,nombre, apellido, rol) VALUES ('bruno@mail.com','Bruno','Fuentes','usuario');
INSERT INTO usuarios (email,nombre, apellido, rol) VALUES ('carmen@mail.com','Carmen','Sandiego','usuario');

CREATE TABLE posts (id SERIAL, titulo VARCHAR(100),contenido text,fecha_creacion TIMESTAMP,fecha_actualizacion TIMESTAMP,destacado BOOLEAN, usuario_id BIGINT);
INSERT INTO posts (titulo, contenido,fecha_creacion,fecha_actualizacion,destacado,usuario_id)VALUES('Estreno en cines de Poor Things','Se ha estrenado en cines la nueva película protagonizada por Emma Stone, Poor Things, que ha tenido un 93% de aprobación según Rotten Tomatos',NOW() - INTERVAL '10 days', NOW() - INTERVAL '9 days',TRUE,1);
INSERT INTO posts (titulo, contenido,fecha_creacion,fecha_actualizacion,destacado,usuario_id)VALUES('Altas temperaturas en la RM','Se han registrado las más altas temperaturas en 20 años en la Región Metropolitana donde se ha alcazado la máxima de 37 grados Celsius',NOW() - INTERVAL '7 days', NULL,TRUE,1);
INSERT INTO posts (titulo, contenido,fecha_creacion,fecha_actualizacion,destacado,usuario_id)VALUES('Actividades en Vacaciones','En el centro cultural Gabriela Mistral se están realizando talleres artísticos y de lectura para niños durante este verano',NOW()  - INTERVAL '15 days', NOW() - INTERVAL '13 days',TRUE,3);
INSERT INTO posts (titulo, contenido,fecha_creacion,fecha_actualizacion,destacado,usuario_id)VALUES('Alimentación Saludable','Sabías que las legumbres con carbohidratos de bajo índice glicémico y que por lo tanto mantienes tus niveles de azucar en la sangre más estables',NOW() - INTERVAL '15 days', NOW() - INTERVAL '13 days',TRUE,4);
INSERT INTO posts (titulo, contenido,fecha_creacion,fecha_actualizacion,destacado,usuario_id)VALUES('Iron Maiden en Chile','Iron Maiden estará en Chile durante Noviembre de este año',NOW()- INTERVAL '15 days', NULL,TRUE,NULL);

CREATE TABLE comentarios(id SERIAL, contenido TEXT, fecha_creacion TIMESTAMP, usuario_id BIGINT, post_id BIGINT);
INSERT INTO comentarios (contenido, fecha_creacion,usuario_id,post_id)VALUES('Me gustaría verla',NOW()- INTERVAL '7 days',1,1);
INSERT INTO comentarios (contenido, fecha_creacion,usuario_id,post_id)VALUES('Parece chistosa',NOW()- INTERVAL '5 days',2,1);
INSERT INTO comentarios (contenido, fecha_creacion,usuario_id,post_id)VALUES('Me recuerda a Frankenstein',NOW(),3,1);
INSERT INTO comentarios (contenido, fecha_creacion,usuario_id,post_id)VALUES('Vamos a la playa oh oh',NOW() - INTERVAL '2 days',1,2);
INSERT INTO comentarios (contenido, fecha_creacion,usuario_id,post_id)VALUES('Me gusta, o a la piscina',NOW()- INTERVAL '1 days',2,2);

-- 2. Cruza los datos de la tabla usuarios y posts, mostrando :nombre y email del usuario junto al título y contenido del post
SELECT usuarios.nombre, usuarios.email, posts.titulo, posts.contenido FROM  usuarios
INNER JOIN posts ON usuarios.id=posts.usuario_id;

--3. Muestra el id, título y contenido de los posts de los administradores.
SELECT posts.id, posts.titulo, posts.contenido FROM  usuarios
INNER JOIN posts ON usuarios.id=posts.usuario_id WHERE usuarios.rol='administrador';

--4. Cuenta la cantidad de posts de cada usuario. 
--La tabla resultante debe mostrar el id e email del usuario junto con la cantidad de posts de cada usuario
SELECT usuarios.id AS idUsuarios, usuarios.email, COUNT(posts.*) AS cantidadPosts FROM  usuarios
LEFT JOIN posts ON usuarios.id=posts.usuario_id GROUP BY usuarios.id, usuarios.email;

--5 Muestra el email del usuario que ha creado más posts.
SELECT usuarios.id, usuarios.email, COUNT(posts.*) as cantidadPosts FROM  usuarios
LEFT JOIN posts ON usuarios.id=posts.usuario_id GROUP BY usuarios.id, usuarios.email ORDER BY COUNT(posts.*) DESC LIMIT 1;

--6 Muestra la fecha del último post de cada usuario.
SELECT usuarios.id AS idUsuarios, MAX(posts.fecha_creacion) as fechaPosts FROM  usuarios
LEFT JOIN posts ON usuarios.id=posts.usuario_id GROUP BY usuarios.id;

--7 Muestra el título y contenido del post (artículo) con más comentarios
SELECT  posts.titulo, posts.contenido, COUNT(comentarios.*) FROM  posts
LEFT JOIN comentarios ON posts.id=comentarios.post_id GROUP BY posts.id,posts.titulo, posts.contenido ORDER BY COUNT(comentarios.*) DESC LIMIT 1;

--8 Muestra en una tabla el título de cada post, el contenido de cada post y el contenido
--de cada comentario asociado a los posts mostrados, junto con el email del usuario que lo escribió.
SELECT  posts.titulo, posts.contenido, comentarios.contenido, usuarios.email FROM  posts
INNER JOIN comentarios ON posts.id=comentarios.post_id
INNER JOIN usuarios ON usuarios.id=comentarios.usuario_id; 


--9 Muestra el contenido del último comentario de cada usuario.
SELECT t.id AS idUsuarios, comentarios.contenido FROM
(SELECT usuarios.id AS id, MAX(comentarios.fecha_creacion) AS fecha  FROM  usuarios
LEFT JOIN comentarios ON usuarios.id=comentarios.usuario_id GROUP BY usuarios.id)
t LEFT JOIN comentarios ON t.fecha=comentarios.fecha_creacion AND t.id=comentarios.usuario_id;

--10 Muestra los emails de los usuarios que no han escrito ningún comentario
SELECT  usuarios.email, COUNT(comentarios.*) FROM  usuarios
LEFT JOIN comentarios ON usuarios.id=comentarios.usuario_id GROUP BY usuarios.email  HAVING COUNT(comentarios.*)=0 ;







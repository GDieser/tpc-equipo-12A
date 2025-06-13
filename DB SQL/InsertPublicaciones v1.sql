
USE TPC_CURSOS_G12A

GO



--Insert Para categoria

INSERT INTO Categoria (Nombre) VALUES('Base de Datos');

INSERT INTO Categoria (Nombre) VALUES('Programaci�n');

INSERT INTO Categoria (Nombre) VALUES('Tecnolog�a');

INSERT INTO Categoria (Nombre) VALUES('Promoci�n');



--Publicacion

INSERT INTO Publicacion(IdCategoria, Titulo, Descripcion, Resumen, FechaCreacion, FechaPublicacion, Estado)
VALUES(3, 'Sam Altman afirma que el consumo de agua y energ�a de ChatGPT es �nfimo.', 

'<ul><li><p>En un reciente art�culo en su blog, el CEO de OpenAI vuelve a aumentar las expectativas sobre la IA</p></li><li><p>Y trata de desmentir el mito de que usar IA tiene un alto coste en energ�a y agua</p></li></ul><p>Un email de 100 palabras generado por GPT-4&nbsp;<a href="https://www.xataka.com/robotica-e-ia/sabemos-sedienta-que-esta-inteligencia-artificial-email-100-palabras-consume-botellita-agua">consume 519 mililitros de agua</a>. Esa fue la conclusi�n a la que investigadores de la Universidad de California llegaron hace pocos meses tras analizar este modelo de OpenAI. Sam Altman, CEO de la compa��a, acaba de arrojar su propia estimaci�n sobre el consumo de agua y energ�a de cada consulta de&nbsp;<a href="https://www.xataka.com/basics/chatgpt-que-como-usarlo-que-puedes-hacer-este-chat-inteligencia-artificial">ChatGPT</a>. Y es muy distinta.</p>', 

'En un reciente art�culo en su blog, el CEO de OpenAI vuelve a aumentar las expectativas sobre la IA.',
GETDATE(), GETDATE(), 1);

INSERT INTO Imagen(UrlImagen, Nombre, IdTipoImagen) values('https://marketing4ecommerce.net/wp-content/uploads/2023/11/historia-OpenAI.jpg', 'Miniatura', 1)

INSERT INTO ImagenPublicacion(IdImagen, IdPublicacion) VALUES (1, 1)

INSERT INTO Imagen(UrlImagen, Nombre, IdTipoImagen) values('https://i.blogs.es/991a31/sam-energia/1200_800.jpeg', 'Banner', 1)

INSERT INTO ImagenPublicacion(IdImagen, IdPublicacion) VALUES (2, 1)


INSERT INTO Publicacion(IdCategoria, Titulo, Descripcion, Resumen, FechaCreacion, FechaPublicacion, Estado)
VALUES(3, 'Meta est� tan desesperada.',

'<p><strong>Meta est� ofreciendo "hasta nueve cifras" por investigador para crear un laboratorio de superinteligencia que le permita recuperar terreno en la carrera de la IA.</strong></p>  <ul>  <li>Meta est� ofreciendo sueldos de entre 10 y 100 millones de d�lares a investigadores estrella de OpenAI, Google y otras empresas para contratar a 50 expertos que lideren su nuevo laboratorio de superinteligencia, ese por el que&nbsp;<a href="https://www.xataka.com/robotica-e-ia/zuckerberg-esta-desesperado-avance-ia-meta-asi-que-entrado-founder-mode">Zuckerberg ha entrado en "<em>founder mode" </em></a><em>,&nbsp;</em>seg�n lo publicado por&nbsp;<a href="https://www.nytimes.com/2025/06/10/technology/meta-new-ai-lab-superintelligence.html"><em>The New York Times</em></a>.</li> </ul>  <p>&nbsp;</p>  <ul>  <li><strong>Por qu� es importante</strong>. La empresa de Zuckerberg ha perdido terreno en la carrera de la IA tras&nbsp;<a href="https://www.xataka.com/robotica-e-ia/zuckerberg-dio-luz-verde-al-uso-libros-pirateados-para-entrenar-su-modelo-ia-llama">algunos tropiezos</a>&nbsp;con sus modelos Llama y la fuga de talento clave, incluyendo a la directora de investigaci�n de IA Joelle Pineau,&nbsp;<a href="https://www.xataka.com/robotica-e-ia/hablan-directivos-meta-ai-conocimiento-no-puede-ser-controlado-unas-pocas-empresas-costa-oeste-eeuu-china">a quien pudimos entrevistar hace un a�o</a>.</li> </ul>  <p><br> <em>German Dieser - MisCusros.com.</em></p>',

'Meta est� ofreciendo "hasta nueve cifras" por investigador para crear un laboratorio de superinteligencia que le permita recuperar terreno en la carrera de la IA.', 
GETDATE(), GETDATE(), 1);

INSERT INTO Imagen(UrlImagen, Nombre, IdTipoImagen) values('https://s.france24.com/media/display/4f75ee54-3845-11ec-a0aa-005056bf30b7/w:1280/p:16x9/2021-10-28T193057Z_1249183049_RC27JQ9J01QC_RTRMADP_3_FACEBOOK-CONNECT.jpg', 'Miniatura', 1)

INSERT INTO ImagenPublicacion(IdImagen, IdPublicacion) VALUES (3, 2)

INSERT INTO Imagen(UrlImagen, Nombre, IdTipoImagen) values('https://i.blogs.es/cf4901/solen-feyissa-unsplash/1200_800.jpeg', 'Miniatura', 1)

INSERT INTO ImagenPublicacion(IdImagen, IdPublicacion) VALUES (4, 2)


--Insert FAQs

INSERT INTO PreguntasFrecuentes VALUES ('�Qui�nes somos?','Somos TusCursos.com, un grupo de profesionales apacionados por la tecnolog�a y la educaci�n. Podes ver todas nuestras redes y enterarte de lo �ltimo en el mundo IT.');

INSERT INTO PreguntasFrecuentes VALUES ('�C�mo compro un curso?','Primero deb�s registrarte! Una vez que tengas t� cuenta, eleg� el curso que m�s te gusta, agregalo al carrito y efectua la compra. Una vez acreditado se te dar� acceso al Campus Virtual, d�nde podr�s realizar el curso. ');

INSERT INTO PreguntasFrecuentes VALUES ('�C�mo me uno?','Pod�s darle al bot�n de "Login" arriba a la derecha y ah� mismo resgistrare, completando tus datos y confirmando tu usuario.');

INSERT INTO PreguntasFrecuentes VALUES ('�C�mo accedo al contenido del Curso?', 'Una vez tengas tu cuenta verificada y hayas comprado tu curso podes ir a la parte que dice "Mis Cursos" y ah� podras acceder a todo el contenido de los cursos.');

INSERT INTO PreguntasFrecuentes VALUES ('�Cu�les son los m�todos de pago?','Pod�s realizar los pagos atravez de Mercado Pago para mayor seguridad, ah� mismo pod�s elegir dinero en cuenta o tarjeta.');

INSERT INTO PreguntasFrecuentes VALUES ('�Cuanto duran los cursos?','En realidad, eso depende de cada curso, podes hacerlo a tu ritmo, una vez que lo compras podes acceder a ellos para siempre.');

--Insert Usuarios

INSERT INTO Cursos (Titulo, Resumen, Descripcion, ImagenUrl)
VALUES 
('Programaci�n 1', 'Aprend� programaci�n desde cero.', 'Este curso te ense�a los fundamentos de programaci�n usando C#.', 'https://www.aprender21.com/images/colaboradores/sql.jpeg'),
('Bases de Datos', 'Dise�� y consult� bases de datos.', 'Aprend� SQL y c�mo estructurar bases de datos relacionales.', 'https://www.aprender21.com/images/colaboradores/sql.jpeg'),
('Desarrollo Web', 'Cre� sitios modernos.', 'HTML, CSS, JavaScript y Bootstrap para el desarrollo frontend.', 'https://www.aprender21.com/images/colaboradores/sql.jpeg');



--Insert Usuarios

select * from Usuario
update Usuario set IdRol=0 Where IdUsuario=1;

insert into imagen(UrlImagen, Nombre, IdTipoImagen) values
('https://preview.redd.it/some-random-faces-of-homer-v0-mia0xhbii85f1.jpg?width=504&format=pjpg&auto=webp&s=c1cbc9eca8b67b1c11ece2ee46c19c1abce68b45','Foto perfil',0)

INSERT INTO Usuario (Nombre, Apellido, Email, IdRol, Celular, FechaNacimiento, NombreUsuario, FechaRegistro, Pass, Habilitado, EmailValidado, RecuperoContrasenia, TokenValidacion, FotoPerfil)
VALUES 
('Lucas', 'Gonz�lez', 'lucas1@mail.com', 1, '1160000001', '1990-01-05', 'lucasg1', GETDATE(), '8f3a4f367aa8c56bf270e843168142331a873646719cd259643958b37fb8a753', 1, 1, 1, NULL, 2),
('Martina', 'P�rez', 'martina2@mail.com', 1, '1160000002', '1992-03-12', 'martip2', GETDATE(), '8f3a4f367aa8c56bf270e843168142331a873646719cd259643958b37fb8a753', 1, 1, 1, NULL, 2),
('Juli�n', 'Fern�ndez', 'julian3@mail.com', 1, '1160000003', '1988-07-20', 'julif3', GETDATE(), '8f3a4f367aa8c56bf270e843168142331a873646719cd259643958b37fb8a753', 1, 1, 1, NULL, 2),
('Sof�a', 'Ram�rez', 'sofia4@mail.com', 1, '1160000004', '1995-09-30', 'sofiar4', GETDATE(), '8f3a4f367aa8c56bf270e843168142331a873646719cd259643958b37fb8a753', 1, 1, 1, NULL, 2),
('Tom�s', 'D�az', 'tomas5@mail.com', 1, '1160000005', '1993-11-14', 'tomasd5', GETDATE(), '8f3a4f367aa8c56bf270e843168142331a873646719cd259643958b37fb8a753', 1, 1, 1, NULL, 2),
('Valentina', 'L�pez', 'valen6@mail.com', 1, '1160000006', '1991-04-18', 'valel6', GETDATE(), '8f3a4f367aa8c56bf270e843168142331a873646719cd259643958b37fb8a753', 1, 1, 1, NULL, 2),
('Agust�n', 'Mart�nez', 'agustin7@mail.com', 1, '1160000007', '1987-06-09', 'agusm7', GETDATE(), '8f3a4f367aa8c56bf270e843168142331a873646719cd259643958b37fb8a753', 1, 1, 1, NULL, 2),
('Camila', 'S�nchez', 'camila8@mail.com', 1, '1160000008', '1994-08-23', 'camilas8', GETDATE(), '8f3a4f367aa8c56bf270e843168142331a873646719cd259643958b37fb8a753', 1, 1, 1, NULL, 2),
('Mateo', 'Torres', 'mateo9@mail.com', 1, '1160000009', '1996-02-02', 'mateot9', GETDATE(), '8f3a4f367aa8c56bf270e843168142331a873646719cd259643958b37fb8a753', 1, 1, 1, NULL, 2),
('Florencia', 'Moreno', 'flor10@mail.com', 1, '1160000010', '1990-10-10', 'florm10', GETDATE(), '8f3a4f367aa8c56bf270e843168142331a873646719cd259643958b37fb8a753', 1, 1, 1, NULL, 2);

update Usuario set IdRol = 0 Where IdUsuario=3;

select * from Componente

update Componente set Contenido='https://i0.wp.com/achirou.com/wp-content/uploads/2024/03/Alvaro_Chirou_Introduccion-a-la-programacion.jpg?fit=1600%2C900&ssl=1' where IdComponente=8


---Ejemplos de cursos (ver Id de imagen y de curso OJO)

INSERT INTO Curso VALUES (1, 1, 'Curso de Base de Datos', 'Ac� vas a lalalalalal', 'Todo lo que necesitas saber del mundo de las BD SQL', 599, GETDATE(), GETDATE(), 99, 1);

INSERT INTO Imagen VALUES ('https://licendi.com/media/wysiwyg/sql_2025.jpg', 'Miniatura', 1);

--INSERT INTO ImagenCurso VALUES (17, 1);


INSERT INTO Curso VALUES (2, 1, 'Curso de Programacion Basica', 'Ac� vas a lalalalalal', 'Todo lo que necesitas saber del mundo de programacion y mas', 599, GETDATE(), GETDATE(), 99, 1);

INSERT INTO Imagen VALUES ('https://beecrowd.com/wp-content/uploads/2024/04/2022-07-19-Melhores-cursos-de-Python.jpg', 'Miniatura', 1);

--INSERT INTO ImagenCurso VALUES (18, 2);


INSERT INTO Curso VALUES (3, 1, 'Curso de IAs', 'Ac� vas a lalalalalal', 'Todo lo que necesitas saber del mundo de IAs generativas', 599, GETDATE(), GETDATE(), 99, 1);

INSERT INTO Imagen VALUES ('https://eu-images.contentstack.com/v3/assets/blt6d90778a997de1cd/blt5b95180e6b4674b8/64f156de90b8a54284e7f61e/chatGPT_Greg_guy_Alamy.jpg', 'Miniatura', 1);

--INSERT INTO ImagenCurso VALUES (19, 3);

INSERT INTO Curso VALUES (3, 1, 'Curso de APIs', 'Ac� vas a lalalalalal', 'Todo lo que necesitas saber del mundo de APIs Web', 599, GETDATE(), GETDATE(), 99, 1);

INSERT INTO Imagen VALUES ('https://admin.finanty.com/assets/noticias/API-WEB-01.jpg', 'Miniatura', 1);

--INSERT INTO ImagenCurso VALUES (20, 4);
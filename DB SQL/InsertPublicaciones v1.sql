
--Insert PAra categoria

INSERT INTO Categoria (Nombre) VALUES('Base de Datos');

INSERT INTO Categoria (Nombre) VALUES('Programaci�n');

INSERT INTO Categoria (Nombre) VALUES('Tecnolog�a');

INSERT INTO Categoria (Nombre) VALUES('Promoci�n');

--Insert Imagen

INSERT INTO Imagen(UrlImagen, Nombre, IdTipoImagen) VALUES ('https://hermes.dio.me/articles/cover/f54fb5c2-a04f-4ee5-aaf2-14fd4336fbc1.png', '', 1);

INSERT INTO Imagen(UrlImagen, Nombre, IdTipoImagen) VALUES ('https://i.ytimg.com/vi/H9hYwX8bE_I/sddefault.jpg', '', 1);

--Insert para Publicacion

INSERT INTO Publicacion(IdCategoria, IdImagen, Titulo, Descripcion, Resumen, FechaCreacion, FechaPublicacion, Estado)
VALUES(3, 1, 'Git y GitHub, todo lo que necesitas saber', 
'Git es una de las tecnolog�as m�s influyentes en el mundo del desarrollo de software en los �ltimos 20 a�os. Su forma de trabajar ha revolucionado los flujos de trabajo en las organizaciones y hoy en d�a est� tan ampliamente implantado en el sector que muchas empresas simplemente asumen que sabes Git. Con este curso podr�s adquirir o poner al d�a tu conocimiento sobre Git para saber c�mo desempe�arte con esta herramienta que, si bien promete ser f�cil, a veces presenta retos.

Por otra parte, la facilidad con la que GitHub permite compartir software con el mundo en la forja de c�digo m�s utilizada en este momento ha conseguido colocar a esta aplicaci�n web como una de las formas favoritas de mucha gente de publicar software de c�digo abierto, comunicar sus capacidades a reclutadores y entrevistadores cuando se busca empleo, y tambi�n moverse en el d�a a d�a una vez ya se tiene uno, tanto que muchos equipos de trabajo tambi�n lo utilizan en su d�a a d�a para realizar sus actividades.

En nuestros cursos podr�s obtener lo que necesitas conocer sobre Git y sobre GitHub utilizando una manera de ense�ar cercana y que te proporcionar� conocimientos �tiles que podr�s aprovechar en tu d�a a d�a para mejorar como desarrollador, optar a puestos de trabajo, o moverte correctamente una vez tienes uno.', 
'Aprende Git y GitHub de forma completa y desde cero. Con ejemplos pr�cticos. S� un profesional del control de versiones.',
GETDATE(), GETDATE(), 1);

INSERT INTO Publicacion(IdCategoria, IdImagen, Titulo, Descripcion, Resumen, FechaCreacion, FechaPublicacion, Estado)
VALUES(1, 2, 'Base de Datos SQL', 
'Una base de datos es un conjunto de datos almacenados. Un Sistema de Gesti�n de Bases de Datos (o SGBD), es un conjunto de programas, 
herramientas y lenguajes que proporcionan los elementos necesarios para operar con los datos. Todo sistema requiere un soporte de datos 
adecuado, que se implementa, principalmente, utilizando bases de datos transaccionales. El entendimiento del funcionamiento de las bases de 
datos y c�mo los datos est�n organizados en ellas, es indispensable en cualquier lenguaje de programaci�n. Ya sea se trate de conocer los 
principios de modelado de datos, las bases funcionales de las consultas del lenguaje SQL o, simplemente, para complementar los conocimientos 
de Desarrollo de Software, el curso de Fundamentos de las bases de datos, resulta de inter�s fundacional para cualquier profesional que est� 
en proceso de formaci�n de sus habilidades y conocimientos.',
'Conoc� lo necesario para operar bases de datos. Uso de tablas, integridad y tipos de datos, aplicaci�n en SQL, funciones de base, Self Join',
GETDATE(), GETDATE(), 1);

--Insert Imagen Publicacion

INSERT INTO ImagenPublicacion(IdImagen, IDPublicacion) VALUES (1, 1);

INSERT INTO ImagenPublicacion(IdImagen, IDPublicacion) VALUES (2, 2);


INSERT INTO Cursos (Titulo, Resumen, Descripcion, ImagenUrl)
VALUES 
('Programaci�n 1', 'Aprend� programaci�n desde cero.', 'Este curso te ense�a los fundamentos de programaci�n usando C#.', 'https://www.aprender21.com/images/colaboradores/sql.jpeg'),
('Bases de Datos', 'Dise�� y consult� bases de datos.', 'Aprend� SQL y c�mo estructurar bases de datos relacionales.', 'https://www.aprender21.com/images/colaboradores/sql.jpeg'),
('Desarrollo Web', 'Cre� sitios modernos.', 'HTML, CSS, JavaScript y Bootstrap para el desarrollo frontend.', 'https://www.aprender21.com/images/colaboradores/sql.jpeg');


-- Usuario Estudiante
INSERT INTO Usuario (
    Nombre, Apellido, Email, IdRol, Celular, IdUsuarioMoodle,
    FechaNacimiento, NombreUsuario, Pass, Habilitado, FotoPerfil
)
VALUES (
    'Juan', 'P�rez', 'juan.perez@example.com', 0, '1155551234', 10123,
    '2000-05-12', 'juanp', 'b20b0f63ce2ed361e8845d6bf2e59811aaa06ec96bcdb92f9bc0c5a25e83c9a6', 1, NULL
);

-- Usuario Administrador
INSERT INTO Usuario (
    Nombre, Apellido, Email, IdRol, Celular, IdUsuarioMoodle,
    FechaNacimiento, NombreUsuario, Pass, Habilitado, FotoPerfil
)
VALUES (
    'Ana', 'G�mez', 'ana.gomez@example.com', 1, '1166665678', 10124,
    '1985-09-27', 'anag', 'b45513fe304c65eb8a8fede7855c766223895d895457f1d5c3080f1cfea517b2', 1, NULL
);
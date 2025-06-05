
--Insert PAra categoria

INSERT INTO Categoria (Nombre) VALUES('Base de Datos');

INSERT INTO Categoria (Nombre) VALUES('Programación');

INSERT INTO Categoria (Nombre) VALUES('Tecnología');

INSERT INTO Categoria (Nombre) VALUES('Promoción');

--Insert Imagen

INSERT INTO Imagen(UrlImagen, Nombre, IdTipoImagen) VALUES ('https://hermes.dio.me/articles/cover/f54fb5c2-a04f-4ee5-aaf2-14fd4336fbc1.png', '', 1);

INSERT INTO Imagen(UrlImagen, Nombre, IdTipoImagen) VALUES ('https://i.ytimg.com/vi/H9hYwX8bE_I/sddefault.jpg', '', 1);

--Insert para Publicacion

INSERT INTO Publicacion(IdCategoria, IdImagen, Titulo, Descripcion, Resumen, FechaCreacion, FechaPublicacion, Estado)
VALUES(3, 1, 'Git y GitHub, todo lo que necesitas saber', 
'Git es una de las tecnologías más influyentes en el mundo del desarrollo de software en los últimos 20 años. Su forma de trabajar ha revolucionado los flujos de trabajo en las organizaciones y hoy en día está tan ampliamente implantado en el sector que muchas empresas simplemente asumen que sabes Git. Con este curso podrás adquirir o poner al día tu conocimiento sobre Git para saber cómo desempeñarte con esta herramienta que, si bien promete ser fácil, a veces presenta retos.

Por otra parte, la facilidad con la que GitHub permite compartir software con el mundo en la forja de código más utilizada en este momento ha conseguido colocar a esta aplicación web como una de las formas favoritas de mucha gente de publicar software de código abierto, comunicar sus capacidades a reclutadores y entrevistadores cuando se busca empleo, y también moverse en el día a día una vez ya se tiene uno, tanto que muchos equipos de trabajo también lo utilizan en su día a día para realizar sus actividades.

En nuestros cursos podrás obtener lo que necesitas conocer sobre Git y sobre GitHub utilizando una manera de enseñar cercana y que te proporcionará conocimientos útiles que podrás aprovechar en tu día a día para mejorar como desarrollador, optar a puestos de trabajo, o moverte correctamente una vez tienes uno.', 
'Aprende Git y GitHub de forma completa y desde cero. Con ejemplos prácticos. Sé un profesional del control de versiones.',
GETDATE(), GETDATE(), 1);

INSERT INTO Publicacion(IdCategoria, IdImagen, Titulo, Descripcion, Resumen, FechaCreacion, FechaPublicacion, Estado)
VALUES(1, 2, 'Base de Datos SQL', 
'Una base de datos es un conjunto de datos almacenados. Un Sistema de Gestión de Bases de Datos (o SGBD), es un conjunto de programas, 
herramientas y lenguajes que proporcionan los elementos necesarios para operar con los datos. Todo sistema requiere un soporte de datos 
adecuado, que se implementa, principalmente, utilizando bases de datos transaccionales. El entendimiento del funcionamiento de las bases de 
datos y cómo los datos están organizados en ellas, es indispensable en cualquier lenguaje de programación. Ya sea se trate de conocer los 
principios de modelado de datos, las bases funcionales de las consultas del lenguaje SQL o, simplemente, para complementar los conocimientos 
de Desarrollo de Software, el curso de Fundamentos de las bases de datos, resulta de interés fundacional para cualquier profesional que esté 
en proceso de formación de sus habilidades y conocimientos.',
'Conocé lo necesario para operar bases de datos. Uso de tablas, integridad y tipos de datos, aplicación en SQL, funciones de base, Self Join',
GETDATE(), GETDATE(), 1);

--Insert Imagen Publicacion

INSERT INTO ImagenPublicacion(IdImagen, IDPublicacion) VALUES (1, 1);

INSERT INTO ImagenPublicacion(IdImagen, IDPublicacion) VALUES (2, 2);


INSERT INTO Cursos (Titulo, Resumen, Descripcion, ImagenUrl)
VALUES 
('Programación 1', 'Aprendé programación desde cero.', 'Este curso te enseña los fundamentos de programación usando C#.', 'https://www.aprender21.com/images/colaboradores/sql.jpeg'),
('Bases de Datos', 'Diseñá y consultá bases de datos.', 'Aprendé SQL y cómo estructurar bases de datos relacionales.', 'https://www.aprender21.com/images/colaboradores/sql.jpeg'),
('Desarrollo Web', 'Creá sitios modernos.', 'HTML, CSS, JavaScript y Bootstrap para el desarrollo frontend.', 'https://www.aprender21.com/images/colaboradores/sql.jpeg');


-- Usuario Estudiante
INSERT INTO Usuario (
    Nombre, Apellido, Email, IdRol, Celular, IdUsuarioMoodle,
    FechaNacimiento, NombreUsuario, Pass, Habilitado, FotoPerfil
)
VALUES (
    'Juan', 'Pérez', 'juan.perez@example.com', 0, '1155551234', 10123,
    '2000-05-12', 'juanp', 'b20b0f63ce2ed361e8845d6bf2e59811aaa06ec96bcdb92f9bc0c5a25e83c9a6', 1, NULL
);

-- Usuario Administrador
INSERT INTO Usuario (
    Nombre, Apellido, Email, IdRol, Celular, IdUsuarioMoodle,
    FechaNacimiento, NombreUsuario, Pass, Habilitado, FotoPerfil
)
VALUES (
    'Ana', 'Gómez', 'ana.gomez@example.com', 1, '1166665678', 10124,
    '1985-09-27', 'anag', 'b45513fe304c65eb8a8fede7855c766223895d895457f1d5c3080f1cfea517b2', 1, NULL
);
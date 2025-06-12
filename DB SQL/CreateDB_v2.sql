CREATE DATABASE TPC_CURSOS_G12A
GO

USE TPC_CURSOS_G12A
GO

CREATE TABLE Categoria(
	IdCategoria INT IDENTITY(1,1) PRIMARY KEY,
	Nombre VARCHAR(85) NOT NULL
);

CREATE TABLE Imagen(
	IdImagen INT IDENTITY(1,1) PRIMARY KEY,
	UrlImagen VARCHAR(255),
	Nombre VARCHAR(85),
	IdTipoImagen INT NOT NULL
);

CREATE TABLE Publicacion(
	IdPublicacion INT IDENTITY(1,1) PRIMARY KEY,
	IdCategoria INT NOT NULL,
	Titulo VARCHAR(100) NOT NULL,
	Descripcion TEXT NOT NULL,
	Resumen VARCHAR(255) NOT NULL,
	FechaCreacion DATE,
	FechaPublicacion DATE,
	Estado INT,

	FOREIGN KEY (IdCategoria) REFERENCES Categoria(IdCategoria),
);

CREATE TABLE ImagenPublicacion(
	IdImagen INT NOT NULL,
	IdPublicacion INT NOT NULL,

	PRIMARY KEY (IdImagen, IDPublicacion),
	FOREIGN KEY (IdImagen) REFERENCES Imagen(IdImagen),
	FOREIGN KEY (IdPublicacion) REFERENCES Publicacion(IdPublicacion)
);

CREATE TABLE Curso (
    IdCurso INT PRIMARY KEY IDENTITY(1,1),
	IdCategoria INT NOT NULL,
	Estado INT NOT NULL,
    Titulo NVARCHAR(100) NOT NULL,
	Descripcion NVARCHAR(MAX),
    Resumen NVARCHAR(255),
    Precio DECIMAL NOT NULL,
	FechaPublicacion DATETIME,
	FechaCreacion DATETIME,
	Duracion INT,
	Certificado BIT,

	FOREIGN KEY (IdCategoria) REFERENCES Categoria(IdCategoria)
);

CREATE TABLE Usuario(
	IdUsuario INT PRIMARY KEY IDENTITY(1,1),
	Nombre VARCHAR(50),
	Apellido VARCHAR(50),
	Email VARCHAR(100) UNIQUE NOT NULL,
	IdRol INT,
	Celular VARCHAR(13),
	FechaNacimiento DATE,
	NombreUsuario VARCHAR(30) UNIQUE NOT NULL,
	FechaRegistro DATETIME,
	Pass VARCHAR(255),
	Habilitado BIT,
	EmailValidado BIT,
	RecuperoContrasenia BIT,
	TokenValidacion VARCHAR(255),
	FotoPerfil INT,

	FOREIGN KEY (FotoPerfil) REFERENCES Imagen(IdImagen) ON DELETE SET NULL
)

CREATE TABLE ImagenCurso(
	IdImagen INT NOT NULL,
	IdCurso INT NOT NULL,

	PRIMARY KEY (IdImagen, IdCurso),
	FOREIGN KEY (IdImagen) REFERENCES Imagen(IdImagen),
	FOREIGN KEY (IdCurso) REFERENCES Curso(IdCurso)
);

CREATE TABLE Modulo(
	IdModulo INT PRIMARY KEY IDENTITY(1,1),
	IdCurso INT NOT NULL,
	Titulo VARCHAR(150),
	Introduccion TEXT,
	Orden INT,

	FOREIGN KEY (IdCurso) REFERENCES Curso(IdCurso)
);

CREATE TABLE Leccion(
	IdLeccion INT PRIMARY KEY IDENTITY(1,1),
	IdModulo INT NOT NULL,
	Titulo VARCHAR(150),
	Introduccion TEXT,
	Orden INT,

	FOREIGN KEY (IdModulo) REFERENCES Modulo(IdModulo)
);

CREATE TABLE Componente(
	IdComponente INT PRIMARY KEY IDENTITY(1,1),
	IdLeccion INT,
	Titulo VARCHAR(150),
	Contenido TEXT,
	TipoContenido INT, -- 0 texto, 1 Imagen, 2 video, 3 archivo
	Orden INT,

	FOREIGN KEY (IdLeccion) REFERENCES Leccion(IdLeccion)
);

CREATE TABLE LeccionUsuario(
	IdLeccion INT NOT NULL,
	IdUsuario INT NOT NULL,
	EsFinalizado BIT DEFAULT 0,
	Finalizado DATETIME,

	PRIMARY KEY(IdLeccion, IdUsuario),
	FOREIGN KEY (IdLeccion) REFERENCES Leccion(IdLeccion),
	FOREIGN KEY (IdUsuario) REFERENCES Usuario(IdUsuario)
);

CREATE TABLE CursoFavorito(
	IdUsuario INT NOT NULL,
	IdCurso INT NOT NULL,
	Agregado DATETIME,

	PRIMARY KEY(IdCurso, IdUsuario),
	FOREIGN KEY (IdCurso) REFERENCES Curso(IdCurso),
	FOREIGN KEY (IdUsuario) REFERENCES Usuario(IdUsuario)
);

CREATE TABLE Carrito(
	IdCarrito INT PRIMARY KEY IDENTITY(1,1),
	IdUsuario INT NOT NULL,
	FechaCreacion DATETIME,
	UltimaModificacion DATETIME,
	EstadoCarrito INT DEFAULT 0,

	FOREIGN KEY (IdUsuario) REFERENCES Usuario(IdUsuario)
);

CREATE TABLE Compra(
	IdCompra INT PRIMARY KEY IDENTITY(1,1),
	IdUsuario INT NOT NULL,
	IdCarrito INT NOT NULL,
	FechaCompra DATETIME,
	MontoTotal DECIMAL NOT NULL,
	CodigoTransaccion VARCHAR(255) NOT NULL,

	FOREIGN KEY (IdUsuario) REFERENCES Usuario(IdUsuario),
	FOREIGN KEY (IdCarrito) REFERENCES Carrito(IdCarrito)
);

CREATE TABLE DetalleCompra(
	IdCompra INT NOT NULL,
	IdCurso INT NOT NULL,
	PrecioUnitario DECIMAL NOT NULL,

	PRIMARY KEY(IdCurso, IdCompra),
	FOREIGN KEY (IdCurso) REFERENCES Curso(IdCurso),
	FOREIGN KEY (IdCompra) REFERENCES Compra(IdCompra)
);

CREATE TABLE CarritoCurso(
	IdCarrito INT NOT NULL,
	IdCurso INT NOT NULL,
	PrecioUnitario DECIMAL NOT NULL,

	PRIMARY KEY(IdCurso, IdCarrito),
	FOREIGN KEY (IdCurso) REFERENCES Curso(IdCurso),
	FOREIGN KEY (IdCarrito) REFERENCES Carrito(IdCarrito)
);


select * from Usuario
update Usuario set IdRol=0 Where IdUsuario=1;

insert into imagen(UrlImagen, Nombre, IdTipoImagen) values
('https://preview.redd.it/some-random-faces-of-homer-v0-mia0xhbii85f1.jpg?width=504&format=pjpg&auto=webp&s=c1cbc9eca8b67b1c11ece2ee46c19c1abce68b45','Foto perfil',0)

INSERT INTO Usuario (Nombre, Apellido, Email, IdRol, Celular, FechaNacimiento, NombreUsuario, FechaRegistro, Pass, Habilitado, EmailValidado, RecuperoContrasenia, TokenValidacion, FotoPerfil)
VALUES 
('Lucas', 'González', 'lucas1@mail.com', 1, '1160000001', '1990-01-05', 'lucasg1', GETDATE(), '8f3a4f367aa8c56bf270e843168142331a873646719cd259643958b37fb8a753', 1, 1, 1, NULL, 2),
('Martina', 'Pérez', 'martina2@mail.com', 1, '1160000002', '1992-03-12', 'martip2', GETDATE(), '8f3a4f367aa8c56bf270e843168142331a873646719cd259643958b37fb8a753', 1, 1, 1, NULL, 2),
('Julián', 'Fernández', 'julian3@mail.com', 1, '1160000003', '1988-07-20', 'julif3', GETDATE(), '8f3a4f367aa8c56bf270e843168142331a873646719cd259643958b37fb8a753', 1, 1, 1, NULL, 2),
('Sofía', 'Ramírez', 'sofia4@mail.com', 1, '1160000004', '1995-09-30', 'sofiar4', GETDATE(), '8f3a4f367aa8c56bf270e843168142331a873646719cd259643958b37fb8a753', 1, 1, 1, NULL, 2),
('Tomás', 'Díaz', 'tomas5@mail.com', 1, '1160000005', '1993-11-14', 'tomasd5', GETDATE(), '8f3a4f367aa8c56bf270e843168142331a873646719cd259643958b37fb8a753', 1, 1, 1, NULL, 2),
('Valentina', 'López', 'valen6@mail.com', 1, '1160000006', '1991-04-18', 'valel6', GETDATE(), '8f3a4f367aa8c56bf270e843168142331a873646719cd259643958b37fb8a753', 1, 1, 1, NULL, 2),
('Agustín', 'Martínez', 'agustin7@mail.com', 1, '1160000007', '1987-06-09', 'agusm7', GETDATE(), '8f3a4f367aa8c56bf270e843168142331a873646719cd259643958b37fb8a753', 1, 1, 1, NULL, 2),
('Camila', 'Sánchez', 'camila8@mail.com', 1, '1160000008', '1994-08-23', 'camilas8', GETDATE(), '8f3a4f367aa8c56bf270e843168142331a873646719cd259643958b37fb8a753', 1, 1, 1, NULL, 2),
('Mateo', 'Torres', 'mateo9@mail.com', 1, '1160000009', '1996-02-02', 'mateot9', GETDATE(), '8f3a4f367aa8c56bf270e843168142331a873646719cd259643958b37fb8a753', 1, 1, 1, NULL, 2),
('Florencia', 'Moreno', 'flor10@mail.com', 1, '1160000010', '1990-10-10', 'florm10', GETDATE(), '8f3a4f367aa8c56bf270e843168142331a873646719cd259643958b37fb8a753', 1, 1, 1, NULL, 2);

update Usuario set IdRol = 0 Where IdUsuario=3;


<<<<<<< HEAD
select * from Componente

update Componente set Contenido='https://i0.wp.com/achirou.com/wp-content/uploads/2024/03/Alvaro_Chirou_Introduccion-a-la-programacion.jpg?fit=1600%2C900&ssl=1' where IdComponente=8
=======
--Insert Psra categoria

SELECT * FROM Categoria

INSERT INTO Categoria (Nombre) VALUES('Base de Datos');

INSERT INTO Categoria (Nombre) VALUES('Programación');

INSERT INTO Categoria (Nombre) VALUES('Tecnología');

INSERT INTO Categoria (Nombre) VALUES('Promoción');

--Publicacion

INSERT INTO Publicacion(IdCategoria, Titulo, Descripcion, Resumen, FechaCreacion, FechaPublicacion, Estado)
VALUES(3, 'Sam Altman afirma que el consumo de agua y energía de ChatGPT es ínfimo.', 
'Un email de 100 palabras generado por GPT-4 consume 519 mililitros de agua. Esa fue la conclusión a la que investigadores de la Universidad de California llegaron hace pocos meses tras analizar este modelo de OpenAI. Sam Altman, CEO de la compañía, acaba de arrojar su propia estimación sobre el consumo de agua y energía de cada consulta de ChatGPT. Y es muy distinta.
1.000 veces menos de lo que se decía. Según Altman, una consulta media en ChatGPT consume mucho menos de lo que se había indicado en estudios previos. Sus datos son llamativos, y para entenderlos hace analogías intersantes:

"A medida que se automatiza la producción en los centros de datos, el coste de la inteligencia debería aproximarse al de la electricidad. (La gente suele tener curiosidad por saber cuánta energía consume una consulta ChatGPT; la consulta media consume unos 0,34 vatios-hora, más o menos lo que consumiría un horno en poco más de un segundo o una bombilla de alta eficiencia en un par de minutos. También utiliza alrededor de 0,000085 galones de agua (0,32 ml); aproximadamente una quinceava parte de una cucharilla)".', 
'En un reciente artículo en su blog, el CEO de OpenAI vuelve a aumentar las expectativas sobre la IA.',
GETDATE(), GETDATE(), 1);

SELECT * FROM Publicacion

INSERT INTO Imagen(UrlImagen, Nombre, IdTipoImagen) values('https://i.blogs.es/991a31/sam-energia/1200_800.jpeg', 'Miniatura', 1)

INSERT INTO ImagenPublicacion(IdImagen, IdPublicacion) VALUES (2, 1)

INSERT INTO Publicacion(IdCategoria, Titulo, Descripcion, Resumen, FechaCreacion, FechaPublicacion, Estado)
VALUES(3, 'El liderazgo estadounidense en IA se tambalea. Los datos del AI Index 2025 de Stanford revelan que China ha recortado la ventaja técnica de Estados Unidos hasta niveles que parecían difíciles de alcanzar. Sobre todo, porque le ha llevado poco más de un año cerrar la mayor parte de la brecha.
Por qué es importante. Estados Unidos mantiene el volumen –40 modelos notables frente a 15 chinos al cierre del año en el listado de Epoch–, pero China ha demostrado que la calidad ya no es monopolio estadounidense, y esa casi-convergencia reescribe las reglas de la geopolítica en la tecnología más prometedora y estratégica del siglo XXI.', 
'La brecha de calidad en IA entre China y Estados Unidos se ha reducido del 9,26% al 1,7% en apenas un año.',
GETDATE(), GETDATE(), 1);

SELECT * FROM Publicacion

INSERT INTO Imagen(UrlImagen, Nombre, IdTipoImagen) values('https://i.blogs.es/cf4901/solen-feyissa-unsplash/1200_800.jpeg', 'Miniatura', 1)

INSERT INTO ImagenPublicacion(IdImagen, IdPublicacion) VALUES (3, 2)
>>>>>>> 6ab0fa384685e36e9bf7cebe488b32eb1d4bdfae

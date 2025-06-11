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
	--Duda
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
select * from usuario
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

select * from Imagen

insert into imagen(UrlImagen, Nombre, IdTipoImagen) values
('https://preview.redd.it/some-random-faces-of-homer-v0-mia0xhbii85f1.jpg?width=504&format=pjpg&auto=webp&s=c1cbc9eca8b67b1c11ece2ee46c19c1abce68b45','Foto perfil',0)


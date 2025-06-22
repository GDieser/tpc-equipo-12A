CREATE DATABASE CURSOS_TPC_G12A
GO

USE CURSOS_TPC_G12A
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
--	IdImagen INT NOT NULL,
	Titulo VARCHAR(100) NOT NULL,
	Descripcion TEXT NOT NULL,
	Resumen VARCHAR(255) NOT NULL,
	FechaCreacion DATE,
	FechaPublicacion DATE,
	Estado BIT,

	FOREIGN KEY (IdCategoria) REFERENCES Categoria(IdCategoria),
--	FOREIGN KEY (IdImagen) REFERENCES Imagen(IdImagen)
);

CREATE TABLE ImagenPublicacion(
	IdImagen INT NOT NULL,
	IDPublicacion INT NOT NULL,
	PRIMARY KEY (IdImagen, IDPublicacion),
	FOREIGN KEY (IdImagen) REFERENCES Imagen(IdImagen),
	FOREIGN KEY (IDPublicacion) REFERENCES Publicacion(IdPublicacion)
);

CREATE TABLE Curso(
    IdCurso INT PRIMARY KEY IDENTITY(1,1),
    IdCategoria INT,
	Estado BIT,
    Titulo NVARCHAR(100),
	Descripcion NVARCHAR(MAX),
    Resumen NVARCHAR(255),
	Precio DECIMAL,
	FechaPublicacion DATETIME,
	FechaCreacion DATETIME,
	Duracion INT,
	Certificado BIT,


	FOREIGN KEY (IdCategoria) REFERENCES Categoria(IdCategoria) ON DELETE CASCADE
);

CREATE TABLE Usuario(
	IdUsuario INT PRIMARY KEY IDENTITY(1,1),
	Nombre VARCHAR(50),
	Apellido VARCHAR(50),
	Email VARCHAR(100) UNIQUE NOT NULL,
	IdRol INT DEFAULT 1,
	Celular VARCHAR(13),
	FechaNacimiento DATE,
	NombreUsuario VARCHAR(30) UNIQUE NOT NULL,
	Pass VARCHAR(255),
	Habilitado BIT,
	FechaRegistro DATETIME,
	EmailValidado BIT,
	RecuperoContrasenia BIT,
	TokenValidacion VARCHAR(255),

	FotoPerfil INT,

	FOREIGN KEY (FotoPerfil) REFERENCES Imagen(IdImagen) ON DELETE SET NULL
)

CREATE TABLE Modulo (
	IdModulo INT PRIMARY KEY IDENTITY(1,1),
	Titulo NVARCHAR(80),
	Introduccion NVARCHAR(MAX),
	Orden INT,

	IdCurso INT NOT NULL,
	IdImagen INT

	FOREIGN KEY (IdImagen) REFERENCES Imagen(IdImagen) ON DELETE CASCADE, -- AGREGADO CAMPO IMAGEN
	FOREIGN KEY (IdCurso) REFERENCES Curso(IdCurso) ON DELETE CASCADE --IMPORTANTE PARA LA ELIMINACION DE UN CURSO
)

CREATE TABLE Leccion(
	IdLeccion INT PRIMARY KEY IDENTITY(1,1),
	Titulo NVARCHAR(80),
	Introduccion NVARCHAR(MAX),
	Contenido NVARCHAR(MAX), -- AGREGADO CONTENIDO
	Orden INT,

	IdModulo INT NOT NULL,
	FOREIGN KEY (IdModulo) REFERENCES Modulo(IdModulo) ON DELETE CASCADE --IMPORTANTE PARA LA ELIMINACION DE UN MODULO
)
/*
CREATE TABLE Componente(
	IdComponente INT PRIMARY KEY IDENTITY(1,1),
	Titulo NVARCHAR(80),
	Contenido NVARCHAR(MAX),
	Orden INT DEFAULT 0,
	TipoContenido INT,

	IdLeccion INT NOT NULL,
	FOREIGN KEY (IdLeccion) REFERENCES Leccion(IdLeccion)
)*/ 
-- YA NO USAMOS COMPONENTES EN LA APLICACION, TRABAJAMOS CON CKEDITOR

CREATE TABLE LeccionUsuario(
	IdLeccion INT NOT NULL,
	IdUsuario INT NOT NULL,
	EsFinalizado BIT DEFAULT 0,
	Finalizado DATETIME,

	PRIMARY KEY (IdLeccion, IdUsuario),
	FOREIGN KEY (IdLeccion) REFERENCES Leccion(IdLeccion),
	FOREIGN KEY (IdUsuario) REFERENCES Usuario(IdUsuario)
)

CREATE TABLE CursoFavorito(
	IdCurso INT NOT NULL,
	IdUsuario INT NOT NULL,
	Agregado DATETIME

	PRIMARY KEY (IdCurso, IdUsuario),
	FOREIGN KEY (IdCurso) REFERENCES Curso(IdCurso),
	FOREIGN KEY (IdUsuario) REFERENCES Usuario(IdUsuario)
)

CREATE TABLE ImagenCurso(
	IdCurso INT NOT NULL,
	IdImagen INT NOT NULL,
	
	PRIMARY KEY (IdCurso, IdImagen),
	FOREIGN KEY (IdCurso) REFERENCES Curso(IdCurso),
	FOREIGN KEY (IdImagen) REFERENCES Imagen(IdImagen)
)

CREATE TABLE CARRITO (
	IdCarrito INT PRIMARY KEY IDENTITY(1,1),
	FechaCreacion DATETIME NOT NULL,
	UltimaModificacion DATETIME,
	Estado INT DEFAULT 0,

	IdUsuario INT NOT NULL,

	FOREIGN KEY (IdUsuario) REFERENCES Usuario(IdUsuario)
)

CREATE TABLE Compra (
	IdCompra INT PRIMARY KEY IDENTITY(1,1),
	FechaCompra DATETIME NOT NULL,
	CodigoTransaccion VARCHAR(255) NOT NULL,
	MontoTotal DECIMAL NOT NULL,

	IdUsuario INT NOT NULL,
	IdCarrito INT NOT NULL,

	FOREIGN KEY (IdUsuario) REFERENCES Usuario(IdUsuario),
	FOREIGN KEY (IdCarrito) REFERENCES Carrito(IdCarrito)
)

CREATE TABLE DetalleCompra(
	IdCompra INT NOT NULL,
	IdCurso INT NOT NULL,
	PrecioUnitario DECIMAL NOT NULL,

	PRIMARY KEY (IdCompra, IdCurso),
	FOREIGN KEY (IdCompra) REFERENCES Compra(IdCompra),
	FOREIGN KEY (IdCurso) REFERENCES Curso(IdCurso)
)

CREATE TABLE CarritoCurso(
	IdCarrito INT NOT NULL,
	IdCurso INT NOT NULL,
	Fecha DATETIME NOT NULL,

	PRIMARY KEY (IdCarrito, IdCurso),
	FOREIGN KEY (IdCarrito) REFERENCES Carrito(IdCarrito),
	FOREIGN KEY (IdCurso) REFERENCES Curso(IdCurso)
)

update usuario set IdRol=0 where IdUsuario=1
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
	FechaPublicacion DATE,
	FechaCreacion DATE,
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
	IdCurso INT,
	Titulo VARCHAR(150),
	Introduccion TEXT,
	Orden INT,

	FOREIGN KEY (IdCurso) REFERENCES Curso(IdCurso)
);

CREATE TABLE Leccion(
	IdLeccion INT PRIMARY KEY IDENTITY(1,1),
	IdModulo INT,
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
	TipoContenido INT,
	Orden INT,

	FOREIGN KEY (IdLeccion) REFERENCES Leccion(IdLeccion)
);

CREATE TABLE LeccionUsuario(
	IdLeccion INT,
	IdUsuario INT,
	EsFinalizado BIT,
	Finalizado DATETIME,

	PRIMARY KEY(IdLeccion, IdUsuario),
	FOREIGN KEY (IdLeccion) REFERENCES Leccion(IdLeccion),
	FOREIGN KEY (IdUsuario) REFERENCES Usuario(IdUsuario)
);

CREATE TABLE CursoFavorito(
	IdUsuario INT,
	IdCurso INT,
	Agregado DATETIME,

	PRIMARY KEY(IdCurso, IdUsuario),
	FOREIGN KEY (IdCurso) REFERENCES Curso(IdCurso),
	FOREIGN KEY (IdUsuario) REFERENCES Usuario(IdUsuario)
);

CREATE TABLE Carrito(
	IdCarrito INT PRIMARY KEY IDENTITY(1,1),
	IdUsuario INT,
	FechaCreacion DATETIME,
	UltimaModificacion DATETIME,
	EstadoCarrito INT,

	FOREIGN KEY (IdUsuario) REFERENCES Usuario(IdUsuario)
);

CREATE TABLE Compra(
	IdCompra INT PRIMARY KEY IDENTITY(1,1),
	IdUsuario INT,
	IdCarrito INT,
	FechaCompra DATETIME,
	MontoTotal DECIMAL,
	CodigoTransaccion VARCHAR(255),

	FOREIGN KEY (IdUsuario) REFERENCES Usuario(IdUsuario),
	FOREIGN KEY (IdCarrito) REFERENCES Carrito(IdCarrito)
);

CREATE TABLE DetalleCompra(
	IdCompra INT,
	IdCurso INT,
	PrecioUnitario DECIMAL,

	PRIMARY KEY(IdCurso, IdCompra),
	FOREIGN KEY (IdCurso) REFERENCES Curso(IdCurso),
	FOREIGN KEY (IdCompra) REFERENCES Compra(IdCompra)
);

CREATE TABLE CarritoCurso(
	IdCarrito INT,
	IdCurso INT,
	PrecioUnitario DECIMAL,

	PRIMARY KEY(IdCurso, IdCarrito),
	FOREIGN KEY (IdCurso) REFERENCES Curso(IdCurso),
	FOREIGN KEY (IdCarrito) REFERENCES Carrito(IdCarrito)
);
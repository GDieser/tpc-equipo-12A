CREATE DATABASE TPC_CURSOS_G12A
GO

USE TPC_CURSOS_G12A
GO

CREATE TABLE Categoria(
	IdCategoria INT IDENTITY(1,1) PRIMARY KEY,
	Nombre VARCHAR(85) NOT NULL,
	Activo BIT NOT NULL DEFAULT 1
);

CREATE TABLE Imagen(
	IdImagen INT IDENTITY(1,1) PRIMARY KEY,
	UrlImagen VARCHAR(255),
	Nombre VARCHAR(85),
	IdTipoImagen INT NOT NULL
);
GO

CREATE TABLE Publicacion(
	IdPublicacion INT IDENTITY(1,1) PRIMARY KEY,
	IdCategoria INT NOT NULL,
	Titulo NVARCHAR(100) NOT NULL,
	Descripcion NVARCHAR(MAX) NOT NULL,
	Resumen NVARCHAR(255) NOT NULL,
	FechaCreacion DATETIME,
	FechaPublicacion DATETIME,
	Estado INT,
	
	FOREIGN KEY (IdCategoria) REFERENCES Categoria(IdCategoria)
);
GO

CREATE TABLE ImagenPublicacion(
	IdImagen INT NOT NULL,
	IdPublicacion INT NOT NULL

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
	Certificado BIT

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
	FotoPerfil INT

	FOREIGN KEY (FotoPerfil) REFERENCES Imagen(IdImagen) ON DELETE SET NULL
)
GO

CREATE TABLE ImagenCurso(
	IdImagen INT NOT NULL,
	IdCurso INT NOT NULL

	PRIMARY KEY (IdImagen, IdCurso),
	FOREIGN KEY (IdImagen) REFERENCES Imagen(IdImagen),
	FOREIGN KEY (IdCurso) REFERENCES Curso(IdCurso)
);

CREATE TABLE Modulo(
	IdModulo INT PRIMARY KEY IDENTITY(1,1),
	IdCurso INT NOT NULL,
	IdImagen INT,
	Titulo NVARCHAR(150),
	Introduccion NVARCHAR(MAX),
	Orden INT

	FOREIGN KEY (IdImagen) REFERENCES Imagen(IdImagen) ON DELETE CASCADE, 
	FOREIGN KEY (IdCurso) REFERENCES Curso(IdCurso) ON DELETE CASCADE 
);
GO


CREATE TABLE Leccion(
	IdLeccion INT PRIMARY KEY IDENTITY(1,1),
	IdModulo INT NOT NULL,
	Titulo NVARCHAR(80),
	Introduccion NVARCHAR(MAX),
	Contenido NVARCHAR(MAX), -- AGREGADO CONTENIDO
	Orden INT

	FOREIGN KEY (IdModulo) REFERENCES Modulo(IdModulo) ON DELETE CASCADE --IMPORTANTE PARA LA ELIMINACION DE UN MODULO
);
GO

CREATE TABLE LeccionUsuario(
	IdLeccion INT NOT NULL,
	IdUsuario INT NOT NULL,
	EsFinalizado BIT DEFAULT 0,
	Finalizado DATETIME

	PRIMARY KEY(IdLeccion, IdUsuario),
	FOREIGN KEY (IdLeccion) REFERENCES Leccion(IdLeccion),
	FOREIGN KEY (IdUsuario) REFERENCES Usuario(IdUsuario)
);
GO

CREATE TABLE CursoFavorito(
	IdUsuario INT NOT NULL,
	IdCurso INT NOT NULL,
	Agregado DATETIME,
	Activo BIT NOT NULL DEFAULT 1

	PRIMARY KEY(IdCurso, IdUsuario),
	FOREIGN KEY (IdCurso) REFERENCES Curso(IdCurso),
	FOREIGN KEY (IdUsuario) REFERENCES Usuario(IdUsuario)
);
GO

CREATE TABLE Carrito(
	IdCarrito INT PRIMARY KEY IDENTITY(1,1),
	IdUsuario INT NOT NULL,
	FechaCreacion DATETIME,
	UltimaModificacion DATETIME,
	EstadoCarrito INT DEFAULT 0

	FOREIGN KEY (IdUsuario) REFERENCES Usuario(IdUsuario)
);
GO

CREATE TABLE Compra(
	IdCompra INT PRIMARY KEY IDENTITY(1,1),
	IdUsuario INT NOT NULL,
	IdCarrito INT NOT NULL,
	FechaCompra DATETIME,
	MontoTotal DECIMAL NOT NULL,
	CodigoTransaccion VARCHAR(255) NOT NULL

	FOREIGN KEY (IdUsuario) REFERENCES Usuario(IdUsuario),
	FOREIGN KEY (IdCarrito) REFERENCES Carrito(IdCarrito)
);

CREATE TABLE DetalleCompra(
	IdCompra INT NOT NULL,
	IdCurso INT NOT NULL,
	PrecioUnitario DECIMAL NOT NULL

	PRIMARY KEY(IdCurso, IdCompra),
	FOREIGN KEY (IdCurso) REFERENCES Curso(IdCurso),
	FOREIGN KEY (IdCompra) REFERENCES Compra(IdCompra)
);

CREATE TABLE CarritoCurso(
	IdCarrito INT NOT NULL,
	IdCurso INT NOT NULL,
	PrecioUnitario DECIMAL NOT NULL

	PRIMARY KEY(IdCurso, IdCarrito),
	FOREIGN KEY (IdCurso) REFERENCES Curso(IdCurso),
	FOREIGN KEY (IdCarrito) REFERENCES Carrito(IdCarrito)
);

CREATE TABLE PreguntasFrecuentes(
	IdFaq INT PRIMARY KEY IDENTITY(1,1),
	Pregunta VARCHAR(255) NOT NULL,
	Respuesta TEXT NOT NULL,
	Activo BIT NOT NULL DEFAULT 1
);

---Ejemplo sistema de comentarios

CREATE TABLE Comentario (
    IdComentario INT PRIMARY KEY IDENTITY(1,1),
    IdUsuario INT NOT NULL,
    
    TipoOrigen VARCHAR(50) NOT NULL,
    IdOrigen INT NOT NULL,
    
    IdComentarioPadre INT NULL,
    Contenido NVARCHAR(2048) NOT NULL, 
    FechaCreacion DATETIME NOT NULL,
    FechaEdicion DATETIME NULL,
    EsEditado BIT DEFAULT 0,
    EsEliminado BIT DEFAULT 0,
    Visible BIT DEFAULT 1,

    FOREIGN KEY (IdUsuario) REFERENCES Usuario(IdUsuario),
    FOREIGN KEY (IdComentarioPadre) REFERENCES Comentario(IdComentario)
);

CREATE TABLE NotificacionAdmin(
	IdNotificacion  INT PRIMARY KEY IDENTITY(1,1),
	IdComentario  INT NOT NULL,
	Visto BIT NOT NULL DEFAULT 0,
	FechaNotificacion DATE NOT NULL DEFAULT GETDATE(),
	IdAdministrador INT NULL,
	EsReporte BIT NOT NULL DEFAULT 0,
    MotivoReporte VARCHAR(50) NULL,
    IdUsuarioReportador INT NULL,
	
    FOREIGN KEY (IdUsuarioReportador) REFERENCES Usuario(IdUsuario),
	FOREIGN KEY (IdComentario) REFERENCES Comentario(IdComentario),
    FOREIGN KEY (IdAdministrador) REFERENCES Usuario(IdUsuario)
);

--Para Debates den Foro
CREATE TABLE Debate (
    IdDebate INT PRIMARY KEY IDENTITY(1,1),
    IdUsuario INT NOT NULL,
    IdOrigen INT NULL,
    Titulo NVARCHAR(255) NOT NULL,
    Contenido NVARCHAR(MAX) NOT NULL,
    FechaCreacion DATETIME NOT NULL DEFAULT GETDATE(),
	FechaEdicion DATETIME NULL,
    EsEditado BIT DEFAULT 0,
    EsAviso BIT NOT NULL DEFAULT 0,
    Activo BIT NOT NULL DEFAULT 1 

	FOREIGN KEY (IdUsuario) REFERENCES Usuario(IdUsuario),
	FOREIGN KEY (IdOrigen) REFERENCES Curso(IdCurso)
);

ALTER TABLE Carrito ADD IDOperacion VARCHAR(60); -- Para almacenar el Id de operacion de MP

-- AGREGADO PARA VIDEO DE YT
ALTER TABLE Leccion
ADD 
    AltoVideo INT,
    AnchoVideo INT,
    UrlVideo VARCHAR(255),
	IframeVideo VARCHAR(MAX);

-- AGREGADO PARA ESTADO DE LA COMPRA
ALTER TABLE COMPRA
ADD
	Estado INT;

--Agregado para not admin
ALTER TABLE NotificacionAdmin
ADD
	Oculto BIT NOT NULL DEFAULT 0;

--Nueva tabla para notif de estudiantes
CREATE TABLE NotificacionEstudiante (
	IdNotificacion  INT PRIMARY KEY IDENTITY(1,1),
	IdEstudiante INT NOT NULL,
	IdComentario  INT NOT NULL,
	Visto BIT NOT NULL DEFAULT 0,
	FechaNotificacion DATE NOT NULL DEFAULT GETDATE(),

	FOREIGN KEY (IdEstudiante) REFERENCES Usuario(IdUsuario),
	FOREIGN KEY (IdComentario) REFERENCES Comentario(IdComentario)
);


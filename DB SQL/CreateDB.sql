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
	IdImagen INT NOT NULL,
	Titulo VARCHAR(100) NOT NULL,
	Descripcion TEXT NOT NULL,
	Resumen VARCHAR(255) NOT NULL,
	FechaCreacion DATE,
	FechaPublicacion DATE,
	Estado BIT,

	FOREIGN KEY (IdCategoria) REFERENCES Categoria(IdCategoria),
	FOREIGN KEY (IdImagen) REFERENCES Imagen(IdImagen)
);

CREATE TABLE ImagenPublicacion(
	IdImagen INT NOT NULL,
	IDPublicacion INT NOT NULL,
	PRIMARY KEY (IdImagen, IDPublicacion),
	FOREIGN KEY (IdImagen) REFERENCES Imagen(IdImagen),
	FOREIGN KEY (IDPublicacion) REFERENCES Publicacion(IdPublicacion)
);
CREATE TABLE Cursos (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Titulo NVARCHAR(100) NOT NULL,
    Resumen NVARCHAR(255),
   Descripcion NVARCHAR(MAX),
    ImagenUrl NVARCHAR(255)
);
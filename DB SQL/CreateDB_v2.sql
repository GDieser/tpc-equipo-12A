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
	Titulo NVARCHAR(100) NOT NULL,
	Descripcion NVARCHAR(MAX) NOT NULL,
	Resumen NVARCHAR(255) NOT NULL,
	FechaCreacion DATETIME,
	FechaPublicacion DATETIME,
	Estado INT,
	
	FOREIGN KEY (IdCategoria) REFERENCES Categoria(IdCategoria)
);
--Si lo tienen dado de alta, si no lo eliminamos despues
---------------------------------------------------------------------------
ALTER TABLE Publicacion
ALTER COLUMN Titulo NVARCHAR(100) NOT NULL;

ALTER TABLE Publicacion
ALTER COLUMN Resumen NVARCHAR(255) NOT NULL;

ALTER TABLE Publicacion
ALTER COLUMN Descripcion NVARCHAR(MAX) NOT NULL;

ALTER TABLE Publicacion
ALTER COLUMN FechaCreacion DATETIME;

ALTER TABLE Publicacion
ALTER COLUMN FechaPublicacion DATETIME;
------------------------------------------------------------------------------

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
	Titulo NVARCHAR(150), -- CAMBIADO A NVARCHAR
	Introduccion NVARCHAR(MAX), -- CAMBIADO A NVARCHAR
	Orden INT

	FOREIGN KEY (IdImagen) REFERENCES Imagen(IdImagen) ON DELETE CASCADE, -- AGREGADO CAMPO IMAGEN
	FOREIGN KEY (IdCurso) REFERENCES Curso(IdCurso) ON DELETE CASCADE --IMPORTANTE PARA LA ELIMINACION DE UN CURSO
);
--Aun no implementado-------------------------
ALTER TABLE Modulo 
ADD  EsEvaluacion BIT NOT NULL DEFAULT 0;
----------------------------------------------
CREATE TABLE Leccion(
	IdLeccion INT PRIMARY KEY IDENTITY(1,1),
	IdModulo INT NOT NULL,
	Titulo NVARCHAR(80),
	Introduccion NVARCHAR(MAX),
	Contenido NVARCHAR(MAX), -- AGREGADO CONTENIDO
	Orden INT

	FOREIGN KEY (IdModulo) REFERENCES Modulo(IdModulo) ON DELETE CASCADE --IMPORTANTE PARA LA ELIMINACION DE UN MODULO
);
--Aun no implementado-------------------------
ALTER TABLE Leccion 
ADD  EsEvaluacion BIT NOT NULL DEFAULT 0;
----------------------------------------------
/*
CREATE TABLE Componente(
	IdComponente INT PRIMARY KEY IDENTITY(1,1),
	IdLeccion INT,
	Titulo VARCHAR(150),
	Contenido TEXT,
	TipoContenido INT, -- 0 texto, 1 Imagen, 2 video, 3 archivo
	Orden INT,

	FOREIGN KEY (IdLeccion) REFERENCES Leccion(IdLeccion)
);
*/ -- borramos esta entidad ya que vamos a utilizar CKEditor para las lecciones

CREATE TABLE LeccionUsuario(
	IdLeccion INT NOT NULL,
	IdUsuario INT NOT NULL,
	EsFinalizado BIT DEFAULT 0,
	Finalizado DATETIME

	PRIMARY KEY(IdLeccion, IdUsuario),
	FOREIGN KEY (IdLeccion) REFERENCES Leccion(IdLeccion),
	FOREIGN KEY (IdUsuario) REFERENCES Usuario(IdUsuario)
);

CREATE TABLE CursoFavorito(
	IdUsuario INT NOT NULL,
	IdCurso INT NOT NULL,
	Agregado DATETIME

	PRIMARY KEY(IdCurso, IdUsuario),
	FOREIGN KEY (IdCurso) REFERENCES Curso(IdCurso),
	FOREIGN KEY (IdUsuario) REFERENCES Usuario(IdUsuario)
);

CREATE TABLE Carrito(
	IdCarrito INT PRIMARY KEY IDENTITY(1,1),
	IdUsuario INT NOT NULL,
	FechaCreacion DATETIME,
	UltimaModificacion DATETIME,
	EstadoCarrito INT DEFAULT 0

	FOREIGN KEY (IdUsuario) REFERENCES Usuario(IdUsuario)
);

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

/*
CREATE TABLE ImagenModulo(
	IdImagen INT,
	IdModulo INT,
	PRIMARY KEY (IdImagen, IdModulo),
	FOREIGN KEY (IdImagen) REFERENCES Imagen(IdImagen),
	FOREIGN KEY (IdModulo) REFERENCES Modulo(IdModulo)
)
*/ -- Eliminamos entidad ya que la relacion es 1:N poniendo el IdImagen en el Modulo


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

---AUN EN DESARROLLO
--CREATE TABLE NotificacionUsuario(
--	IdNotificacion INT PRIMARY KEY IDENTITY(1,1),
--	IdComentario INT NOT NULL,
--	IdUsuarioDestino INT NOT NULL,
--	Tipo VARCHAR(50),
--	Leido BIT NOT NULL DEFAULT 0,
--	FechaNotificacion DATE NOT NULL DEFAULT GETDATE(),
--
--	FOREIGN KEY (IdComentario) REFERENCES Comentario(IdComentario)
--);


--********************************************************************************************************
--Procedimientos almacenados:

--Comentarios: 

CREATE PROCEDURE sp_ObtenerComentariosPorOrigen
    @IdOrigen INT
AS
BEGIN
    SELECT 
        C.IdComentario, C.IdUsuario, C.TipoOrigen, C.IdOrigen, C.IdComentarioPadre, 
        C.Contenido, C.FechaCreacion, C.FechaEdicion, C.EsEditado, U.NombreUsuario, 
        I.UrlImagen
    FROM 
        Comentario C 
    INNER JOIN 
        Usuario U ON C.IdUsuario = U.IdUsuario
    INNER JOIN 
        Imagen I ON U.FotoPerfil = I.IdImagen
    WHERE 
        C.Visible = 1 
        AND C.EsEliminado = 0 
        AND C.IdOrigen = @IdOrigen
    ORDER BY 
        C.FechaCreacion DESC;
END

GO

CREATE PROCEDURE sp_InsertarComentario
    @IdUsuario INT,
    @TipoOrigen VARCHAR(50),
    @IdOrigen INT,
    @IdComentarioPadre INT = NULL,
    @Contenido NVARCHAR(2048)
AS
BEGIN
    INSERT INTO Comentario (
        IdUsuario, TipoOrigen, IdOrigen, IdComentarioPadre, 
        Contenido, FechaCreacion, FechaEdicion
    )
    VALUES (
        @IdUsuario, 
        @TipoOrigen, 
        @IdOrigen, 
        @IdComentarioPadre, 
        @Contenido, 
        GETDATE(), 
        NULL
    );
    
    SELECT SCOPE_IDENTITY() AS IdComentarioNuevo;
END

go

--FAQs

--Imagenes

CREATE PROCEDURE sp_ObtenerImagenesPorPublicacion
    @IdPublicacion INT
AS
BEGIN
    SELECT 
        I.IdImagen, 
        I.UrlImagen, 
        I.IdTipoImagen, 
        I.Nombre
    FROM 
        ImagenPublicacion IP
    INNER JOIN 
        Imagen I ON IP.IdImagen = I.IdImagen
    WHERE 
        IP.IdPublicacion = @IdPublicacion;
END
GO

CREATE PROCEDURE sp_InsertarImagen
    @url VARCHAR(255),
    @tipo INT,
    @nombre VARCHAR(85)
AS
BEGIN
    INSERT INTO Imagen (UrlImagen, IdTipoImagen, Nombre) 
    VALUES (@url, @tipo, @nombre);
    
    SELECT SCOPE_IDENTITY() AS IdImagenNueva;
END
GO


--Notificacione
--comentarios
CREATE PROCEDURE sp_ListarNotificacionesComentarios
    @IdAdmin INT,
    @SoloNuevas BIT = 0
AS
BEGIN
    SELECT 
        N.IdNotificacion, C.Contenido, P.Titulo, C.TipoOrigen, 
        C.IdOrigen, C.FechaCreacion, U.NombreUsuario, N.Visto
    FROM 
        NotificacionAdmin N
    INNER JOIN 
        Comentario C ON C.IdComentario = N.IdComentario
    INNER JOIN 
        Usuario U ON U.IdUsuario = C.IdUsuario
    INNER JOIN 
        Publicacion P ON P.IdPublicacion = C.IdOrigen
    WHERE 
        N.IdAdministrador = @IdAdmin 
        AND C.EsEliminado = 0
        AND EsReporte = 0
        AND (@SoloNuevas = 0 OR N.Visto = 0)
    ORDER BY 
        N.IdNotificacion DESC;
END

GO

--reportes

CREATE PROCEDURE sp_ListarNotificacionesReportes
    @IdAdmin INT,
    @SoloNuevas BIT = 0
AS
BEGIN
    SELECT 
        N.IdNotificacion, C.Contenido, P.Titulo, C.TipoOrigen, C.IdOrigen, C.FechaCreacion,
        U.NombreUsuario AS UsuarioComentario,
        UR.NombreUsuario AS UsuarioReporte,
        N.Visto, N.MotivoReporte
    FROM 
        NotificacionAdmin N
    INNER JOIN 
        Comentario C ON C.IdComentario = N.IdComentario
    INNER JOIN 
        Usuario U ON U.IdUsuario = C.IdUsuario
    LEFT JOIN 
        Usuario UR ON UR.IdUsuario = N.IdUsuarioReportador
    INNER JOIN 
        Publicacion P ON P.IdPublicacion = C.IdOrigen
    WHERE 
        N.IdAdministrador = @IdAdmin 
        AND N.EsReporte = 1 
        AND C.EsEliminado = 0
        AND (@SoloNuevas = 0 OR N.Visto = 0)
    ORDER BY 
        N.IdNotificacion DESC;
END

GO

CREATE PROCEDURE sp_InsertarNotificacionAdmin
    @idcomentario INT,
    @idadmin INT,
    @reporte BIT,
    @motivo VARCHAR(50) = NULL,
    @idusuario INT = NULL 
AS
BEGIN
    INSERT INTO NotificacionAdmin
    (
        IdComentario, FechaNotificacion, IdAdministrador, EsReporte, 
        MotivoReporte, IdUsuarioReportador
    )
    VALUES
    (
        @idcomentario, 
        GETDATE(), 
        @idadmin, 
        @reporte, 
        @motivo, 
        @idusuario
    );
   
END
GO
--Novedades

CREATE PROCEDURE sp_ListarPublicaciones
AS
BEGIN
    SELECT 
        P.IdPublicacion, P.IdCategoria, 
        C.Nombre AS NombreCategoria,
		P.Titulo, P.Descripcion, P.Resumen, P.FechaCreacion, 
        P.FechaPublicacion, P.Estado
    FROM 
        Publicacion P
    INNER JOIN 
        Categoria C ON C.IdCategoria = P.IdCategoria;
END

GO

CREATE PROCEDURE sp_ObtenerPublicacionPorId
    @id INT
AS
BEGIN
    SELECT 
        IdPublicacion, IdCategoria, Titulo, Descripcion, Resumen, 
        FechaCreacion, FechaPublicacion, Estado 
    FROM 
        Publicacion 
    WHERE 
        IdPublicacion = @id;
END

GO

CREATE PROCEDURE sp_InsertarPublicacion
    @idcategoria INT,
    @titulo NVARCHAR(100),
    @descripcion NVARCHAR(MAX),
    @resumen NVARCHAR(255),
    @fechacreacion DATETIME,
    @fechapublicacion DATETIME,
    @estado INT
AS
BEGIN
    INSERT INTO Publicacion (
        IdCategoria, Titulo, Descripcion, Resumen, 
        FechaCreacion, FechaPublicacion, Estado
    )
    VALUES (
        @idcategoria,
        @titulo,
        @descripcion,
        @resumen,
        @fechacreacion,
        @fechapublicacion,
        @estado
    );
    
    SELECT SCOPE_IDENTITY() AS IdPublicacionNueva;
END

GO

CREATE PROCEDURE sp_ActualizarPublicacion
    @id INT,
    @idcategoria INT,
    @titulo NVARCHAR(100),
    @descripcion NVARCHAR(MAX),
    @resumen NVARCHAR(250),
    @estado INT
AS
BEGIN
    UPDATE Publicacion 
    SET 
        IdCategoria = @idcategoria,
        Titulo = @titulo,
        Descripcion = @descripcion,
        Resumen = @resumen,
        Estado = @estado
    WHERE 
        IdPublicacion = @id;
    
END

GO

--Usuario

CREATE PROCEDURE sp_ObtenerUsuarioPorId
    @IdUsuario INT
AS
BEGIN
    SELECT 
        u.IdUsuario, u.Nombre, u.Apellido, u.Email, u.IdRol, u.Celular, u.FechaNacimiento, 
        u.Habilitado, u.NombreUsuario, u.FechaRegistro, i.IdImagen, i.UrlImagen, 
        i.Nombre AS nombreImagen
    FROM 
        Usuario u
    LEFT JOIN 
        Imagen i ON u.FotoPerfil = i.IdImagen
    WHERE 
        u.IdUsuario = @IdUsuario;
END

GO

CREATE PROCEDURE sp_InsertarUsuario
    @Nombre VARCHAR(50),
    @Apellido VARCHAR(50),
    @Email VARCHAR(100),
    @NombreUsuario VARCHAR(30),
    @IdRol INT,
    @Habilitado BIT,
    @TokenValidacion VARCHAR(255),
    @EmailValidado BIT,
    @FechaRegistro DATETIME,
    @RecuperoContrasenia BIT
AS
BEGIN
    INSERT INTO Usuario (
        Nombre, Apellido, Email, NombreUsuario, IdRol, Habilitado,
        TokenValidacion, EmailValidado, FechaRegistro, RecuperoContrasenia
    )
    VALUES (
        @Nombre,
        @Apellido,
        @Email,
        @NombreUsuario,
        @IdRol,
        @Habilitado,
        @TokenValidacion,
        @EmailValidado,
        @FechaRegistro,
        @RecuperoContrasenia
    );
END

go

CREATE PROCEDURE sp_GuardarContrasenia
    @IdUsuario INT,
    @NombreUsuario VARCHAR(30),
    @TokenValidacion VARCHAR(255),
    @EmailValidado BIT,
    @Pass VARCHAR(255),
    @RecuperoContrasenia BIT

AS
BEGIN
    UPDATE Usuario
    SET 
        TokenValidacion = @TokenValidacion,
        EmailValidado = @EmailValidado,
        Pass = @Pass,
        RecuperoContrasenia = @RecuperoContrasenia
    WHERE 
        IdUsuario = @IdUsuario 
        AND NombreUsuario = @NombreUsuario;
END

GO

CREATE PROCEDURE sp_ActualizarUsuario
    @IdUsuario INT,
    @Nombre VARCHAR(50),
    @Apellido VARCHAR(50),
    @Email VARCHAR(100),
    @NombreUsuario VARCHAR(30),
    @IdRol INT,
    @Celular VARCHAR(13),
    @FechaNacimiento DATE,
    @Habilitado BIT,
    @FotoPerfil INT,
    @FechaRegistro DATETIME
AS
BEGIN
    UPDATE Usuario
    SET 
        Nombre = @Nombre,
        Apellido = @Apellido,
        Email = @Email,
        NombreUsuario = @NombreUsuario,
        IdRol = @IdRol,
        Celular = @Celular,
        FechaNacimiento = @FechaNacimiento,
        Habilitado = @Habilitado,
        FotoPerfil = @FotoPerfil,
        FechaRegistro = @FechaRegistro
    WHERE 
        IdUsuario = @IdUsuario;
END

GO

CREATE PROCEDURE sp_RecuperarContrasenia
    @IdUsuario INT,
    @NombreUsuario VARCHAR(30),
    @TokenValidacion VARCHAR(255),
    @RecuperoContrasenia BIT
AS
BEGIN
    UPDATE Usuario
    SET 
        TokenValidacion = @TokenValidacion,
        RecuperoContrasenia = @RecuperoContrasenia
    WHERE IdUsuario = @IdUsuario AND NombreUsuario = @NombreUsuario;
END;

GO

CREATE PROCEDURE sp_ListarUsuarios
AS
BEGIN
    SELECT 
        u.IdUsuario, u.Nombre, u.Apellido, u.Email, u.IdRol, u.Celular, u.FechaNacimiento, 
        u.Habilitado, u.NombreUsuario, u.FechaRegistro, i.IdImagen, i.UrlImagen, 
        i.Nombre AS nombreImagen, 
        COUNT(dc.IdCompra) AS CursosComprados
    FROM Usuario u
    LEFT JOIN Imagen i ON u.FotoPerfil = i.IdImagen
    LEFT JOIN Compra c ON c.IdUsuario = u.IdUsuario
    LEFT JOIN DetalleCompra dc ON dc.IdCompra = c.IdCompra
    WHERE u.IdRol <> 0
    GROUP BY 
        u.IdUsuario, u.Nombre, u.Apellido, u.Email, u.IdRol, u.Celular, u.FechaNacimiento, 
        u.Habilitado, u.NombreUsuario, u.FechaRegistro, i.IdImagen, i.UrlImagen, i.Nombre;
END;

GO
--*******************************************************************************--
---Parte de cursos

CREATE PROCEDURE sp_ListarCursosPorRol
    @RolUsuario INT
AS
BEGIN
    SELECT  
        C.IdCurso, 
        C.Titulo, 
        C.Resumen, 
        C.Descripcion, 
        C.Precio, 
        C.FechaPublicacion, 
        C.Estado,
        C.IdCategoria,
        Cat.Nombre     AS NombreCategoria,
        I.IdImagen,
        I.UrlImagen    AS Url,
        I.Nombre       AS NombreImagen,
        I.IdTipoImagen AS Tipo
    FROM Curso C
    INNER JOIN Categoria Cat ON Cat.IdCategoria = C.IdCategoria
    LEFT JOIN ImagenCurso IC ON IC.IdCurso = C.IdCurso
    LEFT JOIN Imagen I ON I.IdImagen = IC.IdImagen
    WHERE (@RolUsuario = 0 OR C.Estado = 1);
END;

GO

CREATE PROCEDURE sp_ObtenerCursoPorID
    @id INT
AS
BEGIN
    SELECT TOP 1
           C.IdCurso, C.Titulo, C.Resumen, C.Descripcion, C.Precio, C.Duracion, C.Certificado, C.FechaCreacion,
           C.FechaPublicacion,C.Estado, Cat.IdCategoria,
           Cat.Nombre AS NombreCategoria,
           I.IdImagen, I.UrlImagen, I.Nombre, I.IdTipoImagen
    FROM Curso C
    INNER JOIN Categoria Cat ON C.IdCategoria = Cat.IdCategoria
    LEFT JOIN ImagenCurso IC ON C.IdCurso = IC.IdCurso
    LEFT JOIN Imagen I ON IC.IdImagen = I.IdImagen
    WHERE C.IdCurso = @id;
END

GO

CREATE PROCEDURE sp_InsertarCurso
    @idcat INT,
    @estado BIT,
    @titulo NVARCHAR(100),
    @descripcion NVARCHAR(MAX),
    @resumen NVARCHAR(255),
    @precio DECIMAL,
    @fechaPub DATETIME,
    @fechaCrea DATETIME,
    @duracion INT,
    @certificado BIT
AS
BEGIN
    INSERT INTO Curso (
        IdCategoria, Estado, Titulo, Descripcion, Resumen,Precio, 
        FechaPublicacion, FechaCreacion, Duracion, Certificado
    )
    VALUES (
        @idcat, 
        @estado, 
        @titulo, 
        @descripcion, 
        @resumen,
        @precio, 
        @fechaPub, 
        @fechaCrea, 
        @duracion, 
        @certificado
    );
    
    SELECT SCOPE_IDENTITY() AS IdCursoNuevo;
END

go

CREATE PROCEDURE sp_ModificarCurso
    @id INT,
    @titulo NVARCHAR(100),
    @resumen NVARCHAR(255),
    @descripcion NVARCHAR(MAX),
    @precio DECIMAL,
    @duracion INT,
    @certificado BIT,
    @fechaPublicacion DATETIME,
    @estado INT,
    @idCategoria INT
AS
BEGIN
    UPDATE Curso
    SET 
        Titulo = @titulo,
        Resumen = @resumen,
        Descripcion = @descripcion,
        Precio = @precio,
        Duracion = @duracion,
        Certificado = @certificado,
        FechaPublicacion = @fechaPublicacion,
        Estado = @estado,
        IdCategoria = @idCategoria
    WHERE 
        IdCurso = @id;
END

GO

CREATE PROCEDURE sp_ListarCursosFavoritos
    @idUsuario INT
AS
BEGIN
    SELECT 
        C.IdCurso, C.Titulo, C.Resumen, I.IdImagen,
        I.UrlImagen AS Url, I.Nombre AS NombreImagen,
        I.IdTipoImagen AS Tipo
    FROM Curso C
    LEFT JOIN ImagenCurso IC ON C.IdCurso = IC.IdCurso
    LEFT JOIN Imagen I ON IC.IdImagen = I.IdImagen
    LEFT JOIN CursoFavorito CF ON C.IdCurso = CF.IdCurso
    LEFT JOIN Usuario US ON CF.IdUsuario = US.IdUsuario
    WHERE US.IdUsuario = @idUsuario AND CF.Activo = 1;
END

GO
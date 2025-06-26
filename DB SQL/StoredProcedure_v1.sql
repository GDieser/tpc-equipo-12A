--********************************************************************************************************
--Procedimientos almacenados:

--Comentarios: 
USE TPC_CURSOS_G12A
GO

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
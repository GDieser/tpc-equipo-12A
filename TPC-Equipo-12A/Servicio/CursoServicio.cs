using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dominio;

namespace Servicio
{
    public class CursoServicio
    {
        AccesoDatos datos = new AccesoDatos();
        public List<Curso> Listar(int rolUsuario)
        {
            AccesoDatos datos = new AccesoDatos();
            List<Curso> cursos = new List<Curso>();

            try
            {
                string consulta = @"
            SELECT  C.IdCurso,
        C.Titulo,
        C.Resumen,
        C.Descripcion,
        C.Precio,
        C.FechaPublicacion,
        C.Estado,
        C.IdCategoria,
        Cat.Nombre          AS NombreCategoria,
        I.IdImagen,
        I.UrlImagen         AS Url,
        I.Nombre            AS NombreImagen,
        I.IdTipoImagen      AS Tipo
FROM    Curso C
INNER JOIN Categoria  Cat ON Cat.IdCategoria = C.IdCategoria
LEFT  JOIN ImagenCurso IC  ON IC.IdCurso     = C.IdCurso
LEFT  JOIN Imagen      I   ON I.IdImagen     = IC.IdImagen
";

                if (rolUsuario != 0)
                    consulta += " WHERE C.Estado = 1";

                datos.setConsulta(consulta);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Curso curso = new Curso
                    {
                        IdCurso = (int)datos.Lector["IdCurso"],
                        Titulo = (string)datos.Lector["Titulo"],
                        Resumen = (string)datos.Lector["Resumen"],
                        Descripcion = (string)datos.Lector["Descripcion"],
                        Precio = (decimal)datos.Lector["Precio"],
                        FechaPublicacion = (DateTime)datos.Lector["FechaPublicacion"],
                        Estado = (EstadoPublicacion)datos.Lector["Estado"],
                        Categoria = new Categoria
                        {
                            IdCategoria = (int)datos.Lector["IdCategoria"],
                            Nombre = (string)datos.Lector["NombreCategoria"]
                        },

                        ImagenPortada = datos.Lector["IdImagen"] != DBNull.Value
                                        ? new Imagen
                                        {
                                            IdImagen = (int)datos.Lector["IdImagen"],
                                            Url = datos.Lector["Url"].ToString(),
                                            Nombre = datos.Lector["NombreImagen"].ToString(),
                                            Tipo = datos.Lector["Tipo"] == DBNull.Value ? 0 : (int)datos.Lector["Tipo"]
                                        }
                                        : new Imagen
                                        {
                                            IdImagen = 0,
                                            Url = "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/480px-No_image_available.svg.png",
                                            Nombre = "default",
                                            Tipo = 0
                                        }
                    };

                    cursos.Add(curso);
                }

                return cursos;
            }
            catch
            {
                throw;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }



        public Curso GetCursoPorId(int id)
        {
            AccesoDatos datos = new AccesoDatos();
            Curso curso = new Curso();

            try
            {
                datos.setConsulta(@"
            SELECT 
                C.IdCurso,
                C.Titulo,
                C.Descripcion,
                I.IdImagen,
                I.UrlImagen AS Url,
                I.Nombre AS NombreImagen,
                I.IdTipoImagen AS Tipo
            FROM Curso C
            LEFT JOIN ImagenCurso IC ON C.IdCurso = IC.IdCurso
            LEFT JOIN Imagen I ON IC.IdImagen = I.IdImagen
            WHERE C.IdCurso = @id");

                datos.setParametro("@id", id);
                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    curso.IdCurso = (int)datos.Lector["IdCurso"];
                    curso.Titulo = (string)datos.Lector["Titulo"];
                    curso.Descripcion = (string)datos.Lector["Descripcion"];

                    if (datos.Lector["IdImagen"] != DBNull.Value)
                    {
                        curso.ImagenPortada = new Imagen
                        {
                            IdImagen = (int)datos.Lector["IdImagen"],
                            Url = datos.Lector["Url"].ToString(),
                            Nombre = datos.Lector["NombreImagen"].ToString(),
                            Tipo = datos.Lector["Tipo"] == DBNull.Value ? 0 : (int)datos.Lector["Tipo"]
                        };
                    }
                    else
                    {
                        curso.ImagenPortada = new Imagen
                        {
                            IdImagen = 0,
                            Url = "https://www.aprender21.com/images/colaboradores/sql.jpeg",
                            Nombre = "default",
                            Tipo = 0
                        };
                    }
                }

                return curso;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }



        public void GuardarCurso(Curso nuevo)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                // inserta la imagen a la db y extare su Id
                datos.setConsulta(@"
            INSERT INTO Imagen (UrlImagen, Nombre, IdTipoImagen)
            VALUES (@url, @nombre, @tipo);
            SELECT SCOPE_IDENTITY();
        ");

                datos.setParametro("@url", nuevo.ImagenPortada?.Url ?? "/imagenes/default.jpg");
                datos.setParametro("@nombre", nuevo.ImagenPortada?.Nombre ?? "Imagen curso");
                datos.setParametro("@tipo", nuevo.ImagenPortada?.Tipo ?? 1);

                datos.ejecutarLectura();
                int idImagen = 0;
                if (datos.Lector.Read())
                    idImagen = Convert.ToInt32(datos.Lector[0]);

                datos.cerrarConexion();


                datos.setConsulta(@"
            INSERT INTO Curso (
                IdCategoria, Estado, Titulo, Descripcion, Resumen,
                Precio, FechaPublicacion, FechaCreacion, Duracion, Certificado)
            VALUES (
                @idcat, @estado, @titulo, @descripcion, @resumen,
                @precio, @fechaPub, @fechaCrea, @duracion, @certificado);
            SELECT SCOPE_IDENTITY();
        ");

                datos.setParametro("@idcat", nuevo.Categoria.IdCategoria);
                datos.setParametro("@estado", nuevo.Estado);
                datos.setParametro("@titulo", nuevo.Titulo);
                datos.setParametro("@descripcion", nuevo.Descripcion);
                datos.setParametro("@resumen", nuevo.Resumen);
                datos.setParametro("@precio", nuevo.Precio);
                datos.setParametro("@fechaPub", nuevo.FechaPublicacion);
                datos.setParametro("@fechaCrea", nuevo.FechaCreacion);
                datos.setParametro("@duracion", nuevo.Duracion);
                datos.setParametro("@certificado", nuevo.Certificado);

                datos.ejecutarLectura();
                if (datos.Lector.Read())
                    nuevo.IdCurso = Convert.ToInt32(datos.Lector[0]);

                datos.cerrarConexion();

                datos.setConsulta("INSERT INTO ImagenCurso (IdImagen, IdCurso) VALUES (@idimg, @idcurso)");
                datos.setParametro("@idimg", idImagen);
                datos.setParametro("@idcurso", nuevo.IdCurso);

                datos.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        /*public List<Curso> ObtenerCursosPorCategoria(int idCategoria)
        {
            AccesoDatos accesoDatos = new AccesoDatos();
            try
            {
                accesoDatos.setConsulta(@"
                SELECT 
                    c.IdCurso, 
                    c.Titulo, 
                    c.Descripcion, 
                    c.Precio, 
                    c.FechaCreacion, 
                    c.FechaPublicacion, 
                    c.EstadoPublicacion, 
                    c.Duracion, 
                    c.Certificado,
                    i.UrlImagen AS ImagenPortadaUrl
                FROM Curso c
                INNER JOIN Imagen i ON c.ImagenPortada = i.IdImagen
                WHERE c.Categoria = @idCategoria
                ");
                accesoDatos.limpiarParametros();
                accesoDatos.setParametro("@idCategoria", idCategoria);
                accesoDatos.ejecutarLectura();
                List<Curso> cursos = new List<Curso>();
                while (accesoDatos.Lector.Read())
                {
                    Curso curso = new Curso
                    {
                        IdCurso = (int)accesoDatos.Lector["IdCurso"],
                        Titulo = accesoDatos.Lector["Titulo"].ToString(),
                        Descripcion = accesoDatos.Lector["Descripcion"].ToString(),
                        Precio = (decimal)accesoDatos.Lector["Precio"],
                        FechaCreacion = (DateTime)accesoDatos.Lector["FechaCreacion"],
                        FechaPublicacion = (DateTime)accesoDatos.Lector["FechaPublicacion"],
                        Estado = (EstadoPublicacion)Enum.Parse(typeof(EstadoPublicacion), accesoDatos.Lector["EstadoPublicacion"].ToString()),
                        Duracion = (int)accesoDatos.Lector["Duracion"],
                        Certificado = (bool)accesoDatos.Lector["Certificado"],
                        ImagenPortada = new Imagen { Url = accesoDatos.Lector["ImagenPortadaUrl"].ToString() }
                    };
                    cursos.Add(curso);
                }
                return cursos;
            }
            catch (Exception ex)
            {
                throw new Exception("No se pudieron obtener los cursos por categoría", ex);
            }
            finally
            {
                accesoDatos.cerrarConexion();
            }
        }*/




        /* public Curso ObtenerCursoPorId(int id)
         {
             AccesoDatos accesoDatos = new AccesoDatos();
             try
             {
                 accesoDatos.setConsulta(@"
                 SELECT 
                     c.IdCurso, 
                     c.Titulo, 
                     c.Descripcion, 
                     c.Precio, 
                     c.FechaCreacion, 
                     c.FechaPublicacion, 
                     c.Estado, 
                     c.Duracion, 
                     c.Certificado,
                     i.UrlImagen AS ImagenPortadaUrl
                 FROM Curso c
                 INNER JOIN Imagen i ON c.ImagenPortada = i.IdImagen
                 WHERE c.IdCurso = @idCurso
                 ");
                 accesoDatos.limpiarParametros();
                 accesoDatos.setParametro("@idCurso", id);
                 accesoDatos.ejecutarLectura();
                 if (accesoDatos.Lector.Read())
                 {
                     Curso curso = new Curso
                     {
                         IdCurso = (int)accesoDatos.Lector["IdCurso"],
                         Titulo = accesoDatos.Lector["Titulo"].ToString(),
                         Descripcion = accesoDatos.Lector["Descripcion"].ToString(),
                         Precio = (decimal)accesoDatos.Lector["Precio"],
                         FechaCreacion = (DateTime)accesoDatos.Lector["FechaCreacion"],
                         FechaPublicacion = (DateTime)accesoDatos.Lector["FechaPublicacion"],
                         Estado = (EstadoPublicacion)Enum.Parse(typeof(EstadoPublicacion), accesoDatos.Lector["EstadoPublicacion"].ToString()),
                         Duracion = (int)accesoDatos.Lector["Duracion"],
                         Certificado = (bool)accesoDatos.Lector["Certificado"],
                         ImagenPortada = new Imagen { Url = accesoDatos.Lector["ImagenPortadaUrl"].ToString() }
                     };
                     return curso;
                 }
                 else
                 {
                     return null;
                 }
             }
             catch (Exception ex)
             {
                 throw new Exception("No se pudo obtener el curso por ID", ex);
             }
             finally
             {
                 accesoDatos.cerrarConexion();
             }
         }*/

        public bool EsUsuarioHabilitado(int idUsuario, int idCurso)
        {
            AccesoDatos accesoDatos = new AccesoDatos();
            try
            {
                accesoDatos.setConsulta(@"
                 SELECT 1
                 FROM Compra c
                 INNER JOIN DetalleCompra dc ON c.IdCompra = dc.IdCompra
                 WHERE c.IdUsuario = @IdUsuario AND dc.IdCurso = @IdCurso;
                 ");
                accesoDatos.limpiarParametros();
                accesoDatos.setParametro("@IdUsuario", idUsuario);
                accesoDatos.setParametro("@IdCurso", idCurso);
                accesoDatos.ejecutarLectura();
                if (accesoDatos.Lector.Read())
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al verificar si el usuario esta habilitado", ex);
            }
            finally
            {
                accesoDatos.cerrarConexion();
            }
        }

        public void AgregarCursoFavorito(int idUsuario, int idCurso)
        {

            try
            {
                DateTime fecha = DateTime.Now;

                datos.setConsulta("INSERT INTO CursoFavorito (IdUsuario, IdCurso, Agregado) VALUES (@idUsuario, @idCurso, @fecha)");
                datos.setParametro("@idUsuario", idUsuario);
                datos.setParametro("@idCurso", idCurso);
                datos.setParametro("@fecha", fecha);

                datos.ejecutarLectura();

            }
            catch (Exception ex)
            {

                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }

        }

        public CursoFavorito getCursoFavorito(int idUsuario, int idCurso)
        {
            CursoFavorito curso = new CursoFavorito();
            try
            {

                datos.setConsulta("SELECT IdUsuario, IdCurso, Agregado, Activo FROM CursoFavorito WHERE IdUsuario = @idUsuario AND IdCurso = @idCurso");
                datos.setParametro("@idUsuario", idUsuario);
                datos.setParametro("@idCurso", idCurso);

                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    curso.IdCurso = (int)datos.Lector["IdCurso"];
                    curso.IdUsuario = (int)datos.Lector["IdUsuario"];
                    curso.Agregado = (DateTime)datos.Lector["Agregado"];
                    curso.Activo = (bool)datos.Lector["Activo"];
                }
                else
                {
                    return null;
                }

                return curso;

            }
            catch (Exception ex)
            {

                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }

        }

        public void CambiarEstadoCursoFavorito(int IdUsuario, int idCurso, int estado)
        {
            try
            {
                datos.setConsulta("UPDATE CursoFavorito SET Activo = @estado WHERE IdCurso = @idCurso AND IdUsuario = @IdUsuario");

                datos.setParametro("@estado", estado);
                datos.setParametro("@idCurso", idCurso);
                datos.setParametro("@IdUsuario", IdUsuario);

                datos.ejecutarAccion();


            }
            catch (Exception ex)
            {

                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public List<Curso> ListarFavoritos()
        {
            AccesoDatos datos = new AccesoDatos();
            List<Curso> cursos = new List<Curso>();

            try
            {
                string consulta = @"
                    SELECT 
                        C.IdCurso,
                        C.Titulo,
                        C.Resumen,
                        I.IdImagen,
                        I.UrlImagen AS Url,
                        I.Nombre AS NombreImagen,
                        I.IdTipoImagen AS Tipo
                    FROM Curso C
                    LEFT JOIN ImagenCurso IC ON C.IdCurso = IC.IdCurso
                    LEFT JOIN Imagen I ON IC.IdImagen = I.IdImagen
                    LEFT JOIN CursoFavorito CF ON C.IdCurso = CF.IdCurso
                    LEFT JOIN Usuario US ON CF.IdUsuario = US.IdUsuario
                    WHERE US.IdUsuario = 3 AND CF.Activo = 1
                    ";

                datos.setConsulta(consulta);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Curso curso = new Curso();

                    curso.IdCurso = (int)datos.Lector["IdCurso"];
                    curso.Titulo = (string)datos.Lector["Titulo"];
                    curso.Resumen = (string)datos.Lector["Resumen"];

                    curso.ImagenPortada = new Imagen();

                    curso.ImagenPortada.Url = (string)datos.Lector["Url"];

                    cursos.Add(curso);
                }

                return cursos;
            }
            catch (Exception ex)
            {

                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }

        }


    }
}

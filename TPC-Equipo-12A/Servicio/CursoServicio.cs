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
        public List<Curso> Listar()
        {
            AccesoDatos datos = new AccesoDatos();
            List<Curso> cursos = new List<Curso>();
            try
            {
              
                datos.setConsulta(@"
            SELECT C.IdCurso, C.Titulo, C.Resumen, I.UrlImagen
            FROM Curso C
            LEFT JOIN ImagenCurso IC ON C.IdCurso = IC.IdCurso
            LEFT JOIN Imagen I ON IC.IdImagen = I.IdImagen ");

                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Curso curso = new Curso();
     
                    curso.IdCurso = (int)datos.Lector["IdCurso"];
                    curso.Titulo = (string)datos.Lector["Titulo"];
                    curso.Resumen = (string)datos.Lector["Resumen"];
         

                    if (datos.Lector["UrlImagen"] != DBNull.Value)
                        curso.ImagenUrl = (string)datos.Lector["UrlImagen"];
                    else
                        curso.ImagenUrl = "/imagenes/default.jpg";

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
        public Curso GetCursoPorId(int id)
        {
            AccesoDatos datos = new AccesoDatos();
            Curso curso = new Curso();
            try
            {
                datos.setConsulta(@"
            SELECT C.IdCurso, C.Titulo, C.Descripcion, I.UrlImagen
            FROM Curso C
            LEFT JOIN ImagenCurso IC ON C.IdCurso = IC.IdCurso
            LEFT JOIN Imagen I ON IC.IdImagen = I.IdImagen
            WHERE C.IdCurso = @id  ");
                datos.setParametro("@id", id);
                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    curso.IdCurso = (int)datos.Lector["IdCurso"];
                    curso.Titulo = (string)datos.Lector["Titulo"];
                    curso.Descripcion = (string)datos.Lector["Descripcion"];

                    if (datos.Lector["UrlImagen"] != DBNull.Value)
                        curso.ImagenUrl = (string)datos.Lector["UrlImagen"];
                    else
                        curso.ImagenUrl = "/imagenes/default.jpg";
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
        public void GuardarCurso(Curso nuevo, string urlImagen)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                // Insertar curso
                datos.setConsulta(@"
            INSERT INTO Curso (IdCategoria, Estado, Titulo, Descripcion, Resumen, Precio, FechaPublicacion, FechaCreacion, Duracion, Certificado)
            VALUES (@idcat, @estado, @titulo, @descripcion, @resumen, @precio, @fechaPub, @fechaCrea, @duracion, @certificado);
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

                // Insertar imagen
                datos.setConsulta("INSERT INTO Imagen (UrlImagen, Nombre, IdTipoImagen) VALUES (@url, @nombre, 1); SELECT SCOPE_IDENTITY();");
                datos.setParametro("@url", urlImagen);
                datos.setParametro("@nombre", "Imagen curso");

                datos.ejecutarLectura();
                int idImagen = 0;
                if (datos.Lector.Read())
                    idImagen = Convert.ToInt32(datos.Lector[0]);

                datos.cerrarConexion();

                // Relación ImagenCurso
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


        public List<Curso> ObtenerCursosPorCategoria(int idCategoria)
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
        }

        public Curso ObtenerCursoPorId(int id)
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
        }

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
    }
}

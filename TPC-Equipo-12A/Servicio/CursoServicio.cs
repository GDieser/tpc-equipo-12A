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

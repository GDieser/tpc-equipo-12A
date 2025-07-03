using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dominio;

namespace Servicio
{
    public class LeccionServicio
    {
        public Leccion ObtenerPorId(int id, int idUsuario)
        {
            AccesoDatos accesoDatos = new AccesoDatos();
            try
            {
                accesoDatos.setConsulta(@"
                SELECT 
                    l.IdLeccion,
                    l.Titulo, 
                    l.Introduccion,
                    l.Orden,
                    l.Contenido,
                    l.AltoVideo,
                    l.AnchoVideo,
                    l.UrlVideo,
                    l.IframeVideo,
                    m.IdModulo as IdModulo,
                    m.Titulo as NombreModulo,
                    c.IdCurso as IdCurso,
                    c.Titulo as NombreCurso,
                    c.Estado,
                    lu.EsFinalizado
                FROM Leccion l
                INNER JOIN Modulo m ON m.IdModulo=l.IdModulo
                INNER JOIN Curso c ON c.IdCurso = m.IdCurso
                LEFT JOIN LeccionUsuario lu ON lu.IdUsuario = @idUsuario AND lu.IdLeccion = l.IdLeccion
                WHERE l.IdLeccion = @idLeccion
            ");
                accesoDatos.limpiarParametros();
                accesoDatos.setParametro("@idLeccion", id);
                accesoDatos.setParametro("@idUsuario", idUsuario);
                accesoDatos.ejecutarLectura();

                if (accesoDatos.Lector.Read())
                {
                    Leccion leccion = new Leccion
                    {
                        IdLeccion = id,
                        Titulo = accesoDatos.Lector["Titulo"].ToString(),
                        Introduccion = accesoDatos.Lector["Introduccion"].ToString(),
                        Orden = Convert.ToInt32(accesoDatos.Lector["Orden"]),
                        Estado = (EstadoPublicacion)accesoDatos.Lector["Estado"],
                        Contenido = accesoDatos.Lector["Contenido"] != DBNull.Value ? accesoDatos.Lector["Contenido"].ToString() : string.Empty,
                        IdCurso = (int)accesoDatos.Lector["IdCurso"],
                        NombreCurso = accesoDatos.Lector["NombreCurso"].ToString(),
                        IdModulo = (int)accesoDatos.Lector["IdModulo"],
                        NombreModulo = accesoDatos.Lector["NombreModulo"].ToString(),
                        Completado = accesoDatos.Lector["EsFinalizado"] != DBNull.Value && (bool)accesoDatos.Lector["EsFinalizado"],


                        AltoVideo = accesoDatos.Lector["AltoVideo"] != DBNull.Value ? (int?)accesoDatos.Lector["AltoVideo"] : null,
                        AnchoVideo = accesoDatos.Lector["AnchoVideo"] != DBNull.Value ? (int?)accesoDatos.Lector["AnchoVideo"] : null,
                        UrlVideo = accesoDatos.Lector["UrlVideo"] != DBNull.Value ? accesoDatos.Lector["UrlVideo"].ToString() : "",
                        IframeVideo = accesoDatos.Lector["IframeVideo"] != DBNull.Value ? accesoDatos.Lector["IframeVideo"].ToString() : ""
                    };
                    return leccion;
                }
                else
                {
                    return null;
                }
            }
            catch (Exception ex)
            {
                throw new Exception("No se pudo cargar la leccion", ex);
            }
            finally
            {
                accesoDatos.cerrarConexion();
            }
        }

        public List<Leccion> ListarLeccionesPorModuloId(int idModulo, int idUsuario)
        {
            AccesoDatos accesoDatos = new AccesoDatos();
            try
            {
                accesoDatos.setConsulta(@"
                SELECT 
                    l.IdLeccion,
                    l.Titulo, 
                    l.Introduccion,
                    l.Contenido,
                    l.Orden,
                    c.Estado,
                    m.IdModulo as IdModulo,
                    c.IdCurso as IdCurso,
                    lu.EsFinalizado
                FROM Leccion l
                INNER JOIN Modulo m ON m.IdModulo=l.IdModulo
                INNER JOIN Curso c ON c.IdCurso = m.IdCurso
                LEFT JOIN LeccionUsuario lu ON lu.IdUsuario = @idUsuario AND lu.IdLeccion = l.IdLeccion
                WHERE l.IdModulo = @id
                ORDER BY l.Orden ASC"
                );
                accesoDatos.limpiarParametros();
                accesoDatos.setParametro("@id", idModulo);
                accesoDatos.setParametro("@idUsuario", idUsuario);
                accesoDatos.ejecutarLectura();
                List<Leccion> lecciones = new List<Leccion>();
                while (accesoDatos.Lector.Read())
                {
                    Leccion leccion = new Leccion
                    {
                        IdLeccion = (int)accesoDatos.Lector["IdLeccion"],
                        Titulo = accesoDatos.Lector["Titulo"].ToString(),
                        Introduccion = accesoDatos.Lector["Introduccion"].ToString(),
                        Contenido = accesoDatos.Lector["Contenido"].ToString(),
                        Orden = Convert.ToInt32(accesoDatos.Lector["Orden"]),
                        Estado = (EstadoPublicacion)accesoDatos.Lector["Estado"],
                        IdCurso = (int)accesoDatos.Lector["IdCurso"],
                        IdModulo = idModulo,
                        Completado = accesoDatos.Lector["EsFinalizado"] != DBNull.Value && (bool)accesoDatos.Lector["EsFinalizado"]
                    };
                    lecciones.Add(leccion);
                }
                return lecciones;
            }
            catch (Exception ex)
            {
                throw new Exception("Error al cargar las lecciones", ex);
            }
            finally
            {
                accesoDatos.cerrarConexion();
            }
        }

        public bool EsUsuarioHabilitado(int idUsuario, int idLeccion)
        {
            AccesoDatos accesoDatos = new AccesoDatos();
            try
            {
                accesoDatos.setConsulta(@"
                SELECT 1
                FROM Compra c
                INNER JOIN DetalleCompra dc ON c.IdCompra = dc.IdCompra
                INNER JOIN Curso cu ON cu.IdCurso = dc.IdCurso
                INNER JOIN Modulo m ON m.IdCurso = cu.IdCurso
                INNER JOIN Leccion l ON l.IdModulo = m.IdModulo
                WHERE c.IdUsuario = @IdUsuario AND l.IdLeccion = @IdLeccion;
                ");
                accesoDatos.limpiarParametros();
                accesoDatos.setParametro("@IdUsuario", idUsuario);
                accesoDatos.setParametro("@IdLeccion", idLeccion);
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

        public bool MarcarCompletada(int idLeccion, int idUsuario)
        {
            AccesoDatos accesoDatos = new AccesoDatos();
            try
            {
                accesoDatos.setConsulta(@"
                INSERT INTO LeccionUsuario (IdLeccion, IdUsuario, EsFinalizado, Finalizado)
                VALUES (@IdLeccion, @IdUsuario, 1, GETDATE())
                ");
                accesoDatos.limpiarParametros();
                accesoDatos.setParametro("@IdLeccion", idLeccion);
                accesoDatos.setParametro("@IdUsuario", idUsuario);
                int filasAfectadas = accesoDatos.ejecutarNonQuery();
                return filasAfectadas > 0;
            }
            catch (Exception ex)
            {
                throw new Exception("Error al marcar la leccion como leida", ex);
            }
        }

        public void ActualizarOCrear(Leccion leccion, bool EsPrimerCarga = false)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.limpiarParametros();
                datos.setParametro("@IdModulo", leccion.IdModulo);
                datos.setParametro("@Titulo", leccion.Titulo);
                datos.setParametro("@Introduccion", leccion.Introduccion);
                datos.setParametro("@Orden", leccion.Orden);

                if (!EsPrimerCarga)
                {
                    datos.setParametro("@Contenido", leccion.Contenido ?? (object)DBNull.Value);
                    datos.setParametro("@AltoVideo", leccion.AltoVideo ?? (object)DBNull.Value);
                    datos.setParametro("@AnchoVideo", leccion.AnchoVideo ?? (object)DBNull.Value);
                    datos.setParametro("@UrlVideo", leccion.UrlVideo ?? (object)DBNull.Value);
                    datos.setParametro("@IframeVideo", leccion.IframeVideo ?? (object)DBNull.Value);
                }

                if (leccion.IdLeccion > 0)
                {
                    datos.setParametro("@IdLeccion", leccion.IdLeccion);

                    if (!EsPrimerCarga)
                    {
                        datos.setConsulta(@"
                    UPDATE Leccion 
                    SET Titulo = @Titulo, Introduccion = @Introduccion, 
                        Orden = @Orden, IdModulo = @IdModulo,
                        Contenido = @Contenido,
                        AltoVideo = @AltoVideo, AnchoVideo = @AnchoVideo, UrlVideo = @UrlVideo, IframeVideo = @IframeVideo
                    WHERE IdLeccion = @IdLeccion");
                    }
                    else
                    {
                        datos.setConsulta(@"
                    UPDATE Leccion 
                    SET Titulo = @Titulo, Introduccion = @Introduccion, 
                        Orden = @Orden, IdModulo = @IdModulo
                    WHERE IdLeccion = @IdLeccion");
                    }
                }
                else
                {
                    datos.setConsulta(@"
                INSERT INTO Leccion (IdModulo, Titulo, Introduccion, Orden, Contenido, AltoVideo, AnchoVideo, UrlVideo, IframeVideo) 
                VALUES (@IdModulo, @Titulo, @Introduccion, @Orden, @Contenido, @AltoVideo, @AnchoVideo, @UrlVideo, @IframeVideo)");

                    // En el INSERT sí se cargan todos los parámetros, sin importar EsPrimerCarga
                    datos.setParametro("@Contenido", leccion.Contenido ?? (object)DBNull.Value);
                    datos.setParametro("@AltoVideo", leccion.AltoVideo ?? (object)DBNull.Value);
                    datos.setParametro("@AnchoVideo", leccion.AnchoVideo ?? (object)DBNull.Value);
                    datos.setParametro("@UrlVideo", leccion.UrlVideo ?? (object)DBNull.Value);
                    datos.setParametro("@IframeVideo", leccion.IframeVideo ?? (object)DBNull.Value);
                }

                datos.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw new Exception("Error al guardar la lección", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        internal List<LeccionDTO> ObtenerLeccionesDTOPorIdModulo(int idModulo)
        {
            AccesoDatos accesoLeccion = new AccesoDatos();
            try
            {
                accesoLeccion.setConsulta(@"
                    SELECT 
                        l.IdModulo,
                        l.IdLeccion,
                        l.Titulo
                    FROM Leccion l
                    WHERE l.IdModulo = @idModulo
                    ORDER BY l.Orden ASC"
                    );
                accesoLeccion.limpiarParametros();
                accesoLeccion.setParametro("@idModulo", idModulo);
                accesoLeccion.ejecutarLectura();

                List<LeccionDTO> lecciones = new List<LeccionDTO>();
                while (accesoLeccion.Lector.Read())
                {
                    LeccionDTO leccion = new LeccionDTO
                    {
                        IdLeccion = (int)accesoLeccion.Lector["IdLeccion"],
                        IdModulo = (int)accesoLeccion.Lector["IdModulo"],
                        Titulo = accesoLeccion.Lector["Titulo"].ToString(),
                        UrlLeccion = $"Leccion.aspx?id={(int)accesoLeccion.Lector["IdLeccion"]}"
                    };
                    lecciones.Add(leccion);
                }
                return lecciones;
            }
            catch (Exception ex)
            {
                throw new Exception("Error al cargar las lecciones:", ex);
            }
            finally
            {
                accesoLeccion.cerrarConexion();
            }
        }

        public List<LeccionDTO> ListaDeIdLecciones(int idLeccion)
        {
            AccesoDatos datos = new AccesoDatos();

            List<LeccionDTO> lecciones = new List<LeccionDTO>();

            try
            {
                int idModulo = 0;

                datos.setConsulta("select IdModulo from Leccion where IdLeccion = @idLeccion");
                datos.limpiarParametros();

                datos.setParametro("@idLeccion", idLeccion);
                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    idModulo = (int)datos.Lector["IdModulo"];
                }

                datos.cerrarConexion();

                datos.setConsulta("select IdLeccion, Orden from Leccion where IdModulo = @idModulo");
                datos.limpiarParametros();

                datos.setParametro("@idModulo", idModulo);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    LeccionDTO aux = new LeccionDTO();

                    aux.IdLeccion = (int)datos.Lector["IdLeccion"];
                    aux.Orden = (int)datos.Lector["Orden"];

                    lecciones.Add(aux);
                }

                return lecciones;
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

        public void Eliminar(int id)
        {
            AccesoDatos accesoDatos = new AccesoDatos();
            try
            {
                accesoDatos.limpiarParametros();
                accesoDatos.setConsulta(@"DELETE FROM LeccionUsuario WHERE IdLeccion = @IdLeccion;
                                          DELETE FROM Leccion WHERE IdLeccion = @IdLeccion;");
                accesoDatos.setParametro("@IdLeccion", id);
                accesoDatos.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw new Exception("Error al borrar la leccion:", ex);
            }
            finally
            {
                accesoDatos.cerrarConexion();
            }
        }

    }
}
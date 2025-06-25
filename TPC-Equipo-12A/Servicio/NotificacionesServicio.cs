using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dominio;

namespace Servicio
{
    public class NotificacionesServicio
    {
        AccesoDatos datos = new AccesoDatos();

        public int ContarNoVistas(int idAdmin)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setConsulta("SELECT COUNT(*) FROM NotificacionAdmin WHERE Visto = 0 AND IdAdministrador = @id");
                datos.setParametro("@id", idAdmin);
                datos.ejecutarLectura();

                if (datos.Lector.Read())
                    return (int)datos.Lector[0];
                return 0;
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

        public List<Notificacion> ListarComentarios(int idAdmin, bool soloNuevas)
        {
            List<Notificacion> lista = new List<Notificacion>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                string consulta = @"SELECT N.IdNotificacion, C.Contenido, P.Titulo, C.TipoOrigen, C.IdOrigen, C.FechaCreacion, 
                                   U.NombreUsuario, N.Visto
                            FROM NotificacionAdmin N
                            INNER JOIN Comentario C ON C.IdComentario = N.IdComentario
                            INNER JOIN Usuario U ON U.IdUsuario = C.IdUsuario
                            INNER JOIN Publicacion P ON P.IdPublicacion = C.IdOrigen
                            WHERE N.IdAdministrador = @idadmin AND EsReporte = 0 AND C.EsEliminado = 0
                            ";

                if (soloNuevas)
                    consulta += "AND N.Visto = 0 ";

                consulta += "ORDER BY N.IdNotificacion DESC";

                datos.setConsulta(consulta);
                datos.setParametro("@idadmin", idAdmin);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Notificacion n = new Notificacion();
                    n.IdNotificacion = (int)datos.Lector["IdNotificacion"];
                    n.Contenido = (string)datos.Lector["Contenido"];
                    n.TituloPublicacion = (string)datos.Lector["Titulo"];
                    n.NombreUsuario = (string)datos.Lector["NombreUsuario"];
                    n.TipoOrigen = (string)datos.Lector["TipoOrigen"];
                    n.IdOrigen = (int)datos.Lector["IdOrigen"];
                    n.Fecha = (DateTime)datos.Lector["FechaCreacion"];
                    n.Visto = (bool)datos.Lector["Visto"];

                    lista.Add(n);
                }

                return lista;
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

        public List<Notificacion> ListarReportes(int idAdmin, bool soloNuevas)
        {
            List<Notificacion> lista = new List<Notificacion>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                string consulta = @"
                                   SELECT 
                                       N.IdNotificacion,
                                       C.Contenido,
                                       P.Titulo,
                                       C.TipoOrigen,
                                       C.IdOrigen,
                                       C.FechaCreacion,
                                       U.NombreUsuario AS UsuarioComentario,
                                       UR.NombreUsuario AS UsuarioReporte,
                                       N.Visto,
                                       N.MotivoReporte
                                   FROM NotificacionAdmin N
                                   INNER JOIN Comentario C ON C.IdComentario = N.IdComentario
                                   INNER JOIN Usuario U ON U.IdUsuario = C.IdUsuario
                                   LEFT JOIN Usuario UR ON UR.IdUsuario = N.IdUsuarioReportador
                                   INNER JOIN Publicacion P ON P.IdPublicacion = C.IdOrigen
                                   WHERE N.IdAdministrador = @idadmin AND EsReporte = 1 AND C.EsEliminado = 0";

                if (soloNuevas)
                    consulta += "AND N.Visto = 0 ";

                consulta += "ORDER BY N.IdNotificacion DESC";

                datos.setConsulta(consulta);
                datos.setParametro("@idadmin", idAdmin);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Notificacion n = new Notificacion();
                    n.IdNotificacion = (int)datos.Lector["IdNotificacion"];
                    n.Contenido = (string)datos.Lector["Contenido"];
                    n.TituloPublicacion = (string)datos.Lector["Titulo"];
                    n.NombreUsuario = (string)datos.Lector["UsuarioComentario"];
                    n.NombreUsuarioReportador = (string)datos.Lector["UsuarioReporte"];
                    n.TipoOrigen = (string)datos.Lector["TipoOrigen"];
                    n.IdOrigen = (int)datos.Lector["IdOrigen"];
                    n.Fecha = (DateTime)datos.Lector["FechaCreacion"];
                    n.Visto = (bool)datos.Lector["Visto"];
                    n.EsReporte = true;
                    n.MotivoReporte = (string)datos.Lector["MotivoReporte"];

                    lista.Add(n);
                }

                return lista;
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

        public void MarcarComoVista(int idNotificacion)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setConsulta("UPDATE NotificacionAdmin SET Visto = 1 WHERE IdNotificacion = @id");
                datos.setParametro("@id", idNotificacion);
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

        public void EnviarNotificacion(Notificacion notificacion)
        {
            try
            {
                datos.setConsulta("SELECT TOP 1 IdUsuario FROM Usuario WHERE IdRol = 0");
                datos.ejecutarLectura();

                int idAdmin = 0;

                if (datos.Lector.Read())
                {
                    idAdmin = (int)datos.Lector["IdUsuario"];
                }

                datos.cerrarConexion();
                datos.limpiarParametros();

                datos.setConsulta(@"INSERT INTO 
                                    NotificacionAdmin
                                    (IdComentario, FechaNotificacion, IdAdministrador, EsReporte, MotivoReporte, IdUsuarioReportador) 
                                    VALUES (@idcomentario, GETDATE(), @idadmin, @reporte, @motivo, @idusuario)");

                datos.setParametro("@idcomentario", notificacion.IdOrigen);
                datos.setParametro("@idadmin", idAdmin);
                datos.setParametro("@reporte", notificacion.EsReporte);
                datos.setParametro("@motivo", notificacion.MotivoReporte);
                datos.setParametro("@idusuario", notificacion.IdUsuarioReportador);

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


    }
}

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

        public int ContarNoVistas(int idUsuario, bool EsAdmin = true)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                if(EsAdmin)
                {
                    datos.setConsulta("SELECT COUNT(*) FROM NotificacionAdmin WHERE Visto = 0 AND IdAdministrador = @id");
                    datos.setParametro("@id", idUsuario);
                    datos.ejecutarLectura();

                    if (datos.Lector.Read())
                        return (int)datos.Lector[0];
                    return 0;

                }
                else
                {
                    datos.setConsulta("SELECT COUNT(*) FROM NotificacionEstudiante WHERE Visto = 0 AND IdEstudiante = @id");
                    datos.setParametro("@id", idUsuario);
                    datos.ejecutarLectura();

                    if (datos.Lector.Read())
                        return (int)datos.Lector[0];
                    return 0;
                }
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

                datos.setProcedimiento(@"sp_ListarNotificacionesComentarios");

                datos.setParametro("@IdAdmin", idAdmin);
                datos.setParametro("@SoloNuevas", soloNuevas);
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

        public List<NotificacionDTO> ListaNotificaciones(int IdUsuario)
        {
            List<NotificacionDTO> lista = new List<NotificacionDTO>();
            try
            {
                datos.setConsulta(@"SELECT N.IdNotificacion, U.NombreUsuario, C.IdOrigen FROM NotificacionEstudiante N 
                                    INNER JOIN Comentario C ON C.IdComentario = N.IdComentario 
                                    INNER JOIN Usuario U ON U.IdUsuario = C.IdUsuario 
                                    WHERE IdEstudiante = @IdUsuario AND Visto = 0 
                                    ORDER BY FechaNotificacion DESC");

                datos.limpiarParametros();
                datos.setParametro("@IdUsuario", IdUsuario);

                datos.ejecutarLectura();

                while(datos.Lector.Read())
                {
                    NotificacionDTO aux = new NotificacionDTO();

                    aux.IdNotificacion = (int)datos.Lector["IdNotificacion"];
                    aux.NombreUsuario = datos.Lector["NombreUsuario"].ToString();
                    aux.IdOrigen = (int)datos.Lector["IdOrigen"];

                    lista.Add(aux);
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

        public void MarcarNotificacionVista(int IdEstudiante, int IdNotifiacion)
        {
            try
            {
                datos.setConsulta("UPDATE NotificacionEstudiante SET Visto = 1 WHERE IdEstudiante = @IdEstudiante AND IdNotificacion = @IdNotifiacion");

                datos.limpiarParametros();
                datos.setParametro("@IdEstudiante", IdEstudiante);
                datos.setParametro("@IdNotifiacion", IdNotifiacion);

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

        public List<Notificacion> ListarReportes(int idAdmin, bool soloNuevas)
        {
            List<Notificacion> lista = new List<Notificacion>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setProcedimiento(@"sp_ListarNotificacionesReportes");

                datos.setParametro("@IdAdmin", idAdmin);
                datos.setParametro("@SoloNuevas", soloNuevas);
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
                    n.TipoOrigen = (string)datos.Lector["TipoOrigen"];

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

        public void AgregarNotificacionEstudiante(Comentario comentario, int idComentario)
        {
            
            try
            {
                int idOrigen = comentario.IdOrigen;

                datos.setConsulta("SELECT IdUsuario FROM Debate WHERE IdDebate = @idOrigen");

                datos.limpiarParametros();
                datos.setParametro("@idOrigen", idOrigen);
                datos.ejecutarLectura();

                int IdUsuario = 0;

                if(datos.Lector.Read())
                {
                    IdUsuario = (int)datos.Lector["IdUsuario"];
                }
                datos.cerrarConexion();

                if(IdUsuario != comentario.IdUsuario)
                {
                    datos.setConsulta("INSERT INTO NotificacionEstudiante(IdComentario, IdEstudiante) VALUES(@idComentario, @IdUsuario) ");

                    datos.limpiarParametros();
                    datos.setParametro("@idComentario", idComentario);
                    datos.setParametro("@IdUsuario", IdUsuario);

                    datos.ejecutarAccion();
                }


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

                datos.setProcedimiento("sp_InsertarNotificacionAdmin");

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

        public void OcurltarLeidos()
        {
            try
            {
                datos.setConsulta("UPDATE NotificacionAdmin SET Oculto = 1 WHERE Visto = 1 ");
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

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
            catch(Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public List<Notificacion> Listar(int idAdmin, bool soloNuevas)
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
                            WHERE N.IdAdministrador = @idadmin
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

        public void MarcarComoVista(int idNotificacion)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setConsulta("UPDATE NotificacionAdmin SET Visto = 1 WHERE IdNotificacion = @id");
                datos.setParametro("@id", idNotificacion);
                datos.ejecutarAccion();
            }
            finally
            {
                datos.cerrarConexion();
            }
        }


    }
}

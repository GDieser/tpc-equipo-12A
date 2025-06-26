using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Remoting.Messaging;
using System.Text;
using System.Threading.Tasks;
using Dominio;

namespace Servicio
{

    public class ComentarioServicio
    {
        AccesoDatos datos = new AccesoDatos();


        public List<Comentario> ListarPorOrigen(int idOrigen)
        {
            try
            {
                List<Comentario> lista = new List<Comentario>();

                datos.setProcedimiento(@"sp_ObtenerComentariosPorOrigen");

                datos.setParametro("@IdOrigen", idOrigen);

                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {

                    Comentario comentario = new Comentario();


                    comentario.IdComentario = (int)datos.Lector["IdComentario"];
                    comentario.IdUsuario = (int)datos.Lector["IdUsuario"];
                    comentario.TipoOrigen = datos.Lector["TipoOrigen"].ToString();
                    comentario.IdOrigen = (int)datos.Lector["IdOrigen"];
                    comentario.IdComentarioPadre = datos.Lector["IdComentarioPadre"] == DBNull.Value ? null : (int?)datos.Lector["IdComentarioPadre"];
                    comentario.Contenido = datos.Lector["Contenido"].ToString();
                    comentario.FechaCreacion = (DateTime)datos.Lector["FechaCreacion"];
                    comentario.FechaEdicion = datos.Lector["FechaEdicion"] == DBNull.Value ? null : (DateTime?)datos.Lector["FechaEdicion"];
                    comentario.EsEditado = (bool)datos.Lector["EsEditado"];
                    comentario.NombreUsuario = datos.Lector["NombreUsuario"].ToString();
                    comentario.UrlImagen = datos.Lector["UrlImagen"].ToString();



                    lista.Add(comentario);
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


        public void AgregarComentario(Comentario comentario)
        {
            try
            {
                

                datos.setProcedimiento(@"sp_InsertarComentario");

                datos.setParametro("@IdUsuario", comentario.IdUsuario);
                datos.setParametro("@TipoOrigen", comentario.TipoOrigen);
                datos.setParametro("@IdOrigen", comentario.IdOrigen);
                datos.setParametro("@IdComentarioPadre", comentario.IdComentarioPadre ?? (object)DBNull.Value);
                datos.setParametro("@Contenido", comentario.Contenido);

                datos.ejecutarLectura();

                int idNuevoComentario = 0;
                if (datos.Lector.Read())
                    idNuevoComentario = Convert.ToInt32(datos.Lector[0]);

                datos.cerrarConexion();
                datos.limpiarParametros();

                datos.setConsulta("SELECT TOP 1 IdUsuario FROM Usuario WHERE IdRol = 0");
                datos.ejecutarLectura();

                int idAdmin = 0;

                if(datos.Lector.Read())
                {
                    idAdmin = (int)datos.Lector["IdUsuario"];
                }

                datos.cerrarConexion();
                datos.limpiarParametros();

                datos.setConsulta("INSERT INTO NotificacionAdmin (IdComentario, FechaNotificacion, IdAdministrador) VALUES (@idComentario, GETDATE(), @idAdmin)");
                datos.setParametro("@idComentario", idNuevoComentario);
                datos.setParametro("@idAdmin", idAdmin); // Acá deberíamos ver quien es el admin por defecto... (listooo)
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

        public void EliminarComentario(int idComentario)
        {
            try
            {
                datos.setConsulta("UPDATE Comentario SET EsEliminado = 1, Visible = 0 WHERE IdComentario = @idComentario");
                datos.setParametro("@idComentario", idComentario);
                datos.ejecutarAccion();

                datos.cerrarConexion();
                datos.limpiarParametros();

                datos.setConsulta("UPDATE Comentario SET EsEliminado = 1, Visible = 0 WHERE IdComentarioPadre = @idComentario");
                datos.setParametro("@idComentario", idComentario);
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


        public void ModificarComentario(int idComentario, string contenido)
        {
            try
            {
                datos.setConsulta("UPDATE Comentario SET FechaEdicion = GETDATE(), EsEditado = 1, Contenido = @contenido WHERE IdComentario = @idComentario");
                datos.setParametro("@idComentario", idComentario);
                datos.setParametro("@contenido", contenido);
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

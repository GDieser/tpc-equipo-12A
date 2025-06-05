using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dominio;

namespace Servicio
{
    public class ImagenServicio
    {

        public List<Imagen> getImagenesIdArticulo(int id)
        {
            List<Imagen> imagenes = new List<Imagen>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setConsulta("SELECT IdImagen FROM ImagenPublicacion WHERE IDPublicacion = @id;");
                datos.limpiarParametros();
                datos.setParametro("@id", id);
                datos.ejecutarLectura();

                datos.Lector.Read();
                int idImagen = (int)datos.Lector["IdImagen"];
                datos.cerrarConexion();

                datos.setConsulta("SELECT UrlImagen, IdTipoImagen FROM Imagen WHERE IdImagen = @idImagen;");
                datos.limpiarParametros();
                datos.setParametro("@idImagen", idImagen);
                datos.ejecutarLectura();


                while (datos.Lector.Read())
                {
                    Imagen im = new Imagen();

                    im.Url = (string)datos.Lector["UrlImagen"];
                    im.Tipo = (int)datos.Lector["IdTipoImagen"];

                    imagenes.Add(im);
                }
                return imagenes;
            }
            catch (Exception)
            {

                throw;
            }
            finally
            {
                datos.cerrarConexion();
            }

        }
    }

}


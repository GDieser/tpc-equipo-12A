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

                datos.setConsulta("SELECT IdImagen, UrlImagen, IdTipoImagen FROM Imagen WHERE IdImagen = @idimg;");
                datos.limpiarParametros();
                datos.setParametro("@idimg", idImagen);
                datos.ejecutarLectura();


                while (datos.Lector.Read())
                {
                    Imagen im = new Imagen();

                    im.IdImagen = (int)datos.Lector["IdImagen"];
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

        public int agregarImagen(Imagen imagen)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setConsulta(@"INSERT INTO Imagen (UrlImagen, IdTipoImagen) 
                                    VALUES (@url, @tipo);
                                    SELECT SCOPE_IDENTITY();");
                datos.limpiarParametros();
                datos.setParametro("@url", imagen.Url);
                datos.setParametro("@tipo", imagen.Tipo);
                datos.ejecutarLectura();
                int idImagen;
                if (datos.Lector.Read())
                {
                    idImagen = Convert.ToInt32(datos.Lector[0]);
                    return idImagen;
                }
                else
                {
                    throw new Exception("No se pudo obtener el ID de la imagen insertada.");
                }
            }
            catch (Exception)
            {
                throw new Exception("No se pudo guardar la imagen.");
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }

}


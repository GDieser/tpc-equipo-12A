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

        public List<Imagen> getImagenesIdArticulo(int idPublicacion)
        {
            List<Imagen> imagenes = new List<Imagen>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setConsulta(@"
            SELECT I.IdImagen, I.UrlImagen, I.IdTipoImagen, I.Nombre
            FROM ImagenPublicacion IP
            INNER JOIN Imagen I ON IP.IdImagen = I.IdImagen
            WHERE IP.IdPublicacion = @id
        ");
                datos.limpiarParametros();
                datos.setParametro("@id", idPublicacion);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Imagen im = new Imagen
                    {
                        IdImagen = (int)datos.Lector["IdImagen"],
                        Url = (string)datos.Lector["UrlImagen"],
                        Tipo = (int)datos.Lector["IdTipoImagen"],
                        Nombre = (string)datos.Lector["Nombre"]
                    };

                    imagenes.Add(im);
                }

                return imagenes;
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener imágenes de la publicación: " + ex.Message);
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
                datos.setConsulta(@"INSERT INTO Imagen (UrlImagen, IdTipoImagen, Nombre) 
                                    VALUES (@url, @tipo, @nombre);
                                    SELECT SCOPE_IDENTITY();");
                datos.limpiarParametros();
                datos.setParametro("@url", imagen.Url);
                datos.setParametro("@tipo", imagen.Tipo);
                datos.setParametro("@nombre", imagen.Nombre);
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


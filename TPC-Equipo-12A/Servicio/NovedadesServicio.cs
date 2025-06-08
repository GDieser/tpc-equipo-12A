using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using Dominio;

namespace Servicio
{
    public class NovedadesServicio
    {
        AccesoDatos datos = new AccesoDatos();
        public List<Publicacion> listar()
        {
            List<Publicacion> publicaciones = new List<Publicacion>();

            ImagenServicio im = new ImagenServicio();

            try
            {
                datos.setConsulta("SELECT IdPublicacion, IdCategoria, IdImagen, Titulo, Descripcion, Resumen, FechaCreacion, FechaPublicacion, Estado FROM Publicacion;");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Publicacion pub = new Publicacion();

                    Imagen img = new Imagen();

                    pub.IdPublicacion = (int)datos.Lector["IdPublicacion"];
                    
                    pub.Titulo = (string)datos.Lector["Titulo"];
                    pub.Descripcion = (string)datos.Lector["Descripcion"];
                    pub.Resumen = (string)datos.Lector["Resumen"];
                    pub.FechaCreacion = (DateTime)datos.Lector["FechaCreacion"];
                    pub.FechaPublicacion = (DateTime)datos.Lector["FechaPublicacion"];
                    //pub.Estado = (EstadoPublicacion)datos.Lector["Estado"];

                    int idImagen = (int)datos.Lector["IdImagen"];

                    pub.Imagenes = im.getImagenesIdArticulo(pub.IdPublicacion);
                    
                    publicaciones.Add(pub);
                }



                return publicaciones;

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

        public Publicacion GetPublicacion(int id)
        {
            Publicacion publicacion = new Publicacion();
            ImagenServicio im = new ImagenServicio();
            Imagen img = new Imagen();

            try
            {
                datos.setConsulta("SELECT IdPublicacion, IdCategoria, IdImagen, Titulo, Descripcion, Resumen, FechaCreacion, FechaPublicacion, Estado FROM Publicacion WHERE IdPublicacion = @id;");
                datos.setParametro("@id", id);
                datos.ejecutarLectura();

                datos.Lector.Read();

                publicacion.IdPublicacion = (int)datos.Lector["IdPublicacion"];

                publicacion.Titulo = (string)datos.Lector["Titulo"];
                publicacion.Descripcion = (string)datos.Lector["Descripcion"];
                publicacion.Resumen = (string)datos.Lector["Resumen"];
                publicacion.FechaCreacion = (DateTime)datos.Lector["FechaCreacion"];
                publicacion.FechaPublicacion = (DateTime)datos.Lector["FechaPublicacion"];
                //pub.Estado = (EstadoPublicacion)datos.Lector["Estado"];

                int idImagen = (int)datos.Lector["IdImagen"];

                publicacion.Imagenes = im.getImagenesIdArticulo(publicacion.IdPublicacion);


                return publicacion;
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

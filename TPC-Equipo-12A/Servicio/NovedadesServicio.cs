using System;
using System.Collections.Generic;
using System.Collections.Specialized;
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
                datos.setConsulta("SELECT IdPublicacion, P.IdCategoria, C.Nombre Nombre, Titulo, Descripcion, Resumen, FechaCreacion, FechaPublicacion, Estado FROM Publicacion P, Categoria C WHERE C.IdCategoria = P.IdCategoria;");
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

                    pub.Categoria = new Categoria();
                    pub.Categoria.IdCategoria = (int)datos.Lector["IdCategoria"];
                    pub.Categoria.Nombre = (string)datos.Lector["Nombre"];

                    pub.Estado = (EstadoPublicacion)Convert.ToInt32(datos.Lector["Estado"]);

                    // int idImagen = (int)datos.Lector["IdImagen"];

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
                datos.setConsulta("SELECT IdPublicacion, IdCategoria, Titulo, Descripcion, Resumen, FechaCreacion, FechaPublicacion, Estado FROM Publicacion WHERE IdPublicacion = @id;");
                datos.setParametro("@id", id);
                datos.ejecutarLectura();

                datos.Lector.Read();

                publicacion.IdPublicacion = (int)datos.Lector["IdPublicacion"];

                publicacion.Titulo = (string)datos.Lector["Titulo"];
                publicacion.Descripcion = (string)datos.Lector["Descripcion"];
                publicacion.Resumen = (string)datos.Lector["Resumen"];
                publicacion.FechaCreacion = (DateTime)datos.Lector["FechaCreacion"];
                publicacion.FechaPublicacion = (DateTime)datos.Lector["FechaPublicacion"];

                publicacion.Categoria = new Categoria();
                publicacion.Categoria.IdCategoria = (int)datos.Lector["IdCategoria"];
                //Debe ser int no bit
                //publicacion.Estado = (EstadoPublicacion)((int)datos.Lector["Estado"]);
                publicacion.Estado = (EstadoPublicacion)Convert.ToInt32(datos.Lector["Estado"]);

                //int idImagen = (int)datos.Lector["IdImagen"];

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

        public void agregar(Publicacion nueva)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setConsulta("INSERT INTO Publicacion(IdCategoria, Titulo, Descripcion, Resumen, FechaCreacion, FechaPublicacion, Estado) VALUES (@idcategoria, @titulo, @descripcion, @resumen, @fechacreacion, @fechapublicacion, @estado); SELECT SCOPE_IDENTITY()");
                datos.setParametro("@idcategoria", nueva.Categoria.IdCategoria);
                //datos.setParametro("@idimagen", nueva.);
                datos.setParametro("@titulo", nueva.Titulo);
                datos.setParametro("@descripcion", nueva.Descripcion);
                datos.setParametro("@resumen", nueva.Resumen);
                datos.setParametro("@fechacreacion", nueva.FechaCreacion);
                datos.setParametro("@fechapublicacion", nueva.FechaPublicacion);
                datos.setParametro("@estado", nueva.Estado);

                datos.ejecutarLectura();

                if (datos.Lector.Read())
                    nueva.IdPublicacion = Convert.ToInt32(datos.Lector[0]);

                datos.cerrarConexion();

                datos.setConsulta("INSERT INTO Imagen(UrlImagen, Nombre, IdTipoImagen) VALUES (@url, '', 1); SELECT SCOPE_IDENTITY()");
                datos.setParametro("@url", nueva.Url);

                datos.ejecutarLectura();

                int idImagen = 0;

                if (datos.Lector.Read())
                    idImagen = Convert.ToInt32(datos.Lector[0]);

                datos.cerrarConexion();


                datos.setConsulta("INSERT INTO ImagenPublicacion(IdImagen, IDPublicacion) VALUES (@idurl, @idpublicacion);");
                datos.setParametro("@idurl", idImagen);
                datos.setParametro("@idpublicacion", nueva.IdPublicacion);

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

        public void modificarPublicacion(Publicacion publi)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setConsulta("UPDATE Publicacion SET IdCategoria = @idcategoria, Titulo = @titulo, Descripcion = @descripcion, Resumen = @resumen, Estado = @estado WHERE IdPublicacion = @id");

                datos.setParametro("@id", publi.IdPublicacion);
                datos.setParametro("@idcategoria", publi.Categoria.IdCategoria);
                
                datos.setParametro("@titulo", publi.Titulo);
                datos.setParametro("@descripcion", publi.Descripcion);
                datos.setParametro("@resumen", publi.Resumen);
                datos.setParametro("@estado", publi.Estado);

                datos.ejecutarLectura();
                datos.cerrarConexion();

                int idImg = publi.Imagenes[0].IdImagen;

                datos.setConsulta("UPDATE Imagen SET UrlImagen = @url WHERE IdImagen = @idimagen");
                datos.setParametro("@idimagen", idImg);
                datos.setParametro("@url", publi.Url);

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

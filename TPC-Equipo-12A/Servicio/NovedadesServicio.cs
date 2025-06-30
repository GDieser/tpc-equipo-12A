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
        public List<Publicacion> ListarPublicaciones()
        {
            List<Publicacion> publicaciones = new List<Publicacion>();

            ImagenServicio im = new ImagenServicio();

            try
            {
                datos.setProcedimiento("sp_ListarPublicaciones");

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

                    pub.Categoria = new Categoria
                    {
                        IdCategoria = (int)datos.Lector["IdCategoria"],
                        Nombre = !(bool)datos.Lector["ActivoCategoria"] ? "Sin Categoría" : (string)datos.Lector["NombreCategoria"],
                        Activo = (bool)datos.Lector["ActivoCategoria"]
                    };


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
                datos.setProcedimiento("sp_ObtenerPublicacionPorId");

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

        public void AgregarPublicacion(Publicacion nueva)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setProcedimiento("sp_InsertarPublicacion");

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

                foreach(var img in nueva.Imagenes)
                {

                    datos.setConsulta("INSERT INTO Imagen(UrlImagen, Nombre, IdTipoImagen) VALUES (@url, @nombre, 1); SELECT SCOPE_IDENTITY()");
                    datos.limpiarParametros();
                    datos.setParametro("@url", img.Url);
                    datos.setParametro("@nombre", img.Nombre);


                    datos.ejecutarLectura();

                    int idImagen = 0;

                    if (datos.Lector.Read())
                        idImagen = Convert.ToInt32(datos.Lector[0]);

                    datos.cerrarConexion();


                    datos.setConsulta("INSERT INTO ImagenPublicacion(IdImagen, IDPublicacion) VALUES (@idurl, @idpublicacion);");
                    datos.limpiarParametros();
                    datos.setParametro("@idurl", idImagen);
                    datos.setParametro("@idpublicacion", nueva.IdPublicacion);

                    datos.ejecutarAccion();

                    datos.cerrarConexion();
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

        public void modificarPublicacion(Publicacion publi)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setProcedimiento("sp_ActualizarPublicacion");

                datos.setParametro("@id", publi.IdPublicacion);
                datos.setParametro("@idcategoria", publi.Categoria.IdCategoria);
                
                datos.setParametro("@titulo", publi.Titulo);
                datos.setParametro("@descripcion", publi.Descripcion);
                datos.setParametro("@resumen", publi.Resumen);
                datos.setParametro("@estado", publi.Estado);

                datos.ejecutarLectura();
                datos.cerrarConexion();

                

                foreach (var imagen in publi.Imagenes)
                {
                    int idImg = imagen.IdImagen;

                    datos.setConsulta("UPDATE Imagen SET UrlImagen = @url WHERE IdImagen = @idimagen");
                    datos.limpiarParametros();

                    datos.setParametro("@idimagen", idImg);
                    datos.setParametro("@url", imagen.Url);

                    datos.ejecutarAccion();

                    datos.cerrarConexion();
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

        public List<Publicacion> BuscarPorTitulo(string palabra, int rolUsuario = 0)
        {
            List<Publicacion> publicaciones = new List<Publicacion>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setConsulta(@"
        SELECT P.IdPublicacion, P.Titulo, P.Resumen,
               C.IdCategoria, C.Nombre AS NombreCategoria, C.Activo AS ActivoCategoria,
               I.IdImagen, I.UrlImagen, I.Nombre AS NombreImagen
        FROM Publicacion P
        INNER JOIN Categoria C ON C.IdCategoria = P.IdCategoria
        LEFT JOIN ImagenPublicacion IP ON IP.IDPublicacion = P.IdPublicacion
        LEFT JOIN Imagen I ON I.IdImagen = IP.IdImagen
        WHERE P.Titulo COLLATE Latin1_General_CI_AI LIKE @q
          AND (@RolUsuario = 0 OR P.Estado = 1)
        ");

                datos.setParametro("@q", "%" + palabra + "%");
                datos.setParametro("@RolUsuario", rolUsuario);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    var pub = new Publicacion
                    {
                        IdPublicacion = (int)datos.Lector["IdPublicacion"],
                        Titulo = datos.Lector["Titulo"].ToString(),
                        Resumen = datos.Lector["Resumen"].ToString(),
                        Categoria = new Categoria
                        {
                            IdCategoria = (int)datos.Lector["IdCategoria"],
                            Nombre = datos.Lector["ActivoCategoria"] != DBNull.Value && !(bool)datos.Lector["ActivoCategoria"]
                                ? "Sin Categoría"
                                : datos.Lector["NombreCategoria"].ToString(),
                            Activo = datos.Lector["ActivoCategoria"] != DBNull.Value && (bool)datos.Lector["ActivoCategoria"]
                        },
                        Imagenes = new List<Imagen>()
                    };

                    if (datos.Lector["IdImagen"] != DBNull.Value)
                    {
                        pub.Imagenes.Add(new Imagen
                        {
                            IdImagen = (int)datos.Lector["IdImagen"],
                            Url = datos.Lector["UrlImagen"].ToString(),
                            Nombre = datos.Lector["NombreImagen"].ToString()
                        });
                    }

                    publicaciones.Add(pub);
                }

                return publicaciones;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }


    }
}

using System;
using System.Collections.Generic;
using System.Diagnostics.Eventing.Reader;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dominio;

namespace Servicio
{
    public static class AutenticarUsuario
    {

        public static UsuarioAutenticado login(string nombreUsuario, string password)
        {
            try
            {
                AccesoDatos datos = new AccesoDatos();
                datos.setConsulta(@"SELECT u.IdUsuario, u.Nombre, u.Apellido, u.IdRol, u.NombreUsuario, 
                                u.Habilitado, i.IdImagen, i.UrlImagen, i.nombre as nombreImagen
                                FROM Usuario u 
                                LEFT JOIN Imagen i ON u.FotoPerfil = i.IdImagen
                                WHERE u.NombreUsuario = @nombreUsuario 
                                AND u.Pass = @password");
                datos.setParametro("@nombreUsuario", nombreUsuario);
                datos.setParametro("@password", password);

                datos.ejecutarLectura();

                if (!datos.Lector.Read())
                {
                    return null;
                }

                UsuarioAutenticado usuario = new UsuarioAutenticado();

                usuario.IdUsuario = (int)datos.Lector["IdUsuario"];
                usuario.Nombre = (string)datos.Lector["Nombre"];
                usuario.Apellido = (string)datos.Lector["Apellido"];
                usuario.Rol = (Rol)datos.Lector["IdRol"];
                usuario.NombreUsuario = (string)datos.Lector["NombreUsuario"];
                usuario.Habilitado = (bool)datos.Lector["Habilitado"];

                if (datos.Lector["UrlImagen"] != DBNull.Value && datos.Lector["IdImagen"] != DBNull.Value)
                {
                    usuario.FotoPerfil = new Imagen
                    {
                        IdImagen = (int)datos.Lector["IdImagen"],
                        Nombre = datos.Lector["nombreImagen"].ToString(),
                        Url = datos.Lector["UrlImagen"].ToString()
                    };
                }

                return usuario;

            }
            catch (Exception)
            {
                return null;
                throw;
            }
        }

    }
}

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
                datos.setConsulta(@"SELECT u.IdUsuario, u.Nombre, u.Apellido, u.Rol, u.NombreUsuario, 
                                u.Habilitado, i.IdImagen, i.Url, i.nombre as nombreImagen
                                FROM Usuarios u 
                                INNER JOIN Imagenes i ON Usuarios.IdUsuario = Imagenes.IdUsuario
                                WHERE NombreUsuario = @nombreUsuario 
                                AND Password = @password");
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
                usuario.Rol = (Rol)datos.Lector["Rol"];
                usuario.NombreUsuario = (string)datos.Lector["NombreUsuario"];
                usuario.Habilitado = (bool)datos.Lector["Habilitado"];

                usuario.FotoPerfil = new Imagen
                {
                    Nombre = (string)datos.Lector["nombreImagen"],
                    IdImagen = (int)datos.Lector["IdImagen"],
                    Url = (string)datos.Lector["Url"]
                };

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

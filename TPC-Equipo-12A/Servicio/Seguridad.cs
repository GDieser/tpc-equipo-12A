using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dominio;

namespace Servicio
{
    public static class Seguridad
    {

        public static bool sesionActiva(object user)
        {
            UsuarioAutenticado usuario = user != null ? (UsuarioAutenticado)user : null;

            if (usuario != null && usuario.IdUsuario != 0)
            {
                return true;
            }
            else
            {
                return false;
            }

        }

        public static bool esAdmin(object user)
        {
            UsuarioAutenticado usuario = user != null ? (UsuarioAutenticado)user : null;
            return usuario != null ? usuario.Rol == 0 : false;
        }

    }
}

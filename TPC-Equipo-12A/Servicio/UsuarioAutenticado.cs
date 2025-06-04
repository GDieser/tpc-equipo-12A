using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dominio;

namespace Servicio
{
    public class UsuarioAutenticado
    {
        public int IdUsuario { get; set; }
        public string Nombre { get; set; }
        public string Apellido { get; set; }
        public Rol Rol { get; set; }
        public string NombreUsuario { get; set; }
        public bool Habilitado { get; set; }
        public Imagen FotoPerfil { get; set; }
    }
}

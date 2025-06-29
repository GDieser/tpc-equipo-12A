using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Debate
    {
        public int IdDebate { get; set; }
        public int IdUsuario { get; set; }
        public int? IdOrigen { get; set; }
        public string Titulo { get; set; }
        public string Contenido { get; set; }
        public DateTime FechaCreacion { get; set; }
        public DateTime? FechaEdicion { get; set; }
        public bool EsEditado { get; set; } = false;
        public bool EsAviso { get; set; } = false;
        public bool Activo { get; set; } = true;
        public string NombreUsuario { get; set; }
        public string Nombre { get; set; }
        public string Apellido { get; set; }
        public string UrlImagen { get; set; }

    }
}

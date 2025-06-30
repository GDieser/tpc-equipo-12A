using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class DebateDTO
    {
        public int IdDebate {  get; set; }
        public string Titulo { get; set; }
        public string UrlImagen { get; set; }
        public DateTime FechaCreacion { get; set; }
        public string NombreUsuario { get; set; }
        public int CantidadComentarios { get; set; }
    }
}

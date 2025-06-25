using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    [Serializable]
    public class Comentario
    {
        public int IdComentario { get; set; }
        public int IdUsuario { get; set; }
        public string TipoOrigen { get; set; }
        public int IdOrigen { get; set; }
        public int? IdComentarioPadre { get; set; }
        public string Contenido { get; set; }
        public DateTime FechaCreacion { get; set; }
        public DateTime? FechaEdicion { get; set; }
        public bool EsEditado { get; set; }
        public string NombreUsuario { get; set; }
        public string UrlImagen { get; set; }

        public List<Comentario> Respuestas { get; set; }
    }
}

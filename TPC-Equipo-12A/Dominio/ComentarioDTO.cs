using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class ComentarioDTO
    {
        public string Comentario {  get; set; }
        public DateTime FechaCreacion { get; set; }
        public string TipoOrigen { get; set; }

    }
}

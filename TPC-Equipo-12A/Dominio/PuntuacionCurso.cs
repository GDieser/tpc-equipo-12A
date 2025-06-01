using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class PuntuacionCurso : InteraccionCurso
    {
        public int Puntuacion { get; set; }
        public string Comentario { get; set; }
        public bool Visible { get; set; }
    }
}

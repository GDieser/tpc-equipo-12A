using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class InteraccionCurso
    {
        public Usuario Usuario { get; set; }
        public Curso Curso { get; set; }
        public DateTime FechaAgregado { get; set; }
    }
}

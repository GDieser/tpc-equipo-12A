using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Modulo
    {
        public int IdModulo { get; set; }
        public int IdCurso { get; set; }
        public string Titulo { get; set; }
        public string Introduccion { get; set; }
        public int Orden { get; set; }
        public Imagen imagen { get; set; } = new Imagen();
        public List<Leccion> Lecciones { get; set; } = new List<Leccion>();

    }
}

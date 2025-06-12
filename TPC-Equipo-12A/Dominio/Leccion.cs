using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Leccion
    {
        public int IdLeccion { get; set; }
        public string Titulo { get; set; }
        public string Introduccion { get; set; }
        public int Orden { get; set; }
        public EstadoPublicacion Estado { get; set; }
        public int IdCurso { get; set; }
        public int IdModulo { get; set; }

        public List<Componente> Componentes { get; set; } = new List<Componente>();
    }
}

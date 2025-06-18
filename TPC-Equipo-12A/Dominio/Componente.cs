using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Componente

    {
        public int IdComponente { get; set; }
        public int IdLeccion { get; set; }
        public string Titulo { get; set; }
        public string Contenido { get; set; }
        public TipoContenido TipoContenido { get; set; }
        public int Orden { get; set; }

    }
}

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
        public string Contenido { get; set; }
        public int Orden { get; set; }
        public EstadoPublicacion Estado { get; set; }
        public int IdCurso { get; set; }
        public string NombreCurso { get; set; }

        public int IdModulo { get; set; }
        public string NombreModulo { get; set; }
        public bool Completado { get; set; }


        //Para videos de yt
        public int AltoVideo { get; set; }
        public int AnchoVideo { get; set; }
        public string UrlVideo { get; set; }
        public string IframeVideo { get; set; }
    }
}

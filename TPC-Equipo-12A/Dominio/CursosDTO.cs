using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class CursoDTO
    {
        public int IdCurso { get; set; }
        public int TotalLecciones { get; set; }
        public int LeccionesCompletadas { get; set; }
        public string NombreCurso { get; set; }
        public string UrlImagen { get; set; }
        public string UrlCurso { get; set; }
        public List<ModuloDTO> Modulos { get; set; }

        public int PorcentajeCompletado
        {
            get
            {
                if (TotalLecciones == 0) return 0;
                return (int)Math.Round((LeccionesCompletadas * 100.0) / TotalLecciones);
            }
        }

    }

    public class ModuloDTO
    {
        public int IdModulo { get; set; }
        public int IdCurso { get; set; }
        public string NombreModulo { get; set; }
        public string UrlModulo { get; set; }
        public List<LeccionDTO> Lecciones { get; set; }
    }

    public class LeccionDTO
    {
        public int IdLeccion { get; set; }
        public int IdModulo { get; set; }
        public string Titulo { get; set; }
        public string UrlLeccion { get; set; }
    }

}

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
        public string NombreCurso { get; set; }
        public string UrlCurso { get; set; }
        public List<ModuloDTO> Modulos { get; set; }
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

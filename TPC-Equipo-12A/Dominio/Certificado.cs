using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class CertificadoDTO
    {
        public string IdCertificado { get; set; }
        public int IdCurso { get; set; }
        public int IdUsuario { get; set; }
        public DateTime FechaEmision { get; set; }
        public string NombreCurso { get; set; } 
    }
}

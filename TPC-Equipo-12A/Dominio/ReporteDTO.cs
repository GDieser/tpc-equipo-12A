using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class ReporteDTO
    {
        public string MotivoReporte { get; set; }
        public DateTime FechaNotificacion { get; set; }
        public string Contenido { get; set; }
        public string NombreUsuario { get; set; }
    }
}

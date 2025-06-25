using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Notificacion
    {
        public int IdNotificacion { get; set; }
        public string Contenido { get; set; }
        public string TituloPublicacion { get; set; }
        public string TipoOrigen { get; set; }
        public int IdOrigen { get; set; }
        public DateTime Fecha { get; set; }
        public string NombreUsuario { get; set; }
        public bool Visto { get; set; }

        //Para las notif de los reportes
        public bool EsReporte { get; set; }
        public string MotivoReporte { get; set; }

        public int IdUsuarioReportador { get; set; }
        public string NombreUsuarioReportador { get; set; }
    }
}

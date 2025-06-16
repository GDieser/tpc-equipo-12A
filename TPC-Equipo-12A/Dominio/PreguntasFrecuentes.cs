using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class PreguntasFrecuentes
    {
        public int IdFaq {  get; set; }
        public string Pregunta { get; set; }
        public string Respuesta { get; set; }
        public bool Activo { get; set; }
    }
}

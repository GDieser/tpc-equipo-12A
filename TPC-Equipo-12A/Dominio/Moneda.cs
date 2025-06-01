using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Moneda
    {
        public string Nombre { get; set; }
        public string Simbolo { get; set; }
        public float TasaCambio { get; set; }
        public Moneda(string nombre, string simbolo, float tasaCambio)
        {
            Nombre = nombre;
            Simbolo = simbolo;
            TasaCambio = tasaCambio;
        }
    }
}

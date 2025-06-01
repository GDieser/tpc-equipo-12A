using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Compra
    {
        public int IdCompra { get; set; }
        public Carrito Carrito { get; set; }
        public DateTime FechaCompra { get; set; }
        public MedioPago MedioPago { get; set; }
        public Estado Estado { get; set; }
        public string CodigoTransaccion { get; set; }
    }
}

using System;

namespace Dominio
{
    public class Compra
    {
        public int IdCompra { get; set; }
        public Carrito Carrito { get; set; }
        public DateTime FechaCompra { get; set; }
        public EstadoCarrito Estado { get; set; }
        public string CodigoTransaccion { get; set; }
    }
}

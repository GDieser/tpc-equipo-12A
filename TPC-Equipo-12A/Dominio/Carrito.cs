using System;
using System.Collections.Generic;

namespace Dominio
{
    public class Carrito
    {
        public int IdCarrito { get; set; }
        public Usuario Usuario { get; set; }
        public DateTime FechaCreacion { get; set; }
        public Estado Estado { get; set; }
        public decimal Monto { get; set; }
        public string Nota { get; set; }
        public List<CarritoCurso> CarritoCursos { get; set; } = new List<CarritoCurso>();
    }
}

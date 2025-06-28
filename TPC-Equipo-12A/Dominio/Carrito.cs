using System;
using System.Collections.Generic;

namespace Dominio
{
    public class Carrito
    {
        public int IdCarrito { get; set; }
        public int IdUsuario { get; set; }
        public DateTime FechaCreacion { get; set; }
        public EstadoCarrito Estado { get; set; }
        public DateTime UltimaModificacion { get; set; }
        public decimal MontoTotal { get; set; }
        public string IDOperacion { get; set; }
        public List<CarritoCurso> CarritoCursos { get; set; } = new List<CarritoCurso>();
    }
}

using System;

namespace Dominio
{
    public class CompraCurso
    {
        public Usuario Usuario { get; set; }
        public Curso Curso { get; set; }
        public Compra compra { get; set; }
        public DateTime FechaCompra { get; set; }
    }
}

using System;

namespace Dominio
{
    public class CompraCursoDTO
    {
        public string NombreCurso { get; set; }
        public DateTime FechaCompra { get; set; }
        public Decimal Monto { get; set; }
    }
}
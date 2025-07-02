using System;

namespace Dominio
{
    public class CompraCursoDTO
    {
        public int IdCurso { get; set; }
        public int IdCompra { get; set; }
        public string NombreCurso { get; set; }
        public DateTime FechaCompra { get; set; }
        public Decimal Monto { get; set; }
    }
}
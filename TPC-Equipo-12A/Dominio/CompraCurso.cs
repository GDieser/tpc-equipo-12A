﻿using System;

namespace Dominio
{
    public class CompraCurso
    {
        public Curso Curso { get; set; }
        public Compra Compra { get; set; }
        public DateTime FechaCompra { get; set; }
        public Decimal Monto { get; set; }
    }
}

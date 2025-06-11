using System;
using System.Collections.Generic;

namespace Dominio
{
    public class Curso
    {
        public int IdCurso { get; set; }
        public Imagen ImagenPortada { get; set; }
        public int IdMoodle { get; set; }
        public string Titulo { get; set; }
        public string Descripcion { get; set; }
        public string Resumen { get; set; }
        public Categoria Categoria { get; set; }
        public decimal Precio { get; set; }
        public DateTime FechaCreacion { get; set; }
        public DateTime FechaPublicacion { get; set; }
        public EstadoPublicacion Estado { get; set; }
        public int Duracion { get; set; }
        public bool Certificado { get; set; }

        //public string UrlMoodle { get; set; }
        public List<Modulo> Modulos { get; set; } = new List<Modulo>();
    }
}

using System;

namespace Dominio
{
    internal class Publicacion
    {
        public int IdPublicacion { get; set; }
        public string Titulo { get; set; }
        public string Contenido { get; set; }
        public string Resumen { get; set; }
        public Categoria Categoria { get; set; }
        public DateTime FechaPublicacion { get; set; }
        public DateTime FechaCreacion { get; set; }
        public EstadoPublicacion Estado { get; set; }
        public Imagen Imagen { get; set; }

    }
}

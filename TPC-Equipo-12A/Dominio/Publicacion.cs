using System;
using System.Collections.Generic;

namespace Dominio
{
    public class Publicacion
    {
        public int IdPublicacion { get; set; }
        public string Titulo { get; set; }
        public string Descripcion { get; set; }
        public string Resumen { get; set; }
        public Categoria Categoria { get; set; }
        public DateTime FechaPublicacion { get; set; }
        public DateTime FechaCreacion { get; set; }
        public EstadoPublicacion Estado { get; set; }
        public List<Imagen> Imagenes { get; set; }
        public string Url { get; set; } 
        public string UrlImagen => Imagenes != null && Imagenes.Count > 0 ? Imagenes[0].Url : null;

    }
}

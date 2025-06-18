using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class CursoFavorito
    {
        public int IdCurso {  get; set; }
        public int IdUsuario { get; set; }
        public DateTime Agregado { get; set; }

        public bool Activo { get; set; }
    }
}

using System;
using System.Collections.Generic;

namespace Dominio
{
    public class Usuario
    {
        public int IdUsuario { get; set; }
        public int IdUsuarioMoodle { get; set; }
        public string Nombre { get; set; }
        public string Apellido { get; set; }
        public string Email { get; set; }
        public Rol Rol { get; set; }
        public string Celular { get; set; }
        public DateTime FechaNacimiento { get; set; }
        public string NombreUsuario { get; set; }
        public string Pass { get; set; }
        public bool Habilitado { get; set; }
        public Imagen FotoPerfil { get; set; }
        public List<Curso> Favoritos { get; set; } = new List<Curso>();
        public List<Curso> CursosInscriptos { get; set; } = new List<Curso>();
    }
}

﻿using System;
using System.Collections.Generic;

namespace Dominio
{
    public class Usuario
    {
        public int IdUsuario { get; set; }
        public string Nombre { get; set; }
        public string Apellido { get; set; }
        public string Email { get; set; }
        public Rol Rol { get; set; }
        public string Celular { get; set; }
        public DateTime? FechaNacimiento { get; set; }
        public string NombreUsuario { get; set; }
        public string Pass { get; set; }
        public bool Habilitado { get; set; }
        public Imagen FotoPerfil { get; set; }
        public string TokenValidacion { get; set; }
        public bool EmailValidado { get; set; } = false;
        public DateTime? FechaRegistro { get; set; } = DateTime.Now;
        public bool RecuperoContrasenia { get; set; } = false;
        public int CursosAdquiridos { get; set; } = 0;
        public List<Curso> Favoritos { get; set; } = new List<Curso>();
        public List<Curso> Cursos { get; set; } = new List<Curso>();
        public List<Leccion> LeccionesCompletadas { get; set; } = new List<Leccion>();

    }
}

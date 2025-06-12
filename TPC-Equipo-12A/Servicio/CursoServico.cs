using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using Dominio;


namespace Servicio
{
    public class CursoServicio
    {
        AccesoDatos datos = new AccesoDatos();

        public List<Curso> Listar()
        {
            List<Curso> cursos = new List<Curso>();
            try
            {
                datos.setConsulta("SELECT C.Id, C.Titulo, C.Resumen, C.ImagenUrl FROM Cursos C; ");

                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Curso curso = new Curso();
                    curso.IdCurso = (int)datos.Lector["Id"];
                    curso.Titulo = (string)datos.Lector["Titulo"];
                    curso.Resumen = (string)datos.Lector["Resumen"];
                    curso.ImagenUrl = (string)datos.Lector["ImagenUrl"];


                    cursos.Add(curso);
                }

                return cursos;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    
    public  Curso GetCursoPorId(int id)
        {
                    Curso curso = new Curso();
            try
            {
                datos.setConsulta("SELECT C.Id, C.Titulo, C.Descripcion, C.ImagenUrl FROM Cursos C WHERE C.Id = @id");
                datos.setParametro("@id", id);
                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    curso.IdCurso = (int)datos.Lector["Id"];
                    curso.Titulo = (string)datos.Lector["Titulo"];
                    curso.Descripcion = (string)datos.Lector["Descripcion"];
                    curso.ImagenUrl = (string)datos.Lector["ImagenUrl"];
                }

                return curso;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

    }
}
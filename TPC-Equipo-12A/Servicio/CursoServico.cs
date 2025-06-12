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
                datos.setConsulta(@"
            SELECT C.IdCurso, C.Titulo, C.Resumen, I.UrlImagen
            FROM Curso C
            LEFT JOIN ImagenCurso IC ON C.IdCurso = IC.IdCurso
            LEFT JOIN Imagen I ON IC.IdImagen = I.IdImagen ");

                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Curso curso = new Curso();
                    curso.IdCurso = (int)datos.Lector["IdCurso"];
                    curso.Titulo = (string)datos.Lector["Titulo"];
                    curso.Resumen = (string)datos.Lector["Resumen"];

                    if (datos.Lector["UrlImagen"] != DBNull.Value)
                        curso.ImagenUrl = (string)datos.Lector["UrlImagen"];
                    else
                        curso.ImagenUrl = "/imagenes/default.jpg"; 

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

        public Curso GetCursoPorId(int id)
        {
            Curso curso = new Curso();
            try
            {
                datos.setConsulta(@"
            SELECT C.IdCurso, C.Titulo, C.Descripcion, I.UrlImagen
            FROM Curso C
            LEFT JOIN ImagenCurso IC ON C.IdCurso = IC.IdCurso
            LEFT JOIN Imagen I ON IC.IdImagen = I.IdImagen
            WHERE C.IdCurso = @id  ");
                datos.setParametro("@id", id);
                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    curso.IdCurso = (int)datos.Lector["IdCurso"];
                    curso.Titulo = (string)datos.Lector["Titulo"];
                    curso.Descripcion = (string)datos.Lector["Descripcion"];

                    if (datos.Lector["UrlImagen"] != DBNull.Value)
                        curso.ImagenUrl = (string)datos.Lector["UrlImagen"];
                    else
                        curso.ImagenUrl = "/imagenes/default.jpg";
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
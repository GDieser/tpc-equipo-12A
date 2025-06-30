using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dominio;

namespace Servicio
{
    public class DebateServicio
    {
        AccesoDatos datos = new AccesoDatos();

        public List<DebateDTO> ListarDebates(int IdOrigen, int EsAviso = 0)
        {
            List<DebateDTO> lista = new List<DebateDTO>();
            try
            {
                datos.setConsulta(@"SELECT 
                                    D.IdDebate,
                                    D.Titulo,
                                    D.FechaCreacion,
                                    U.NombreUsuario,
                                    COUNT(C.IdComentario) AS CantidadComentarios,
                                    I.UrlImagen
                                FROM Debate D
                                INNER JOIN Usuario U ON U.IdUsuario = D.IdUsuario
                                INNER JOIN Imagen I ON U.FotoPerfil = I.IdImagen
                                LEFT JOIN Comentario C 
                                    ON C.TipoOrigen = 'debates' 
                                    AND C.IdOrigen = D.IdDebate 
                                    AND C.EsEliminado = 0
                                WHERE D.Activo = 1 AND D.IdOrigen = @IdOrigen AND EsAviso = @EsAviso
                                GROUP BY D.Titulo, D.FechaCreacion, U.NombreUsuario, I.UrlImagen, D.IdDebate;");


                datos.limpiarParametros();
                datos.setParametro("@IdOrigen", IdOrigen);
                datos.setParametro("@EsAviso", EsAviso);

                datos.ejecutarLectura();
                while (datos.Lector.Read())
                {
                    DebateDTO aux = new DebateDTO
                    {
                        IdDebate = (int)datos.Lector["IdDebate"],
                        Titulo = datos.Lector["Titulo"].ToString(),
                        UrlImagen = datos.Lector["UrlImagen"].ToString(),
                        FechaCreacion = (DateTime)datos.Lector["FechaCreacion"],
                        NombreUsuario = datos.Lector["NombreUsuario"].ToString(),
                        CantidadComentarios = (int)datos.Lector["CantidadComentarios"]
                    };

                    lista.Add(aux);
                }

                return lista;
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

        public void GuardarDebate(Debate debate)
        {
            try
            {

                datos.setConsulta(@"INSERT INTO Debate(IdUsuario, IdOrigen, Titulo, Contenido, EsAviso) 
                                    VALUES(@IdUsuario, @IdOrigen, @Titulo, @Contenido, @EsAviso)");

                datos.limpiarParametros();

                datos.setParametro("@IdUsuario", debate.IdUsuario);
                datos.setParametro("@IdOrigen", debate.IdOrigen);
                datos.setParametro("@Titulo", debate.Titulo);
                datos.setParametro("@Contenido", debate.Contenido);
                datos.setParametro("@EsAviso", debate.EsAviso);

                datos.ejecutarAccion();


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

        public Debate GetDebatePorId(int idDebate)
        {
            Debate debate = new Debate();
            try
            {
                datos.setConsulta(@"SELECT
                                    D.IdUsuario,
                                    D.IdDebate,
                                    D.IdOrigen,
                                    D.Titulo,
                                	D.Contenido,
                                    D.FechaCreacion,
                                    D.EsAviso,
                                    U.NombreUsuario,
                                	U.Nombre,
                                	U.Apellido,
                                	I.UrlImagen
                                FROM Debate D
                                INNER JOIN Usuario U ON U.IdUsuario = D.IdUsuario
                                INNER JOIN Imagen I ON U.FotoPerfil = I.IdImagen
                                WHERE D.Activo = 1 AND D.IdDebate = @idDebate");

                datos.limpiarParametros();
                datos.setParametro("@idDebate", idDebate);

                datos.ejecutarLectura();

                if(datos.Lector.Read())
                {
                    debate.IdUsuario = (int)datos.Lector["IdUsuario"]; 
                    debate.IdDebate = (int)datos.Lector["IdDebate"];
                    debate.IdOrigen = (int)datos.Lector["IdOrigen"];
                    debate.Titulo = datos.Lector["Titulo"].ToString();
                    debate.Contenido = datos.Lector["Contenido"].ToString();
                    debate.FechaCreacion = (DateTime)datos.Lector["FechaCreacion"];
                    debate.EsAviso = (bool)datos.Lector["EsAviso"];
                    debate.NombreUsuario = datos.Lector["NombreUsuario"].ToString();
                    debate.Nombre = datos.Lector["Nombre"].ToString();
                    debate.Apellido = datos.Lector["Apellido"].ToString();
                    debate.UrlImagen = datos.Lector["UrlImagen"].ToString();
                }



                return debate;
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

        public void EliminarDebate(int idDebate)
        {
            try
            {
                datos.setConsulta("UPDATE Debate SET Activo = 0 WHERE IdDebate = @idDebate");
                datos.setParametro("@idDebate", idDebate);
                datos.ejecutarAccion();

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

        public void EditarDebate(int idDebate, string nuevoTitulo, string nuevoContenido)
        {
            try
            {
                datos.setConsulta("UPDATE Debate SET Titulo = @nuevoTitulo, Contenido = @nuevoContenido, FechaEdicion = GETDATE(), EsEditado = 1 WHERE IdDebate = @idDebate");
                datos.setParametro("@idDebate", idDebate);
                datos.setParametro("@nuevoTitulo", nuevoTitulo);
                datos.setParametro("@nuevoContenido", nuevoContenido);

                datos.ejecutarAccion();
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

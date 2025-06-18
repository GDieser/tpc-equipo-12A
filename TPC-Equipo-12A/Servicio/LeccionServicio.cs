using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dominio;

namespace Servicio
{
    public class LeccionServicio
    {
        public Leccion ObtenerPorId(int id, int idUsuario)
        {
            AccesoDatos accesoDatos = new AccesoDatos();
            try
            {
                accesoDatos.setConsulta(@"
                SELECT 
                    l.IdLeccion,
                    l.Titulo, 
                    l.Introduccion,
                    l.Orden,
                    m.IdModulo as IdModulo,
                    c.IdCurso as IdCurso,
                    c.Estado,
                    lu.EsFinalizado
                FROM Leccion l
                INNER JOIN Modulo m ON m.IdModulo=l.IdModulo
                INNER JOIN Curso c ON c.IdCurso = m.IdCurso
                LEFT JOIN LeccionUsuario lu ON lu.IdUsuario = @idUsuario AND lu.IdLeccion = l.IdLeccion
                WHERE l.IdLeccion = @idLeccion
            ");
                accesoDatos.limpiarParametros();
                accesoDatos.setParametro("@idLeccion", id);
                accesoDatos.setParametro("@idUsuario", idUsuario);
                accesoDatos.ejecutarLectura();

                if (accesoDatos.Lector.Read())
                {
                    Leccion leccion = new Leccion
                    {
                        IdLeccion = id,
                        Titulo = accesoDatos.Lector["Titulo"].ToString(),
                        Introduccion = accesoDatos.Lector["Introduccion"].ToString(),
                        Orden = Convert.ToInt32(accesoDatos.Lector["Orden"]),
                        Estado = (EstadoPublicacion)accesoDatos.Lector["Estado"],
                        IdCurso = (int)accesoDatos.Lector["IdCurso"],
                        IdModulo = (int)accesoDatos.Lector["IdModulo"],
                        Completado = accesoDatos.Lector["EsFinalizado"] != DBNull.Value && (bool)accesoDatos.Lector["EsFinalizado"]
                    };
                    ComponenteServicio cs = new ComponenteServicio();
                    leccion.Componentes = cs.ListarComponentesPorLeccionId(id);
                    return leccion;
                }
                else
                {
                    return null;
                }
            }
            catch (Exception ex)
            {
                throw new Exception("No se pudo cargar la leccion", ex);
            }
            finally
            {
                accesoDatos.cerrarConexion();
            }
        }

        public List<Leccion> ListarLeccionesPorModuloId(int idModulo, int idUsuario)
        {
            AccesoDatos accesoDatos = new AccesoDatos();
            try
            {
                accesoDatos.setConsulta(@"
                SELECT 
                    l.IdLeccion,
                    l.Titulo, 
                    l.Introduccion,
                    l.Orden,
                    c.Estado,
                    m.IdModulo as IdModulo,
                    c.IdCurso as IdCurso,
                    lu.EsFinalizado
                FROM Leccion l
                INNER JOIN Modulo m ON m.IdModulo=l.IdModulo
                INNER JOIN Curso c ON c.IdCurso = m.IdCurso
                LEFT JOIN LeccionUsuario lu ON lu.IdUsuario = @idUsuario AND lu.IdLeccion = l.IdLeccion
                WHERE l.IdModulo = @id");
                accesoDatos.limpiarParametros();
                accesoDatos.setParametro("@id", idModulo);
                accesoDatos.setParametro("@idUsuario", idUsuario);
                accesoDatos.ejecutarLectura();
                List<Leccion> lecciones = new List<Leccion>();
                while (accesoDatos.Lector.Read())
                {
                    Leccion leccion = new Leccion
                    {
                        IdLeccion = (int)accesoDatos.Lector["IdLeccion"],
                        Titulo = accesoDatos.Lector["Titulo"].ToString(),
                        Introduccion = accesoDatos.Lector["Introduccion"].ToString(),
                        Orden = Convert.ToInt32(accesoDatos.Lector["Orden"]),
                        Estado = (EstadoPublicacion)accesoDatos.Lector["Estado"],
                        IdCurso = (int)accesoDatos.Lector["IdCurso"],
                        IdModulo = idModulo,
                        Completado = accesoDatos.Lector["EsFinalizado"] != DBNull.Value && (bool)accesoDatos.Lector["EsFinalizado"]
                    };
                    lecciones.Add(leccion);
                }
                return lecciones;
            }
            catch (Exception ex)
            {
                throw new Exception("Error al cargar las lecciones", ex);
            }
            finally
            {
                accesoDatos.cerrarConexion();
            }
        }

        public bool EsUsuarioHabilitado(int idUsuario, int idLeccion)
        {
            AccesoDatos accesoDatos = new AccesoDatos();
            try
            {
                accesoDatos.setConsulta(@"
                SELECT 1
                FROM Compra c
                INNER JOIN DetalleCompra dc ON c.IdCompra = dc.IdCompra
                INNER JOIN Curso cu ON cu.IdCurso = dc.IdCurso
                INNER JOIN Modulo m ON m.IdCurso = cu.IdCurso
                INNER JOIN Leccion l ON l.IdModulo = m.IdModulo
                WHERE c.IdUsuario = @IdUsuario AND l.IdLeccion = @IdLeccion;
                ");
                accesoDatos.limpiarParametros();
                accesoDatos.setParametro("@IdUsuario", idUsuario);
                accesoDatos.setParametro("@IdLeccion", idLeccion);
                accesoDatos.ejecutarLectura();
                if (accesoDatos.Lector.Read())
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al verificar si el usuario esta habilitado", ex);
            }
            finally
            {
                accesoDatos.cerrarConexion();
            }
        }

        public bool MarcarCompletada(int idLeccion, int idUsuario)
        {
            AccesoDatos accesoDatos = new AccesoDatos();
            try
            {
                accesoDatos.setConsulta(@"
                INSERT INTO LeccionUsuario (IdLeccion, IdUsuario, EsFinalizado, Finalizado)
                VALUES (@IdLeccion, @IdUsuario, 1, GETDATE())
                ");
                accesoDatos.limpiarParametros();
                accesoDatos.setParametro("@IdLeccion", idLeccion);
                accesoDatos.setParametro("@IdUsuario", idUsuario);
                int filasAfectadas = accesoDatos.ejecutarNonQuery();
                return filasAfectadas > 0;
            }
            catch (Exception ex)
            {
                throw new Exception("Error al marcar la leccion como leida", ex);
            }
        }

        public void ActualizarOCrear(Leccion leccion)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.limpiarParametros();
                datos.setParametro("@IdModulo", leccion.IdModulo);
                datos.setParametro("@Titulo", leccion.Titulo);
                datos.setParametro("@Introduccion", leccion.Introduccion);
                datos.setParametro("@Orden", leccion.Orden);

                if (leccion.IdLeccion > 0)
                {
                    datos.setParametro("@IdLeccion", leccion.IdLeccion);
                    datos.setConsulta(@"UPDATE Leccion 
                                SET Titulo = @Titulo, Introduccion = @Introduccion, 
                                    Orden = @Orden, IdModulo = @IdModulo 
                                WHERE IdLeccion = @IdLeccion");
                }
                else
                {
                    datos.setConsulta(@"INSERT INTO Leccion (IdModulo, Titulo, Introduccion, Orden) 
                                VALUES (@IdModulo, @Titulo, @Introduccion, @Orden)");
                }

                datos.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw new Exception("Error al guardar la lección", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
}
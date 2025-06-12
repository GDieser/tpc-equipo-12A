using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dominio;

namespace Servicio
{
    public class ModuloServicio
    {
        public Modulo ObtenerModuloPorId(int id)
        {
            AccesoDatos accesoDatos = new AccesoDatos();
            try
            {
                accesoDatos.setConsulta(@"
                SELECT 
                    m.IdModulo, 
                    m.Titulo, 
                    m.Introduccion, 
                    m.Orden,
                    c.Estado
                FROM Modulo m
                INNER JOIN Curso c ON c.IdCurso = m.IdCurso
                WHERE m.IdModulo = @idModulo
                ");
                accesoDatos.limpiarParametros();
                accesoDatos.setParametro("@idModulo", id);
                accesoDatos.ejecutarLectura();
                if (accesoDatos.Lector.Read())
                {
                    Modulo modulo = new Modulo
                    {
                        IdModulo = (int)accesoDatos.Lector["IdModulo"],
                        Titulo = accesoDatos.Lector["Titulo"].ToString(),
                        Introduccion = accesoDatos.Lector["Introduccion"].ToString(),
                        Orden = (int)accesoDatos.Lector["Orden"]
                    };
                    LeccionServicio leccionServicio = new LeccionServicio();
                    modulo.Lecciones = leccionServicio.ListarLeccionesPorModuloId(modulo.IdModulo);
                    return modulo;
                }
                else
                {
                    return null;
                }
            }
            catch (Exception ex)
            {
                throw new Exception("No se pudo cargar el módulo", ex);
            }
            finally
            {
                accesoDatos.cerrarConexion();
            }
        }


        public List<Modulo> ObtenerModulosPorIdCurso(int id)
        {
            AccesoDatos accesoDatos = new AccesoDatos();
            try
            {
                accesoDatos.setConsulta(@"
                SELECT 
                    m.IdModulo, 
                    m.Titulo, 
                    m.Introduccion, 
                    m.Orden,
                    c.Estado
                FROM Modulo m
                INNER JOIN Curso c ON c.IdCurso = m.IdCurso
                WHERE m.IdCurso = @idCurso
                ORDER BY m.Orden
                ");
                accesoDatos.limpiarParametros();
                accesoDatos.setParametro("@idCurso", id);
                accesoDatos.ejecutarLectura();
                List<Modulo> modulos = new List<Modulo>();
                while (accesoDatos.Lector.Read())
                {
                    Modulo modulo = new Modulo
                    {
                        IdModulo = (int)accesoDatos.Lector["IdModulo"],
                        Titulo = accesoDatos.Lector["Titulo"].ToString(),
                        Introduccion = accesoDatos.Lector["Introduccion"].ToString(),
                        Orden = (int)accesoDatos.Lector["Orden"]
                    };
                    modulos.Add(modulo);
                }
                return modulos;
            }
            catch (Exception ex)
            {
                throw new Exception("Error al listar módulos por curso", ex);
            }
            finally
            {
                accesoDatos.cerrarConexion();
            }
        }
        public bool EsUsuarioHabilitado(int idUsuario, int idModulo)
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
                WHERE c.IdUsuario = @IdUsuario AND m.IdModulo = @IdModulo;
                ");
                accesoDatos.limpiarParametros();
                accesoDatos.setParametro("@IdUsuario", idUsuario);
                accesoDatos.setParametro("@IdModulo", idModulo);
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

    }
}

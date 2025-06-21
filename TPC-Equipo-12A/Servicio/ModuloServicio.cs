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
        public Modulo ObtenerModuloPorId(int id, int idUsuario)
        {
            AccesoDatos accesoDatos = new AccesoDatos();
            try
            {
                accesoDatos.setConsulta(@"
                SELECT 
                    m.IdModulo, 
                    m.IdCurso,
                    m.Titulo, 
                    m.Introduccion, 
                    m.Orden,
                    c.Estado,
                    i.IdImagen,
                    i.UrlImagen,    
                    i.IdTipoImagen,
                    i.Nombre        
                FROM Modulo m
                INNER JOIN Curso c ON c.IdCurso = m.IdCurso
                LEFT JOIN Imagen i ON i.IdImagen = m.IdImagen
                WHERE m.IdModulo = @idModulo
                ");
                accesoDatos.limpiarParametros();
                accesoDatos.setParametro("@idModulo", id);
                accesoDatos.ejecutarLectura();
                if (accesoDatos.Lector.Read())
                {
                    Modulo modulo = new Modulo
                    {
                        IdCurso = (int)accesoDatos.Lector["IdCurso"],
                        IdModulo = (int)accesoDatos.Lector["IdModulo"],
                        Titulo = accesoDatos.Lector["Titulo"].ToString(),
                        Introduccion = accesoDatos.Lector["Introduccion"].ToString(),
                        Orden = (int)accesoDatos.Lector["Orden"],
                        imagen = new Imagen
                        {
                            IdImagen = accesoDatos.Lector["IdImagen"] != DBNull.Value ? (int)accesoDatos.Lector["IdImagen"] : -1,
                            Url = accesoDatos.Lector["UrlImagen"] != DBNull.Value ? accesoDatos.Lector["UrlImagen"].ToString() : string.Empty,
                            Tipo = accesoDatos.Lector["IdTipoImagen"] != DBNull.Value ? (int)accesoDatos.Lector["IdTipoImagen"] : 0,
                            Nombre = accesoDatos.Lector["Nombre"] != DBNull.Value ? accesoDatos.Lector["Nombre"].ToString() : string.Empty
                        }
                    };
                    accesoDatos.cerrarConexion();
                    LeccionServicio leccionServicio = new LeccionServicio();
                    modulo.Lecciones = leccionServicio.ListarLeccionesPorModuloId(id, idUsuario);
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
                        IdCurso = id,
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

        public void ActualizarOCrear(Modulo modulo)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                if (modulo.imagen != null && modulo.imagen.Url != null)
                {
                    ImagenServicio imagenServicio = new ImagenServicio();
                    modulo.imagen.IdImagen = imagenServicio.ActualizarOCrear(modulo.imagen);
                }

                datos.limpiarParametros();
                datos.setParametro("@IdCurso", modulo.IdCurso);
                datos.setParametro("@Titulo", modulo.Titulo);
                datos.setParametro("@Introduccion", modulo.Introduccion);
                datos.setParametro("@Orden", modulo.Orden);

                if (modulo.imagen != null && modulo.imagen.IdImagen > 0)
                {
                    datos.setParametro("@IdImagen", modulo.imagen.IdImagen);
                }
                else
                {
                    datos.setParametro("IdImagen", DBNull.Value);
                }

                if (modulo.IdModulo > 0)
                {
                    datos.setConsulta(@"UPDATE Modulo 
                                SET Titulo = @Titulo, Introduccion = @Introduccion, 
                                    Orden = @Orden, IdImagen = @IdImagen 
                                WHERE IdModulo = @IdModulo");
                    datos.setParametro("@IdModulo", modulo.IdModulo);
                }
                else
                {
                    datos.setConsulta(@"INSERT INTO Modulo (IdCurso, Titulo, Introduccion, Orden, IdImagen) 
                                VALUES (@IdCurso, @Titulo, @Introduccion, @Orden, @IdImagen)");
                }

                datos.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw new Exception("Error al cargar los módulos", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        internal List<ModuloDTO> ObtenerModulosDTOPorIdCurso(int idCurso)
        {
            AccesoDatos accesoModulo = new AccesoDatos();
            try
            {
                accesoModulo.setConsulta(@"
                    SELECT 
                        m.IdModulo,
                        m.Titulo,
                        m.IdCurso
                    FROM Modulo m
                    WHERE m.IdCurso = @idCurso
                    ORDER BY m.Orden ASC"
                    );
                accesoModulo.limpiarParametros();
                accesoModulo.setParametro("@idCurso", idCurso);
                accesoModulo.ejecutarLectura();

                List<ModuloDTO> modulos = new List<ModuloDTO>();
                LeccionServicio leccionServicio = new LeccionServicio();
                while (accesoModulo.Lector.Read())
                {
                    ModuloDTO modulo = new ModuloDTO
                    {
                        IdCurso = (int)accesoModulo.Lector["IdCurso"],
                        IdModulo = (int)accesoModulo.Lector["IdModulo"],
                        NombreModulo = accesoModulo.Lector["Titulo"].ToString(),
                        UrlModulo = $"Modulo.aspx?id={(int)accesoModulo.Lector["IdModulo"]}"
                    };
                    modulo.Lecciones = leccionServicio.ObtenerLeccionesDTOPorIdModulo(modulo.IdModulo);
                    modulos.Add(modulo);
                }
                return modulos;
            }
            catch (Exception ex)
            {
                throw new Exception("Error al cargar los modulos:", ex);
            }
            finally
            {
                accesoModulo.cerrarConexion();
            }
        }
    }
}

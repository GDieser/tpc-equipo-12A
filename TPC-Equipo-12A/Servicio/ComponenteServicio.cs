using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dominio;

namespace Servicio
{
    public class ComponenteServicio
    {
        internal List<Componente> ListarComponentesPorLeccionId(int id)
        {
            AccesoDatos accesoDatos = new AccesoDatos();
            try
            {
                accesoDatos.setConsulta(@"
                SELECT 
                    c.IdComponente,
                    c.IdLeccion,
                    c.TipoContenido, 
                    c.Contenido, 
                    c.Titulo,
                    c.Orden
                FROM Componente c
                WHERE c.IdLeccion = @idLeccion
                ORDER BY c.Orden
                ");
                accesoDatos.limpiarParametros();
                accesoDatos.setParametro("@idLeccion", id);
                accesoDatos.ejecutarLectura();
                List<Componente> componentes = new List<Componente>();
                while (accesoDatos.Lector.Read())
                {
                    Componente componente = new Componente
                    {
                        IdComponente = (int)accesoDatos.Lector["IdComponente"],
                        IdLeccion = (int)accesoDatos.Lector["IdLeccion"],
                        TipoContenido = (TipoContenido)Enum.Parse(typeof(TipoContenido), accesoDatos.Lector["TipoContenido"].ToString()),
                        Contenido = accesoDatos.Lector["Contenido"].ToString(),
                        Orden = (int)accesoDatos.Lector["Orden"],
                        Titulo = accesoDatos.Lector["Titulo"].ToString()
                    };
                    componentes.Add(componente);
                }
                return componentes;
            }
            catch (Exception ex)
            {
                throw new Exception("Error al listar componentes por leccion", ex);
            }
            finally
            {
                accesoDatos.cerrarConexion();
            }
        }

        public void ActualizarOCrear(Componente componente)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.limpiarParametros();
                datos.setParametro("@IdLeccion", componente.IdLeccion);
                datos.setParametro("@Titulo", componente.Titulo);
                datos.setParametro("@Contenido", componente.Contenido);
                datos.setParametro("@TipoContenido", (int)componente.TipoContenido);
                datos.setParametro("@Orden", componente.Orden);

                if (componente.IdComponente > 0)
                {
                    datos.setParametro("@IdComponente", componente.IdComponente);
                    datos.setConsulta(@"UPDATE Componente 
                SET Titulo = @Titulo, Contenido = @Contenido, 
                    TipoContenido = @TipoContenido, Orden = @Orden, 
                    IdLeccion = @IdLeccion
                WHERE IdComponente = @IdComponente");
                }
                else
                {
                    datos.setConsulta(@"INSERT INTO Componente 
                (IdLeccion, Titulo, Contenido, TipoContenido, Orden) 
                VALUES (@IdLeccion, @Titulo, @Contenido, @TipoContenido, @Orden)");
                }

                datos.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw new Exception("Error al guardar el componente", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public static implicit operator ComponenteServicio(LeccionServicio v)
        {
            throw new NotImplementedException();
        }
    }
}

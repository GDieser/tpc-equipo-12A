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
    }
}

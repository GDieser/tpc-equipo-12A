using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dominio;

namespace Servicio
{
    public class CategoriaServicio
    {
        public List<Categoria> listar()
        {
			List<Categoria> lista = new List<Categoria>();
			AccesoDatos datos = new AccesoDatos();	
			try
			{
				datos.setConsulta("SELECT IdCategoria, Nombre FROM Categoria");
				datos.ejecutarLectura();

				while(datos.Lector.Read())
				{
					Categoria aux = new Categoria();
					aux.IdCategoria = (int)datos.Lector["IdCategoria"];
					aux.Nombre = (string)datos.Lector["Nombre"];

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
    }
}

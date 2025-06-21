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
        public Categoria AgregarCategoriaSiNoExiste(string nombre)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setConsulta("SELECT IdCategoria, Nombre FROM Categoria WHERE Nombre = @nombre");
                datos.setParametro("@nombre", nombre);
                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    Categoria existente = new Categoria();
                    existente.IdCategoria = (int)datos.Lector["IdCategoria"];
                    existente.Nombre = (string)datos.Lector["Nombre"];
                    return existente;
                }

                datos.cerrarConexion();

                datos = new AccesoDatos();
                datos.setConsulta("INSERT INTO Categoria (Nombre) OUTPUT INSERTED.IdCategoria VALUES (@nombre)");
                datos.setParametro("@nombre", nombre);
                datos.ejecutarLectura();

                Categoria nueva = new Categoria();
                if (datos.Lector.Read())
                {
                    nueva.IdCategoria = (int)datos.Lector[0];
                    nueva.Nombre = nombre;
                }

                return nueva;
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

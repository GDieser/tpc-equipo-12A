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
				datos.setConsulta("SELECT IdCategoria, Nombre, Activo FROM Categoria");
				datos.ejecutarLectura();

				while(datos.Lector.Read())
				{
					Categoria aux = new Categoria();
					aux.IdCategoria = (int)datos.Lector["IdCategoria"];
					aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Activo = (bool)datos.Lector["Activo"];


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
                datos.setConsulta("SELECT IdCategoria, Nombre, Activo FROM Categoria WHERE Nombre = @nombre");
                datos.setParametro("@nombre", nombre);
                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    Categoria existente = new Categoria();
                    existente.IdCategoria = (int)datos.Lector["IdCategoria"];
                    existente.Nombre = (string)datos.Lector["Nombre"];
                    existente.Activo = (bool)datos.Lector["Activo"];
                    return existente;
                }

                datos.cerrarConexion();

                datos = new AccesoDatos();
                datos.setConsulta("INSERT INTO Categoria (Nombre, Activo) OUTPUT INSERTED.IdCategoria VALUES (@nombre, 1)");
                datos.setParametro("@nombre", nombre);
                datos.ejecutarLectura();

                Categoria nueva = new Categoria();
                if (datos.Lector.Read())
                {
                    nueva.IdCategoria = (int)datos.Lector[0];
                    nueva.Nombre = nombre;
                    nueva.Activo = true;
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
       
        public void ModificarConEstado(Categoria categoria)
        {
            AccesoDatos datos = new AccesoDatos();
            datos.setConsulta("UPDATE Categoria SET Nombre = @nombre, Activo = @activo WHERE IdCategoria = @id");
            datos.setParametro("@nombre", categoria.Nombre);
            datos.setParametro("@activo", categoria.Activo);
            datos.setParametro("@id", categoria.IdCategoria);
            datos.ejecutarAccion();
            datos.cerrarConexion();
        }





    }
}

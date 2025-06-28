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
        public List<Categoria> ListarActivas()
        {
            List<Categoria> lista = new List<Categoria>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setConsulta("SELECT IdCategoria, Nombre FROM Categoria WHERE Activo = 1");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Categoria aux = new Categoria
                    {
                        IdCategoria = (int)datos.Lector["IdCategoria"],
                        Nombre = (string)datos.Lector["Nombre"]
                    };

                    lista.Add(aux);
                }

                return lista;
            }
            catch
            {
                throw;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public Categoria AgregarCategoriaSiNoExiste(string nombre)
        {
            string nombreNormalizado = nombre.Trim().ToUpper();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setConsulta("SELECT IdCategoria, Nombre, Activo FROM Categoria WHERE UPPER(Nombre) = @nombre");
                datos.setParametro("@nombre", nombreNormalizado);
                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    int id = (int)datos.Lector["IdCategoria"];
                    string nombreExistente = (string)datos.Lector["Nombre"];
                    bool activo = (bool)datos.Lector["Activo"];

                    datos.cerrarConexion();

                    if (!activo)
                    {
                        datos = new AccesoDatos();
                        datos.setConsulta("UPDATE Categoria SET Activo = 1 WHERE IdCategoria = @id");
                        datos.setParametro("@id", id);
                        datos.ejecutarAccion();
                    }

                    return new Categoria
                    {
                        IdCategoria = id,
                        Nombre = nombreExistente,
                        Activo = true
                    };
                }

                datos.cerrarConexion();

                datos = new AccesoDatos();
                datos.setConsulta("INSERT INTO Categoria (Nombre, Activo) OUTPUT INSERTED.IdCategoria VALUES (@nombreReal, 1)");
                datos.setParametro("@nombreReal", nombre.Trim());
                datos.ejecutarLectura();

                Categoria nueva = new Categoria();
                if (datos.Lector.Read())
                {
                    nueva.IdCategoria = (int)datos.Lector[0];
                    nueva.Nombre = nombre.Trim();
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

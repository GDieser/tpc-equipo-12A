using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dominio;

namespace Servicio
{
    public class CompraServicio
    {

        public void RegistrarCompra(Carrito carrito)
        {
            AccesoDatos accesoDatos = new AccesoDatos();
            try
            {
                accesoDatos.setConsulta(@"
                    INSERT INTO Compra (IdCarrito, FechaCompra, Estado, CodigoTransaccion)
                    VALUES (@idCarrito, @fecha, @estado, @codigo);

                    SELECT SCOPE_IDENTITY();
                ");

                accesoDatos.setParametro("@idCarrito", carrito.IdCarrito);
                accesoDatos.setParametro("@fecha", DateTime.Now);
                accesoDatos.setParametro("@estado", (int)EstadoCarrito.Completado); 
                accesoDatos.setParametro("@codigo", carrito.IDOperacion); 

                accesoDatos.abrirConexion();
                int idCompra = Convert.ToInt32(accesoDatos.ejecutarEscalar());

                foreach (var curso in carrito.CarritoCursos)
                {
                    accesoDatos.limpiarParametros();
                    accesoDatos.setConsulta("INSERT INTO DetalleCompra (IdCompra, IdCurso, PrecioUnitario) VALUES (@idCompra, @idCurso, @precio)");

                    accesoDatos.setParametro("@idCompra", idCompra);
                    accesoDatos.setParametro("@idCurso", curso.IdCurso);
                    accesoDatos.setParametro("@precio", curso.Precio);

                    accesoDatos.ejecutarAccion();
                }

                accesoDatos.limpiarParametros();
                accesoDatos.setConsulta("UPDATE Carrito SET Estado = @estado WHERE IdCarrito = @idCarrito");
                accesoDatos.setParametro("@estado", (int)EstadoCarrito.Completado);
                accesoDatos.setParametro("@idCarrito", carrito.IdCarrito);
                accesoDatos.ejecutarAccion();

            }
            catch (Exception ex)
            {
                throw new Exception("Error al registrar la compra", ex);
            }
            finally
            {
                accesoDatos.cerrarConexion();
            }
        }
    }
}

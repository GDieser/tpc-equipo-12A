using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AngleSharp.Common;
using Dominio;

namespace Servicio
{
    public class CompraServicio
    {
        public List<Compra> getComprasPorIdUsuario(int idUsuario, bool isAdmin)
        {
            AccesoDatos accesoDatos = new AccesoDatos();
            List<Compra> compras = new List<Compra>();

            try
            {
                string consulta = isAdmin
                    ? "SELECT c.IdCompra, c.FechaCompra, c.IdUsuario, c.MontoTotal, c.CodigoTransaccion, c.Estado, u.Email FROM Compra c INNER JOIN Usuario u ON u.IdUsuario = c.IdUsuario "
                    : "SELECT c.IdCompra, c.FechaCompra, c.IdUsuario, c.MontoTotal, c.CodigoTransaccion, c.Estado, u.Email FROM Compra c INNER JOIN Usuario u ON u.IdUsuario = c.IdUsuario WHERE c.IdUsuario = @idUsuario";

                accesoDatos.setConsulta(consulta);

                if (!isAdmin)
                    accesoDatos.setParametro("@idUsuario", idUsuario);

                accesoDatos.ejecutarLectura();

                while (accesoDatos.Lector.Read())
                {
                    Compra compra = new Compra
                    {
                        IdCompra = (int)accesoDatos.Lector["IdCompra"],
                        FechaCompra = Convert.ToDateTime(accesoDatos.Lector["FechaCompra"]),
                        CodigoTransaccion = accesoDatos.Lector["CodigoTransaccion"].ToString(),
                        Estado = (EstadoCarrito)accesoDatos.Lector["Estado"],
                        EmailComprador = accesoDatos.Lector["Email"].ToString(),
                        DetalleCompra = new List<CompraCursoDTO>()
                    };

                    compras.Add(compra);
                }

                accesoDatos.cerrarConexion();

                foreach (var compra in compras)
                {
                    AccesoDatos datos = new AccesoDatos();
                    datos.setConsulta(@"
                SELECT c.Titulo, dc.PrecioUnitario
                FROM DetalleCompra dc
                INNER JOIN Curso c ON c.IdCurso = dc.IdCurso
                WHERE dc.IdCompra = @idCompra");
                    datos.setParametro("@idCompra", compra.IdCompra);
                    datos.ejecutarLectura();

                    while (datos.Lector.Read())
                    {
                        compra.DetalleCompra.Add(new CompraCursoDTO
                        {
                            NombreCurso = datos.Lector["Titulo"].ToString(),
                            Monto = (decimal)datos.Lector["PrecioUnitario"],
                        });
                    }

                    datos.cerrarConexion();
                }

                return compras;
            }
            catch (Exception ex)
            {
                throw new Exception("Error al cargar las compras", ex);
            }
            finally
            {
                accesoDatos.cerrarConexion();
            }
        }

        public void RegistrarCompra(Carrito carrito)
        {
            AccesoDatos accesoDatos = new AccesoDatos();
            try
            {
                accesoDatos.setConsulta(@"
                    INSERT INTO Compra (IdUsuario, IdCarrito, FechaCompra, Estado, MontoTotal, CodigoTransaccion)
                    VALUES (@idUsuario, @idCarrito, @fecha, @estado, @montoTotal,@codigo);

                    SELECT SCOPE_IDENTITY();
                ");
                accesoDatos.setParametro("@idUsuario", carrito.IdUsuario);
                accesoDatos.setParametro("@idCarrito", carrito.IdCarrito);
                accesoDatos.setParametro("@fecha", DateTime.Now);
                accesoDatos.setParametro("@estado", (int)EstadoCarrito.Completado);
                accesoDatos.setParametro("@montoTotal", carrito.CarritoCursos.Sum(m => m.Precio));
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
                accesoDatos.setConsulta("UPDATE Carrito SET EstadoCarrito = @estado WHERE IdCarrito = @idCarrito");
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

        public void RegistrarCompraManual(int idUsuario, int idCurso)
        {
            AccesoDatos accesoDatos = new AccesoDatos();
            try
            {
                CursoServicio cursoServicio = new CursoServicio();
                Curso curso = cursoServicio.GetCursoPorId(idCurso); 
                if (curso == null)
                    throw new Exception("Curso no encontrado");

                decimal precio = curso.Precio;

                accesoDatos.setConsulta(@"
                    INSERT INTO Compra (IdUsuario, IdCarrito, FechaCompra, Estado, MontoTotal, CodigoTransaccion)
                    VALUES (@idUsuario, NULL, @fecha, @estado, @montoTotal, @codigo);

                    SELECT SCOPE_IDENTITY();
                ");

                accesoDatos.setParametro("@idUsuario", idUsuario);
                accesoDatos.setParametro("@fecha", DateTime.Now);
                accesoDatos.setParametro("@estado", (int)EstadoCarrito.Completado);
                accesoDatos.setParametro("@montoTotal", precio);
                accesoDatos.setParametro("@codigo", "MANUAL-" + Guid.NewGuid().ToString("N").Substring(0, 10));

                accesoDatos.abrirConexion();
                int idCompra = Convert.ToInt32(accesoDatos.ejecutarEscalar());

                accesoDatos.limpiarParametros();
                accesoDatos.setConsulta(@"
                    INSERT INTO DetalleCompra (IdCompra, IdCurso, PrecioUnitario) 
                    VALUES (@idCompra, @idCurso, @precio)"
                );
                accesoDatos.setParametro("@idCompra", idCompra);
                accesoDatos.setParametro("@idCurso", idCurso);
                accesoDatos.setParametro("@precio", precio);

                accesoDatos.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw new Exception("Error al registrar la compra manual", ex);
            }
            finally
            {
                accesoDatos.cerrarConexion();
            }
        }
    }
}

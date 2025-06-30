using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Servicio;

namespace TPC_Equipo_12A
{
    public partial class ExitoPago : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            string idOperacion = Request.QueryString["preference_id"];

            if (string.IsNullOrWhiteSpace(idOperacion))
            {
                System.Diagnostics.Trace.WriteLine("No se pudo obtener el ID de Operación.");
                return;
            }

            CursoServicio carritoServicio = new CursoServicio();
            CompraServicio compraServicio = new CompraServicio();
            Dominio.Carrito carrito = carritoServicio.getCarritoPorIdOperacion(idOperacion);
            if (carrito != null && carrito.Estado != Dominio.EstadoCarrito.Completado)
            {
                carrito.Estado = Dominio.EstadoCarrito.Completado;
                carrito.UltimaModificacion = DateTime.Now;
                carrito.IDOperacion = idOperacion;
                try
                {
                    compraServicio.RegistrarCompra(carrito);
                    ServicioMail servicioMail = new ServicioMail();
                    UsuarioServicio usuarioServicio = new UsuarioServicio();
                    try
                    {
                        Dominio.Usuario usuario = usuarioServicio.BuscarPorId(carrito.IdUsuario);
                        servicioMail.EnviarConfirmacionCompra(usuario);
                    }
                    catch (Exception ex)
                    {
                        System.Diagnostics.Trace.WriteLine("Error al enviar correo de confirmación: " + ex.Message);
                    }

                }
                catch (Exception ex)
                {
                    System.Diagnostics.Trace.WriteLine("Error al registrar la compra: " + ex.Message);
                }
            }
            else
            {
                System.Diagnostics.Trace.WriteLine($"No se encontro carrido con idOperacion = {idOperacion}");
            }
        }
    }
}
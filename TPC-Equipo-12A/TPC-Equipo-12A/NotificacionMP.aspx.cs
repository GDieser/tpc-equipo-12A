using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using Servicio;

namespace TPC_Equipo_12A
{
    public partial class NotificacionMP : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                string topic = Request.QueryString["topic"];
                string id = Request.QueryString["id"];

                if (topic == "payment" && !string.IsNullOrEmpty(id))
                {
                    ProcesarPago(id);
                }

                Response.StatusCode = 200;
            }
            catch (Exception ex)
            {
                Response.StatusCode = 500;
            }
        }

        private void ProcesarPago(string paymentId)
        {
            string accessToken = ConfigurationManager.AppSettings["MPAccessToken"];
            string url = $"https://api.mercadopago.com/v1/payments/{paymentId}?access_token={accessToken}";

            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);
            request.Method = "GET";

            using (var response = (HttpWebResponse)request.GetResponse())
            using (var reader = new StreamReader(response.GetResponseStream()))
            {
                string result = reader.ReadToEnd();

                var json = new JavaScriptSerializer().Deserialize<Dictionary<string, object>>(result);

                string status = json["status"].ToString();
                string preferenceId = json.ContainsKey("preference_id") ? json["preference_id"].ToString() : null;
                string externalRef = json.ContainsKey("external_reference") ? json["external_reference"].ToString() : null;

                switch (status)
                {
                    case "approved":
                        RegistrarCompra(preferenceId, paymentId);
                        break;
                    case "pending":
                        break;
                    case "rejected":
                        NotificarCompraRechazada(preferenceId);
                        break;
                    default:
                        break;
                }
            }
        }

        private void NotificarCompraRechazada(string idOperacion)
        {
            if (idOperacion == null)
            {
                System.Diagnostics.Trace.WriteLine("No se pudo obtener el ID de Operacion: " + idOperacion);
                return;
            }

            CursoServicio carritoServicio = new CursoServicio();
            CompraServicio compraServicio = new CompraServicio();
            Dominio.Carrito carrito = carritoServicio.getCarritoPorIdOperacion(idOperacion);
            if (carrito != null)
            {
                ServicioMail servicioMail = new ServicioMail();
                UsuarioServicio usuarioServicio = new UsuarioServicio();
                try
                {
                    Dominio.Usuario usuario = usuarioServicio.BuscarPorId(carrito.IdUsuario);
                    servicioMail.EnviarCompraRechazada(usuario);
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Trace.WriteLine("Error al enviar correo de confirmación: " + ex.Message);
                }
            }
            else
            {
                System.Diagnostics.Trace.WriteLine($"No se encontro carrido con idOperacion = {idOperacion}");
            }
        }

        private void RegistrarCompra(string idOperacion, string paymentId)
        {
            if (idOperacion == null)
            {
                System.Diagnostics.Trace.WriteLine("No se pudo obtener el ID de Operacion: " + idOperacion);
                return;
            }

            CursoServicio carritoServicio = new CursoServicio();
            CompraServicio compraServicio = new CompraServicio();
            Dominio.Carrito carrito = carritoServicio.getCarritoPorIdOperacion(idOperacion);
            if (carrito != null)
            {
                carrito.Estado = Dominio.EstadoCarrito.Completado;
                carrito.UltimaModificacion = DateTime.Now;
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
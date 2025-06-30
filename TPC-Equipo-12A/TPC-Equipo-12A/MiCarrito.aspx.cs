using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dominio;
using Servicio;

namespace TPC_Equipo_12A
{
    public partial class MiCarrito : System.Web.UI.Page
    {
        CursoServicio servicio = new CursoServicio();

        protected Carrito carrito;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["UsuarioAutenticado"] == null)
            {

                lblMensaje.Visible = true;
                lblMensaje.Text = "¡Nada por aca... Tenes que loguearte para ver tu carrito!";
                return;
            }

            carrito = (Carrito)Session["Carrito"];

            if (carrito == null || carrito.CarritoCursos == null || carrito.CarritoCursos.Count == 0)
            {
                lblMensaje.Visible = true;
                lblMensaje.Text = "¡Nada por aca... Tenes que agregar algo a tu carrito!";

            }

            if (!IsPostBack)
            {
                CargarCarrito();
            }
        }

        public void CargarCarrito()
        {
            carrito = (Carrito)Session["Carrito"];

            List<Dominio.Curso> cursos = new List<Dominio.Curso>();


            foreach (var curso in carrito.CarritoCursos)
            {
                cursos.Add(servicio.GetCursoPorId(curso.IdCurso));
            }

            repCarrito.DataSource = cursos;
            repCarrito.DataBind();

            decimal total = carrito.CarritoCursos.Sum(c => c.Precio);
            lblTotal.Text = total.ToString("N2");

            pnlCarrito.Visible = true;
            lblMensaje.Visible = false;

        }

        protected void repCarrito_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            UsuarioAutenticado usuario = (UsuarioAutenticado)Session["UsuarioAutenticado"];
            CursoServicio servicio = new CursoServicio();

            if (e.CommandName == "Eliminar")
            {
                carrito = (Carrito)Session["Carrito"];

                int idCurso = Convert.ToInt32(e.CommandArgument.ToString());

                servicio.EliminarCursoCarrito(idCurso);

                Session["Carrito"] = null;
                Session["Carrito"] = servicio.ListarCursoCarrito(usuario.IdUsuario); ;
                CargarCarrito();

                Response.Redirect(Request.RawUrl);
            }

        }

        protected void btnComprar_Click(object sender, EventArgs e)
        {
            Carrito carrito = Session["Carrito"] as Carrito;
            if (carrito == null || carrito.CarritoCursos.Count == 0)
            {
                Response.Redirect("Default.aspx");
                return;
            }


            CursoServicio cursoServicio = new CursoServicio();
            List<Dominio.Curso> cursos = new List<Dominio.Curso>();
            try
            {
                foreach (var curso in carrito.CarritoCursos)
                {
                    cursos.Add(cursoServicio.GetCursoPorId(curso.IdCurso));
                }
            }
            catch (Exception ex)
            {
                MostrarMensaje("Error", $"Error al cargar el/los cursos: {ex.Message}", "error");
            }
            decimal total = carrito.CarritoCursos.Sum(c => c.Precio);
            if (total == 0)
            {
                CompraServicio compraServicio = new CompraServicio();
                UsuarioServicio usuarioServicio = new UsuarioServicio();
                ServicioMail servicioMail = new ServicioMail();
                try
                {
                    carrito.IDOperacion = $"CursoGratis-{Guid.NewGuid()}";
                    compraServicio.RegistrarCompra(carrito);
                    Usuario usuario = usuarioServicio.BuscarPorId(carrito.IdUsuario);
                    servicioMail.EnviarConfirmacionCompra(usuario);
                    Response.Redirect("ExitoPago.aspx");
                }
                catch (Exception ex)
                {
                    MostrarMensaje("Error", $"Error al procesar el curso gratuito: {ex.Message}", "error");
                }
                return;
            }

            string accessToken = ConfigurationManager.AppSettings["MPAccessToken"];
            string dominioURL = ConfigurationManager.AppSettings["Dominio"];

            var mpServicio = new MercadoPagoServicio(accessToken, dominioURL);

            var items = cursos.Select(item => new
            {
                title = item.Titulo,
                quantity = 1,
                currency_id = "ARS",
                unit_price = item.Precio
            }).Cast<object>().ToList();

            try
            {
                var (initPoint, idOperacion) = mpServicio.CrearPreferenciaPago(items, carrito.IdCarrito.ToString());

                carrito.IDOperacion = idOperacion;

                cursoServicio.AsignarIdOperacionCarrito(carrito);

                Response.Redirect(initPoint, false);
            }
            catch (Exception ex)
            {
                MostrarMensaje("Error", $"Error al procesar el pago: {ex.Message}", "error");
            }
        }
        private void MostrarMensaje(string titulo, string mensaje, string icono)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "sweetalert",
                $@"Swal.fire({{
            title: '{titulo}',
            text: '{mensaje}',
            icon: '{icono}',
            confirmButtonText: 'OK'
        }});", true);
        }

    }
}
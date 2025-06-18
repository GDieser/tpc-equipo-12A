using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
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
            
            if (!IsPostBack)
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
                else
                {
                    CargarCarrito();
                }

               
            }
        }

        public void CargarCarrito()
        {
            carrito = (Carrito)Session["Carrito"];

            List<Curso> cursos = new List<Curso>();

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
            CursoServicio servicio = new CursoServicio();

            if(e.CommandName == "Eliminar")
            {
                int idCurso = Convert.ToInt32(e.CommandArgument.ToString());

                servicio.EliminarCursoCarrito(idCurso);

                Response.Redirect(Request.RawUrl);
            }

        }
    }
}
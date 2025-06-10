using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dominio;
using Servicio;

namespace TPC_Equipo_12A
{
    public partial class DetalleNovedad : System.Web.UI.Page
    {
        Publicacion novedad;
        
        protected void Page_Load(object sender, EventArgs e)
        {
            NovedadesServicio servicio = new NovedadesServicio();
            UsuarioAutenticado usuarioAutenticado = new UsuarioAutenticado();

            if (Session["UsuarioAutenticado"] != null)
            {
                usuarioAutenticado = (UsuarioAutenticado)Session["UsuarioAutenticado"];

                if (usuarioAutenticado.Rol == 0)
                {
                    btnModificar.Visible = true;
                }
                else
                {
                    btnModificar.Visible = false;
                }
            }
            else
            {
                btnModificar.Visible = false;
            }

            if (!IsPostBack)
            {
                int id = Request.QueryString["IdNovedad"] != null ? int.Parse(Request.QueryString["IdNovedad"]) : 1;

                novedad = servicio.GetPublicacion(id);

                Session.Remove("NovedadSeleccionada");
                Session.Add("NovedadSeleccionada", novedad);

                CargarNovedad();

            }

        }


        public void CargarNovedad()
        {
            imgBanner.ImageUrl = novedad.UrlImagen;
            lblTitulo.Text = novedad.Titulo;
            lblFechaPublicacion.Text = "Publicado el: " + novedad.FechaPublicacion.ToString();
            lblResumen.Text = novedad.Resumen;
            lblDescripcion.Text = novedad.Descripcion;

        }


        protected void btnModificar_Click(object sender, EventArgs e)
        {
            Response.Redirect("FormularioPublicacion.aspx");
        }
    }
}
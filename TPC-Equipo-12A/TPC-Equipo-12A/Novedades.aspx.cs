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
    public partial class Novedades : System.Web.UI.Page
    {
        public List<Publicacion> ListaPublicaciones;

        protected void Page_Load(object sender, EventArgs e)
        {
            NovedadesServicio servicio = new NovedadesServicio();
            UsuarioAutenticado usuarioAutenticado = new UsuarioAutenticado();

            if(Session["UsuarioAutenticado"] != null)
            {
                usuarioAutenticado = (UsuarioAutenticado)Session["UsuarioAutenticado"];

                if (usuarioAutenticado.Rol == 0)
                {
                    btnAgregar.Visible = true;
                }
                else
                {
                    btnAgregar.Visible = false;
                }
            }
            else
            {
                btnAgregar.Visible = false;
            }


            if (!IsPostBack)
            {
                ListaPublicaciones = servicio.listar();

                rptNovedades.DataSource = ListaPublicaciones;
                rptNovedades.DataBind();
            }

        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            Response.Redirect("NuevaPublicacion.aspx", false);
        }
    }
}
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
    public partial class PublicacionLista : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Seguridad.esAdmin(Session["UsuarioAutenticado"]))
            {
                Session.Add("error", "Hey, no deberías andar por acá 🤨. Acceso no permitido");
                Response.Redirect("Error.aspx");
            }

            if (!IsPostBack)
            {
                NovedadesServicio servicio = new NovedadesServicio();
                Session.Add("ListaPublicaciones", servicio.listar());
                dgvPublicaciones.DataSource = Session["ListaPublicaciones"];
                dgvPublicaciones.DataBind();
            }

        }

        protected void dgvPublicaciones_SelectedIndexChanged(object sender, EventArgs e)
        {
            NovedadesServicio servicio = new NovedadesServicio();
            int id = (int)(dgvPublicaciones.SelectedDataKey.Value);


            Session.Remove("NovedadSeleccionada");
            Session.Add("NovedadSeleccionada", servicio.GetPublicacion(id));

            Response.Redirect("FormularioPublicacion.aspx");
        }

        protected void dgvPublicaciones_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            dgvPublicaciones.PageIndex = e.NewPageIndex;
            dgvPublicaciones.DataBind();
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            Session.Remove("NovedadSeleccionada");
            Response.Redirect("FormularioPublicacion.aspx");
        }
    }
}
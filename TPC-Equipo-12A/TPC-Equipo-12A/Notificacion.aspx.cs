using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TPC_Equipo_12A
{
    public partial class Bienvenida : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string Titulo = Session["titulo"] as string ?? "Bienvenid@";
                string MensajePrincipal = Session["mensajePrincipal"] as string ?? "¡Gracias por registrarte!";
                string MensajeSecundario = Session["mensajeSecundario"] as string ?? "Revisá tu correo para continuar.";

                lblTitulo.Text = Titulo;
                lblMensajePrincipal.Text = MensajePrincipal;
                lblMensajeSecundario.Text = MensajeSecundario;

                Session.Remove("titulo");
                Session.Remove("mensaje");
                Session.Remove("mensaje");
            }
        }

        protected void btnVolver_Click(object sender, EventArgs e)
        {
            Response.Redirect("Default.aspx");
        }

    }
}
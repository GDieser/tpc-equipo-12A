using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Servicio;
using Dominio;

namespace TPC_Equipo_12A
{
    public partial class MisCertificados : System.Web.UI.Page
    {
        private UsuarioAutenticado usuario
        {
            get { return Session["UsuarioAutenticado"] as UsuarioAutenticado; }
            set { Session["UsuarioAutenticado"] = value; }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UsuarioAutenticado"]  == null)
            {
                Session.Add("error", "Hey, no deberías andar por acá 🤨. Acceso no permitido");
                Response.Redirect("Error.aspx");
            }
            if (!IsPostBack)
            {
                CertificadoServicio certificadoServicio = new CertificadoServicio();
                List<CertificadoDTO> certificados = certificadoServicio.ObtenerCertificadosPorUsuario(usuario.IdUsuario);
                if (certificados != null && certificados.Count > 0)
                {
                    rptCertificados.DataSource = certificados;
                    rptCertificados.DataBind();
                    lblMensaje.Visible = false;
                }
                else
                {
                    lblMensaje.Visible = true;
                    lblMensaje.Text = "No tienes certificados emitidos.";
                    rptCertificados.Visible = false;
                }

            }
        }
    }
}
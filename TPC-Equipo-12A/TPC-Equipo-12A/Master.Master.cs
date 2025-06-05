using System;
using System.Security.Cryptography;
using Dominio;
using Servicio;

namespace TPC_Equipo_12A
{
    public partial class Master : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                UsuarioAutenticado usuario = (UsuarioAutenticado)Session["UsuarioAutenticado"];

                btnLogin.Visible = (usuario == null);
                btnLogout.Visible = (usuario != null);
                if (Page is Login)
                {
                    btnLogin.Visible = btnLogout.Visible = false;
                }
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session["UsuarioAutenticado"] = null;
            Response.Redirect(Request.RawUrl);
        }
    }
}
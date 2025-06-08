using System;
using System.Security.Cryptography;
using Dominio;
using Servicio;

namespace TPC_Equipo_12A
{
    public partial class Master : System.Web.UI.MasterPage
    {
        protected UsuarioAutenticado usuario;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                usuario = (UsuarioAutenticado)Session["UsuarioAutenticado"];

                if (Page is Login || usuario != null)
                {
                    btnLogin.Visible = false;
                }
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session["UsuarioAutenticado"] = null;
            Response.Redirect("Default.aspx");
        }
    }
}
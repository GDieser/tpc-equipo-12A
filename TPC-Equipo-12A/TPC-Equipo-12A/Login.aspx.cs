using System;
using System.Data.SqlClient;
using Utils;
using Servicio;

namespace TPC_Equipo_12A
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string pass = SHA256Utils.toSha256(txtPass.Text);
                UsuarioAutenticado usuario = AutenticarUsuario.login(txtUsuario.Text, pass);

                if (usuario != null)
                {
                    // Usuario válido: guardas en sesión y redireccionás
                    Session["Usuario"] = usuario;
                    Response.Redirect("Home.aspx");
                }
                else
                {
                    lblError.Text = "Usuario o contraseña inválidos... ";
                }
            }
        }
    }
}
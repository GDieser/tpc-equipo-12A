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
            if (!IsCallback)
            {
                lblError.Visible = false;
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                lblError.Visible = false;
                string pass = SHA256Utils.toSha256(txtPass.Text);
                
                UsuarioAutenticado usuario = AutenticarUsuario.login(txtUsuario.Text, pass);

                if (usuario != null)
                {
                    Session["UsuarioAutenticado"] = usuario;
                    Response.Redirect("Default.aspx");
                }
                else
                {
                    lblError.ForeColor = System.Drawing.Color.Red;
                    lblError.Visible = true;
                    lblError.Text = "Usuario o contraseña invalidos";
                    
                }
            }
        }
    }
}
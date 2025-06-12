using System;
using System.Data.SqlClient;
using Utils;
using Servicio;
using System.Web.UI;

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

                if (usuario != null && usuario.Habilitado)
                {
                    Session["UsuarioAutenticado"] = usuario;
                    ScriptManager.RegisterStartupScript(this, GetType(), "sweetalert",
                     $@"Swal.fire({{
                        title: '¡Bienvenido!',
                        text: '¡Hola {usuario.Nombre}!',
                        icon: 'success',
                        confirmButtonText: 'OK'
                    }}).then((result) => {{
                        if (result.isConfirmed) {{
                            window.location.href = 'Default.aspx';
                        }}
                    }});", true);

                }
                else
                {
                    lblError.ForeColor = System.Drawing.Color.Red;
                    lblError.Visible = true;
                    if (usuario?.Habilitado == false)
                        lblError.Text = "Usuario no habilitado, contacte al administrador.";
                    if (usuario == null)
                        lblError.Text = "Usuario o contraseña invalidos";
                }
            }
        }
    }
}
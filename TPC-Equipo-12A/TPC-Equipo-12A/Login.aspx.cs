using System;
using System.Web.UI;
using Servicio;
using Utils;


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

                    ClientScript.RegisterStartupScript(this.GetType(), "limpiarStorage",
                        "localStorage.clear();", true);
                    
                        Session["UsuarioAutenticado"] = usuario;
                    
                        ScriptManager.RegisterStartupScript(this, GetType(), "sweetalert",
                        $@"Swal.fire({{
                        title: '¡Bienvenido!',
                        text: '¡Hola {usuario.Nombre}!',
                        icon: 'success',
                        toast: true,
                        position: 'top',
                        showConfirmButton: false,
                        timer: 1500,
                        timerProgressBar: true,
                        background: '#1e1e2f',
                        color: '#fff',
                        iconColor: '#a5dc86',
                        didOpen: (toast) => {{
                            toast.addEventListener('mouseenter', Swal.stopTimer)
                            toast.addEventListener('mouseleave', Swal.resumeTimer)
                        }}
                    }});
                    setTimeout(function() {{
                        window.location.href = 'Default.aspx';
                    }}, 1600);", true);

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
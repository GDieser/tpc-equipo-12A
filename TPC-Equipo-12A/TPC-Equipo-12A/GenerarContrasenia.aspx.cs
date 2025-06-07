using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Servicio;
using Dominio;
using Utils;

namespace TPC_Equipo_12A
{
    public partial class GenerarContrasenia : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            var queryParams = System.Web.HttpUtility.ParseQueryString(HttpContext.Current.Request.Url.Query);
            ViewState["email"] = queryParams["email"];
            ViewState["token"] = queryParams["token"];
            string email = ViewState["email"] as string;
            string token = ViewState["token"] as string;

            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(token))
            {
                Session["error"] = @"La URL a la que intentas acceder no esta disponible. 
Si crees que se trata de un error intenta ingresar nuevamente desde tu correo.";

                Response.Redirect("Error.aspx");
            }
        }

        protected void btnGuardarContrasenia_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string email = ViewState["email"] as string;
                string token = ViewState["token"] as string;
                UsuarioServicio usuarioServicio = new UsuarioServicio();
                Usuario usuario = usuarioServicio.BuscarPorEmailNombreUsuario(email, "");
                if (usuario != null)
                {
                    if (usuario.TokenValidacion == token && !usuario.EmailValidado)
                    {
                        if (txtPass.Text != txtPass2.Text)
                        {
                            lblError.Text = "Las contraseñas no coinciden.";
                            return;
                        }
                        usuario.Pass = SHA256Utils.toSha256(txtPass.Text);
                        usuario.EmailValidado = true;
                        usuario.TokenValidacion = null;
                        usuarioServicio.GuardarContrasenia(usuario);
                        // TODO: Implementar registro de Usuario a Moodle una vez validado
                        Response.Redirect("Login.aspx");
                    }
                    else
                    {
                        Session["error"] = "El token es incorrecto o la contraseña ya ha sido generada.";
                        Response.Redirect("Error.aspx");
                    }
                }
                else
                {
                    Session["error"] = "El email es inexistente. Porfavor registrese...";
                    Response.Redirect("Error.aspx");
                    return;
                }
            }
        }
    }
}
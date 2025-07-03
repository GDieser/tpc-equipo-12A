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
            if (Session["UsuarioAutenticado"] != null)
            {
                Session["error"] = "Sesion activa. Debes cerrar sesion antes de reestablecer la contraseña";
                Response.Redirect("Error.aspx");
            }

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
            if (!Page.IsValid)
                return;

            string email = ViewState["email"] as string;
            string token = ViewState["token"] as string;

            UsuarioServicio usuarioServicio = new UsuarioServicio();
            Usuario usuario = usuarioServicio.BuscarPorEmailNombreUsuario(email, "");

            if (usuario == null)
            {
                Session["error"] = "El email no existe. Por favor, registrese.";
                Response.Redirect("Error.aspx");
                return;
            }

            if (!usuario.Habilitado)
            {
                Session["error"] = "Usuario no habilitado, contacte al administrador del sitio.";
                Response.Redirect("Error.aspx");
                return;
            }

            if (usuario.TokenValidacion != token)
            {
                Session["error"] = "El token es incorrecto o ha expirado.";
                Response.Redirect("Error.aspx");
                return;
            }

            if (txtPass.Text != txtPass2.Text)
            {
                lblError.Text = "Las contraseñas no coinciden.";
                return;
            }

            usuario.Pass = SHA256Utils.toSha256(txtPass.Text);
            usuario.TokenValidacion = null;

            if (!usuario.EmailValidado)
            {
                usuario.EmailValidado = true;
            }

            if (usuario.RecuperoContrasenia)
            {
                usuario.RecuperoContrasenia = false;
            }

            usuarioServicio.GuardarContrasenia(usuario);

            Session["titulo"] = $"Hola {usuario.Nombre} {usuario.Apellido}";
            Session["mensajePrincipal"] = "¡Tu contraseña fue generada exitosamente!";
            Session["mensajeSecundario"] = $"Ya podés ingresar a la plataforma con la nueva contraseña.";

            Response.Redirect("Notificacion.aspx", false);
        }

    }
}
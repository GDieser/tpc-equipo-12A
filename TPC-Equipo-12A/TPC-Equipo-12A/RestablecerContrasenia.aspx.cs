using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dominio;
using Servicio;

namespace TPC_Equipo_12A
{
    public partial class RestablecerContrasenia : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRestablecer_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                UsuarioServicio usuarioServicio = new UsuarioServicio();
                string email = txtEmail.Text.Trim();
                Usuario usuario = usuarioServicio.BuscarPorEmailNombreUsuario(email, "");

                if (usuario == null)
                {
                    lblError.Text = "Email no se encuentra registrado. Registrese o intente nuevamente";
                    return;
                }
                if (!usuario.Habilitado)
                {
                    lblError.Text = "El usuario no se encuentra habilitado. Por favor, contacte al administrador del sistema para más información.";
                    return;
                }
                if (!usuario.EmailValidado)
                {
                    lblError.Text = "El email ingresado no está asociado a un usuario válido o no ha sido verificado. Por favor, verifique su email o contacte al administrador del sistema.";
                    return;
                }
                try
                {
                    usuario.TokenValidacion = Guid.NewGuid().ToString();
                    usuarioServicio.ActualizarUsuario(usuario);
                    usuarioServicio.RecuperarContrasenia(usuario);

                    Session["titulo"] = $"Hola {usuario.Nombre} {usuario.Apellido}";
                    Session["mensajePrincipal"] = "¡Tu solicitud fue procesada exitosamente!";
                    Session["mensajeSecundario"] = $"Para restablecer tu contraseña es necesario que ingreses al link que se te envio a {usuario.Email}.";

                    Response.Redirect("Notificacion.aspx", false);
                }
                catch (Exception ex)
                {
                    Session["error"] = ex.Message;
                    Response.Redirect("Error.aspx");
                }
            }
        }
    }
}
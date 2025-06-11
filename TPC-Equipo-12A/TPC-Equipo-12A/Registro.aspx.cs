using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Servicio;
using Dominio;
using System.Threading.Tasks;

namespace TPC_Equipo_12A
{
    public partial class Registro : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        protected void BtnRegistrar_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                UsuarioServicio usuarioServicio = new UsuarioServicio();

                string email = txtEmail.Text.Trim();
                string nombreUsuario = txtNombreUsuario.Text.Trim();
                string nombre = txtNombre.Text.Trim();
                string apellido = txtApellido.Text.Trim();

                Usuario usuarioExistente = usuarioServicio.BuscarPorEmailNombreUsuario(email, nombreUsuario);

                if (usuarioExistente != null)
                {
                    if (usuarioExistente.NombreUsuario == nombreUsuario)
                    {
                        lblError.Text = "El nombre de usuario ya está registrado.";
                    }
                    else
                    {
                        lblError.Text = "El email ya está registrado.";
                    }
                    return;
                }

                Usuario nuevoUsuario = new Usuario
                {
                    Nombre = nombre,
                    Apellido = apellido,
                    Email = email,
                    NombreUsuario = nombreUsuario,
                    TokenValidacion = Guid.NewGuid().ToString(), // Esto genera un token unico a traves de GUID
                    EmailValidado = false,
                    FechaRegistro = DateTime.Now,
                    Habilitado = true,
                    RecuperoContrasenia = false,
                    Rol = Rol.Estudiante
                };

                try
                {
                    usuarioServicio.RegistrarUsuario(nuevoUsuario);


                    Session["titulo"]= $"Bienvenid@ {nuevoUsuario.Nombre} {nuevoUsuario.Apellido}";
                    Session["mensajePrincipal"] = "¡Gracias por registrarte!";
                    Session["mensajeSecundario"] = $"Revisá {nuevoUsuario.Email}. Ahi vas a encontrar las instrucciones para finalizar el registro.";

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
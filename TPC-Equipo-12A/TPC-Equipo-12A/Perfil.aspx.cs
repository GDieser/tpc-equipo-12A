using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Servicio;
using Dominio;

namespace TPC_Equipo_12A
{
    public partial class Perfil : System.Web.UI.Page
    {
        protected Usuario usuario;
        protected void Page_Load(object sender, EventArgs e)
        {
            UsuarioAutenticado usuarioAutenticado = Session["UsuarioAutenticado"] as UsuarioAutenticado;

            
            if (usuarioAutenticado == null || string.IsNullOrEmpty(Request.QueryString["id"]))
            {
                Session["error"] = "Debe iniciar sesion o indicar un ID para poder acceder al perfil.";
                Response.Redirect("Error.aspx");
                return;
            }
            int idQueryParam = int.Parse(Request.QueryString["id"]);
            if (!(usuarioAutenticado.Rol == Rol.Administrador || usuarioAutenticado.IdUsuario == idQueryParam))
            {
                Session["error"] = "Usted no es el dueño de este perfil ni el administrador.";
                Response.Redirect("Error.aspx");
                return;
            }
            else
            {
                if (!IsPostBack)
                {
                    UsuarioServicio usuarioServicio = new UsuarioServicio();
                    usuario = usuarioServicio.ObtenerPerfil(idQueryParam);
                    txtNombre.Text = usuario.Nombre;
                    txtApellido.Text = usuario.Apellido;
                    txtEmail.Text = usuario.Email;
                    litPerfilTitulo.Text = $"{usuario.NombreUsuario}";
                    litFechaRegistro.Text = $"Miembro {usuario.Rol.ToString()} desde el {usuario.FechaRegistro?.ToString("dd/MM/yyyy") ?? "-"}";
                    txtUrlFoto.Text = usuario.FotoPerfil.Url ?? "https://static-00.iconduck.com/assets.00/profile-user-icon-512x512-nm62qfu0.png";
                    imgFotoPerfil.ImageUrl = txtUrlFoto.Text;
                }
            }
        }

        protected void txtUrlFoto_TextChanged(object sender, EventArgs e)
        {
            imgFotoPerfil.ImageUrl = txtUrlFoto.Text == "" ? "https://static-00.iconduck.com/assets.00/profile-user-icon-512x512-nm62qfu0.png" : txtUrlFoto.Text;
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            // TODO: FALTA AGREGAR LA LOGICA PARA GUARDAR EL PERFIL DE USUARIO ACTUALIZADO (IMAGEN Y USUARIO)
        }
    }
}
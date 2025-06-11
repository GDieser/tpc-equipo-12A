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

    
    public partial class ListaUsuarios : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            UsuarioAutenticado usuario = Session["UsuarioAutenticado"] as UsuarioAutenticado;
            if (usuario == null || usuario.Rol != 0)
            {
                Session["error"] = "No tienes permisos para acceder a esta página.";
                Response.Redirect("Error.aspx");
            }

            UsuarioServicio usuarioServicio = new UsuarioServicio();
            List<Usuario> usuarios = usuarioServicio.ListarUsuarios();
            dgvUsuarios.DataSource = usuarios;
            dgvUsuarios.DataBind();

        }

        protected void dgvUsuarios_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            //if (e.CommandName == "ToggleEstado")
            //{
            //    int idUsuario = Convert.ToInt32(e.CommandArgument);

            //    // Alternar el estado (llamada a la lógica de negocios)
            //    UsuarioNegocio negocio = new UsuarioNegocio();
            //    negocio.CambiarEstadoHabilitado(idUsuario);

            //    // Recargar el GridView
            //    CargarUsuarios();
            //}

            return;
        }

        protected void dgvUsuarios_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            return;
        }
    }
}
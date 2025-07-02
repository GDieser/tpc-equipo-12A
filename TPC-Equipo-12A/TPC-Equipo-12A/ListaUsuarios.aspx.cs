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

            if (!IsPostBack)
            {
                CargarGrilla();
            }
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

        private void CargarGrilla()
        {
            UsuarioServicio usuarioServicio = new UsuarioServicio();
            List<Usuario> usuarios = usuarioServicio.ListarUsuarios();

            // Aplicar filtros según controles de la página (los tenés que agregar en el ASPX)
            string textoBuscar = txtBuscar.Text?.Trim().ToLower() ?? "";
            bool filtrarHabilitados = chkHabilitados.Checked;
            bool filtrarDeshabilitados = chkDeshabilitados.Checked;

            usuarios = usuarios.Where(u =>
                (filtrarHabilitados && u.Habilitado) ||
                (filtrarDeshabilitados && !u.Habilitado)
            ).ToList();

            if (!string.IsNullOrEmpty(textoBuscar))
            {
                usuarios = usuarios.Where(u =>
                    (u.Nombre?.ToLower().Contains(textoBuscar) ?? false) ||
                    (u.Apellido?.ToLower().Contains(textoBuscar) ?? false) ||
                    (u.Email?.ToLower().Contains(textoBuscar) ?? false) ||
                    (u.NombreUsuario?.ToLower().Contains(textoBuscar) ?? false)
                ).ToList();
            }

            dgvUsuarios.DataSource = usuarios;
            dgvUsuarios.DataBind();
        }

        protected void btnFiltrar_Click(object sender, EventArgs e)
        {
            CargarGrilla();
        }

        protected void btnLimpiarFiltros_Click(object sender, EventArgs e)
        {
            txtBuscar.Text = string.Empty;
            chkHabilitados.Checked = true;
            chkDeshabilitados.Checked = true;

            CargarGrilla();
        }

        protected void dgvUsuarios_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            return;
        }
    }
}
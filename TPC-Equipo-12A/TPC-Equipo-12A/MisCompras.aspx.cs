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
    public partial class MisCompras : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                CargarCompras();
            }
        }

        private void CargarDropdownsCompraManual()
        {
            UsuarioServicio usuarioServicio = new UsuarioServicio();
            var usuarios = usuarioServicio.ListarUsuarios().Where(u => u.Rol != Rol.Administrador).ToList();
            ddlUsuario.DataSource = usuarios;
            ddlUsuario.DataTextField = "Email";
            ddlUsuario.DataValueField = "IdUsuario";
            ddlUsuario.DataBind();
            ddlUsuario.Items.Insert(0, new ListItem("Seleccionar...", ""));

            CursoServicio cursoServicio = new CursoServicio();
            var cursos = cursoServicio.Listar((int)Rol.Administrador);
            ddlCurso.DataSource = cursos;
            ddlCurso.DataTextField = "Titulo";
            ddlCurso.DataValueField = "IdCurso";
            ddlCurso.DataBind();
            ddlCurso.Items.Insert(0, new ListItem("Seleccionar...", ""));
        }


        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "AbrirModal", @"
                var myModal = new bootstrap.Modal(document.getElementById('modalCompraManual'));
                myModal.show();
            ", true);
        }

        protected void btnConfirmarAgregar_Click(object sender, EventArgs e)
        {
            int idCurso = Convert.ToInt32(ddlCurso.SelectedValue.ToString());
            int idUsuario = Convert.ToInt32(ddlUsuario.SelectedValue.ToString());
            CompraServicio compraServicio = new CompraServicio();
            try
            {
                compraServicio.RegistrarCompraManual(idUsuario, idCurso);
                CargarCompras();
                MostrarMensaje("Exito", "Compra agregada satisfactoriamente", "success");
            }
            catch (Exception ex)
            {
                MostrarMensaje("Error", $"Error al registrar la compra: {ex.Message}", "error");
            }
        }
        private void CargarCompras()
        {
            UsuarioAutenticado usuarioAutenticado = Session["UsuarioAutenticado"] as UsuarioAutenticado;
            if (usuarioAutenticado == null) return;

            CompraServicio compraServicio = new CompraServicio();
            bool isAdmin = usuarioAutenticado.Rol == Rol.Administrador;
            if (isAdmin)
            {
                btnAgregar.Visible = true;
                phModal.Visible = true;
                CargarDropdownsCompraManual();
            }
            List<Compra> compras = compraServicio.getComprasPorIdUsuario(usuarioAutenticado.IdUsuario, isAdmin);
            repCompras.DataSource = compras;
            repCompras.DataBind();
        }

        private void MostrarMensaje(string titulo, string mensaje, string icono)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "sweetalert",
                $@"Swal.fire({{
            title: '{titulo}',
            text: '{mensaje}',
            icon: '{icono}',
            confirmButtonText: 'OK'
        }});", true);
        }
    }
}
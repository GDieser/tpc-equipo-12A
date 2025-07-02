using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Remoting.Messaging;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using AngleSharp.Html.Dom;
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
                UsuarioAutenticado usuario = Session["UsuarioAutenticado"] as UsuarioAutenticado;
                if (usuario == null)
                {
                    Session.Add("error", "Hey, no deberías andar por acá 🤨. Acceso no permitido");
                    Response.Redirect("Error.aspx");
                }

                CargarCompras();
            }
        }

        private void CargarDropdownsCompraManual()
        {

            UsuarioServicio usuarioServicio = new UsuarioServicio();
            var usuarios = usuarioServicio.ListarUsuarios().Where(u => u.Rol != Rol.Administrador).ToList();
            ddlUsuario.Items.Clear();
            ddlUsuario.DataSource = usuarios;
            ddlUsuario.DataTextField = "Email";
            ddlUsuario.DataValueField = "IdUsuario";
            ddlUsuario.DataBind();
            ddlUsuario.Items.Insert(0, new ListItem("Seleccionar Usuario", ""));


            ddlCurso.Items.Clear();
            ddlCurso.Items.Insert(0, new ListItem("Seleccione un usuario...", ""));
            ddlCurso.Enabled = false;
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
                ddlCurso.Items.Clear();
                ddlCurso.Items.Insert(0, new ListItem("Seleccionar...", ""));
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
            int idServicio;
            if (Request.QueryString["id"] != null)
            {
                if (usuarioAutenticado.IdUsuario != int.Parse(Request.QueryString["id"]))
                {
                    idServicio = int.Parse(Request.QueryString["id"]);
                    isAdmin = false;
                }
                else
                {
                    idServicio = usuarioAutenticado.IdUsuario;
                }
            }
            else
            {
                idServicio = usuarioAutenticado.IdUsuario;
            }
            List<Compra> compras = compraServicio.getComprasPorIdUsuario(idServicio, isAdmin);
            repCompras.DataSource = compras;
            repCompras.DataBind();
            updTabla.Update();
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

        protected void ddlUsuario_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlCurso.Items.Clear();
            ddlCurso.Items.Insert(0, new ListItem("Seleccionar...", ""));
            int idUsuario = Convert.ToInt32(ddlUsuario.SelectedValue.ToString());
            CursoServicio cursoServicio = new CursoServicio();

            var cursos = cursoServicio.ListarNoCompradosPorIdUsuario(idUsuario);
            ddlCurso.DataSource = cursos;
            ddlCurso.DataTextField = "Titulo";
            ddlCurso.DataValueField = "IdCurso";
            ddlCurso.DataBind();
            ddlCurso.Enabled = true;
            updDDL.Update();
        }
        protected void repCursos_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "EliminarCurso")
            {
                string[] args = e.CommandArgument.ToString().Split('|');
                int idCompra = int.Parse(args[0]);
                int idCurso = int.Parse(args[1]);
                CompraServicio compraServicio = new CompraServicio();
                compraServicio.EliminarDetalleCompra(idCurso, idCompra);
                CargarCompras();
                updDDL.Update();
                updTabla.Update();
                MostrarMensaje("Éxito", "Curso eliminado correctamente", "success");
            }
        }

        protected void repCursos_ItemCreated(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                ScriptManager scriptMan = ScriptManager.GetCurrent(this);

                LinkButton btnEliminar = e.Item.FindControl("btnEliminar") as LinkButton;

                if (btnEliminar != null)
                    scriptMan.RegisterAsyncPostBackControl(btnEliminar);
            }
        }

        protected void repCursos_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {

            if (e.Item.ItemType == ListItemType.Header)
            {
                UsuarioAutenticado usuario = Session["UsuarioAutenticado"] as UsuarioAutenticado;
                HtmlTableCell adminHeader = (HtmlTableCell)e.Item.FindControl("adminHeader");

                if (usuario != null && usuario.Rol != Rol.Administrador && adminHeader != null)
                {
                    adminHeader.Visible = false;
                }
            }

            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                LinkButton btnEliminar = (LinkButton)e.Item.FindControl("btnEliminar");
                btnEliminar.Attributes["data-uid"] = btnEliminar.UniqueID;

                UsuarioAutenticado usuario = Session["UsuarioAutenticado"] as UsuarioAutenticado;
                HtmlTableCell adminColumn = (HtmlTableCell)e.Item.FindControl("adminColumn");
                if (usuario != null && usuario.Rol != Rol.Administrador)
                {
                    adminColumn.Visible = false;
                }
            }
        }
    }
}
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
    public partial class ListaCategoriasAdmin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Seguridad.esAdmin(Session["UsuarioAutenticado"]))
            {
                Session.Add("error", "Hey, no deberías andar por acá 🤨. Acceso no permitido");
                Response.Redirect("Error.aspx");
            }

            if (!IsPostBack)
            {
                cargarCategorias();
            }
        }


        private void cargarCategorias()
        {
            CategoriaServicio servicio = new CategoriaServicio();
            dgvCategorias.DataSource = servicio.listar();
            dgvCategorias.DataBind();
        }

        protected void dgvCategorias_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            dgvCategorias.PageIndex = e.NewPageIndex;
            cargarCategorias();
        }

        protected void dgvCategorias_RowEditing(object sender, GridViewEditEventArgs e)
        {
            dgvCategorias.EditIndex = e.NewEditIndex;
            cargarCategorias();
        }

        protected void dgvCategorias_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            dgvCategorias.EditIndex = -1;
            cargarCategorias();
        }

      

        protected void btnAgregarCategoria_Click(object sender, EventArgs e)
        {
            Response.Redirect("AgregarCategoria.aspx");
        }
        protected void btnGuardarEdicionCategoria_Click(object sender, EventArgs e)
        {
            CategoriaServicio servicio = new CategoriaServicio();
            string nombre = txtEditarNombreCategoria.Text.Trim();
            bool activo = chkEditarActivo.Checked;

            if (string.IsNullOrEmpty(hfIdEditarCategoria.Value))
            {
                servicio.AgregarCategoriaSiNoExiste(nombre);
            }
            else
            {
                Categoria categoria = new Categoria
                {
                    IdCategoria = int.Parse(hfIdEditarCategoria.Value),
                    Nombre = nombre,
                    Activo = activo
                };

                servicio.ModificarConEstado(categoria);
            }

            cargarCategorias();

            ScriptManager.RegisterStartupScript(this, GetType(), "cerrarModal", "var modal = bootstrap.Modal.getInstance(document.getElementById('modalEditarCategoria')); if(modal) modal.hide();", true);
        }




    }
}
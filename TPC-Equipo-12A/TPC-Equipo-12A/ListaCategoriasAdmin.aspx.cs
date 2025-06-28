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
            if (!IsPostBack)
                cargarCategorias();
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
            Categoria categoria = new Categoria
            {
                IdCategoria = int.Parse(hfIdEditarCategoria.Value),
                Nombre = txtEditarNombreCategoria.Text,
                Activo = chkEditarActivo.Checked
            };

            servicio.ModificarConEstado(categoria);
            cargarCategorias();
        }


    }
}
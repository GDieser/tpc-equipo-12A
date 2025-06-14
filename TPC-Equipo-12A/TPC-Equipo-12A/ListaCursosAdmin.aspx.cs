using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Servicio;

namespace TPC_Equipo_12A
{
    public partial class ListaCursosAdmin : System.Web.UI.Page
    {
        // Servicio de cursos (ya deberías tenerlo implementado)
        private readonly CursoServicio servicio = new CursoServicio();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                CargarCursos();
        }

        /// <summary>
        /// Trae la lista de cursos (rol 0 = administrador) y la enlaza al GridView.
        /// </summary>
        private void CargarCursos()
        {
            try
            {
                dgvCursos.DataSource = servicio.Listar(0);   // 0 → sin filtrar estado
                dgvCursos.DataBind();
            }
            catch (Exception ex)
            {
                // Manejo sencillo; en un proyecto real loggearías el error
                Response.Write($"<script>alert('Error al cargar cursos: {ex.Message}');</script>");
            }
        }

        /// <summary>
        /// Paginación del GridView.
        /// </summary>
        protected void dgvCursos_PageIndexChanging(object sender, System.Web.UI.WebControls.GridViewPageEventArgs e)
        {
            dgvCursos.PageIndex = e.NewPageIndex;
            CargarCursos();
        }

        /// <summary>
        /// Se dispara al hacer clic en “✍️”. Redirige al editor.
        /// </summary>
        protected void dgvCursos_SelectedIndexChanged(object sender, EventArgs e)
        {
            int idCurso = (int)dgvCursos.DataKeys[dgvCursos.SelectedIndex].Value;
            Response.Redirect($"EditarCurso.aspx?id={idCurso}");
        }

        /// <summary>
        /// Botón "Agregar Nuevo Curso".
        /// </summary>
        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            Response.Redirect("CrearCurso.aspx");
        }
    }
}
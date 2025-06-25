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
        
        private readonly CursoServicio servicio = new CursoServicio();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Seguridad.esAdmin(Session["UsuarioAutenticado"]))
            {
                Session.Add("error", "Hey, no deberías andar por acá 🤨. Acceso no permitido");
                Response.Redirect("Error.aspx");
            }

            if (!IsPostBack)
                CargarCursos();
        }

       
        private void CargarCursos()
        {
            try
            {
                dgvCursos.DataSource = servicio.Listar(0);
                dgvCursos.DataBind();
            }
            catch (Exception ex)
            {
                
                Response.Write($"<script>alert('Error al cargar cursos: {ex.Message}');</script>");
            }
        }

        protected void dgvCursos_PageIndexChanging(object sender, System.Web.UI.WebControls.GridViewPageEventArgs e)
        {
            dgvCursos.PageIndex = e.NewPageIndex;
            CargarCursos();
        }

        protected void dgvCursos_SelectedIndexChanged(object sender, EventArgs e)
        {
            int idCurso = (int)dgvCursos.DataKeys[dgvCursos.SelectedIndex].Value;
            Response.Redirect($"CrearCurso.aspx?id={idCurso}");
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            Response.Redirect("CrearCurso.aspx");
        }
    }
}
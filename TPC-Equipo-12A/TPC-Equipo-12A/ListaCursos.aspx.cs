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
    public partial class ListaCurso : System.Web.UI.Page
    {
        public List<Dominio.Curso> ListaCursos;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int rol = 1; // por defecto "común"

                if (Session["UsuarioAutenticado"] != null)
                {
                    UsuarioAutenticado usuario = (UsuarioAutenticado)Session["UsuarioAutenticado"];
                    rol = Convert.ToInt16(usuario.Rol);
                }

                CursoServicio servicio = new CursoServicio();
                List<Curso> cursos = servicio.Listar(rol);

                rptCursos.DataSource = cursos;
                rptCursos.DataBind();
            }
        }

    }
}

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
                CursoServicio servicio = new CursoServicio();

            if (!IsPostBack)
            {
                ListaCursos = servicio.Listar();
              
                rptCursos.DataSource =ListaCursos;
                rptCursos.DataBind();
            }
        }
    }
}

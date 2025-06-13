using System;
using System.Collections.Generic;
using System.Linq;
using Dominio;
using Servicio;

namespace TPC_Equipo_12A
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CursoServicio ser = new CursoServicio();
                List<Curso> cursos = new List<Curso>();
                cursos = ser.Listar(1);

                var ultimos3 = cursos
                    .OrderByDescending(c => c.IdCurso)
                    .Take(3)
                    .ToList();

                rptCursos.DataSource = ultimos3;
                rptCursos.DataBind();


                FaqServicio servicio = new FaqServicio();
                List<PreguntasFrecuentes> faqs = new List<PreguntasFrecuentes>();
                faqs = servicio.Listar();

                rpdFaqs.DataSource = faqs;
                rpdFaqs.DataBind();


            }
        }
    }
}
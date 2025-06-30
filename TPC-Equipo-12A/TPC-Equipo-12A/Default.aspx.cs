using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dominio;
using Servicio;

namespace TPC_Equipo_12A
{
    public partial class Default : System.Web.UI.Page
    {
        protected UsuarioAutenticado usuario;
        protected void Page_Load(object sender, EventArgs e)
        {
            usuario = (UsuarioAutenticado)Session["UsuarioAutenticado"];

            if (!IsPostBack)
            {
                CursoServicio ser = new CursoServicio();
                List<Dominio.Curso> cursos = new List<Dominio.Curso>();
                try
                {
                    cursos = ser.Listar(1);

                    if (cursos != null && cursos.Any())
                    {
                        var ultimos3 = cursos
                            .OrderByDescending(c => c.IdCurso)
                            .Take(3)
                            .ToList();

                        rptCursos.DataSource = ultimos3;
                        rptCursos.DataBind();
                    }
                    else
                    {
                        rptCursos.Visible = false;
                    }

                    FaqServicio servicio = new FaqServicio();
                    List<PreguntasFrecuentes> faqs = servicio.ListarActivos();

                    if (faqs != null && faqs.Any())
                    {
                        rpdFaqs.DataSource = faqs;
                        rpdFaqs.DataBind();
                    }
                    else
                    {
                        rpdFaqs.Visible = false;
                    }
                    //capaz podria agregar msj personalizados, para mas adelante :D
                }
                catch (SqlException sqlEx) //este sirve para manejos para la bd, util en vario lugares (implmentar)
                {
                    lblError.Text = "Ocurrio un error al conectar con la base de datos. Por favor contacte al administrador." + sqlEx;
                }
                catch (Exception ex)
                {
                    lblError.Text = "Ocurrio un error inesperado. Por favor contacte al administrador." + ex;
                }
            }
        }

    }
}
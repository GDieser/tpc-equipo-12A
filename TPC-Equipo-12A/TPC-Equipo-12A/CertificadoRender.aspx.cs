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
    public partial class CertificadoRender : System.Web.UI.Page
    {
        private UsuarioAutenticado Usuario
        {
            get { return Session["UsuarioAutenticado"] as UsuarioAutenticado; }
            set { Session["UsuarioAutenticado"] = value; }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int idCurso;

                if (!int.TryParse(Request.QueryString["idCurso"], out idCurso) || Usuario == null)
                {
                    Session["error"] = "Parámetros inválidos para generar el certificado.";
                    Response.Redirect("Error.aspx");
                    return;
                }

                CursoServicio cursoServicio = new CursoServicio();

                if (!cursoServicio.EstaCursoFinalizado(idCurso, Usuario.IdUsuario))
                {
                    Session["error"] = "Usted no completo este curso... ";
                    return;
                }

                Dominio.Curso curso = cursoServicio.GetCursoPorId(idCurso);

                litNombreAlumno.Text = Usuario.Nombre + " " + Usuario.Apellido;
                litNombreCurso.Text = curso.Titulo;
                litFecha.Text = DateTime.Now.ToString("dd/MM/yyyy");
            }
        }
    }
}
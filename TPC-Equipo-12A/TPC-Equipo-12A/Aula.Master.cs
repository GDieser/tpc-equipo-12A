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
    public partial class Aula : System.Web.UI.MasterPage
    {
        protected UsuarioAutenticado usuario;
        
        protected void Page_Load(object sender, EventArgs e)
        {
            usuario = (UsuarioAutenticado)Session["UsuarioAutenticado"];

            if (usuario == null)
            {
                Session.Add("error", "Hey, no deberías andar por acá 🤨. Acceso no permitido");
                Response.Redirect("Error.aspx");
            }

            if (!IsPostBack)
            {
                var usuario = Session["UsuarioAutenticado"] as UsuarioAutenticado;
                if (usuario != null)
                {
                    CursoServicio cursoServicio = new CursoServicio();
                    var cursos = cursoServicio.ObtenerCursosCompletosDeUsuario(usuario); 
                    rptCursos.DataSource = cursos;
                    rptCursos.DataBind();
                }
            }
        }

        protected void rptCursos_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "VerCurso")
            {
                int idCurso = Convert.ToInt32(e.CommandArgument);
                Response.Redirect($"Curso.aspx?id={idCurso}");
            }
        }

        protected void rptModulos_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "VerModulo")
            {
                int idModulo = Convert.ToInt32(e.CommandArgument);
                Response.Redirect($"Modulo.aspx?id={idModulo}");
            }
        }

        protected void rptLecciones_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "VerLeccion")
            {
                int idLeccion = Convert.ToInt32(e.CommandArgument);
                Response.Redirect($"Leccion.aspx?id={idLeccion}");
            }
        }
    }
}

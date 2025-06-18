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
	public partial class Curso : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] == null)
                {
                    Session["error"] = "Debe indicar un ID de curso para poder acceder a ella.";
                    Response.Redirect("Error.aspx");
                }
                UsuarioAutenticado usuarioAutenticado = Session["UsuarioAutenticado"] as UsuarioAutenticado;
                if (usuarioAutenticado == null)
                {
                    Response.Redirect("Login.aspx");
                }
                int idCurso = int.Parse(Request.QueryString["id"]);
                bool isAdmin = (usuarioAutenticado.Rol == Rol.Administrador);

                CursoServicio cursoServicio = new CursoServicio();

                bool isHabilitado = cursoServicio.EsUsuarioHabilitado(usuarioAutenticado.IdUsuario, idCurso);
                if (isAdmin || isHabilitado)
                {
                    Dominio.Curso curso = cursoServicio.ObtenerCursoPorId(idCurso);

                    if (curso == null)
                    {
                        Session["error"] = "El curso no existe.";
                        Response.Redirect("Error.aspx");
                        return;
                    }

                    litTituloCurso.Text = curso.Titulo;
                    litIntroCurso.Text = curso.Descripcion;
                    imgBannerCurso.ImageUrl = curso.ImagenPortada == null ? "https://previews.123rf.com/images/monsitj/monsitj2007/monsitj200700029/153258909-programming-code-abstract-technology-background-of-software-developer-and-computer-script-banner-3d.jpg" : curso.ImagenPortada.Url;

                    rptModulos.DataSource = curso.Modulos;
                    rptModulos.DataBind();
                }
            }

        }
	}
}
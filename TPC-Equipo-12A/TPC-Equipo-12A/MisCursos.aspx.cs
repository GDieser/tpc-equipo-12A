using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Servicio;
using Dominio;

namespace TPC_Equipo_12A
{
    public partial class MisCursos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if ((UsuarioAutenticado)Session["UsuarioAutenticado"] == null)
            {
                Session.Add("error", "Hey, no deberías andar por acá 🤨. Acceso no permitido");
                Response.Redirect("Error.aspx");
            }
            if (!IsPostBack)
            {
                UsuarioAutenticado usuario = Session["UsuarioAutenticado"] as UsuarioAutenticado;
                CursoServicio cursoServicio = new CursoServicio();
                try
                {
                    List<Dominio.Curso> cursos = cursoServicio.getListaCursosPorIdUsuario(usuario.IdUsuario, usuario.Rol == Rol.Administrador);
                    if(cursos.Count() == 0)
                    {
                        lblMensaje.Visible = true;
                        lblMensaje.Text = "¡Nada por aca todavia!";
                        return;
                    }
                    rptCursos.DataSource = cursos;
                    rptCursos.DataBind();
                }
                catch (Exception ex)
                {
                    MostrarMensaje("Error", $"Error al mostrar tus cursos: {ex.Message}", "error");
                }
            }
        }
        private void MostrarMensaje(string titulo, string mensaje, string icono)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "sweetalert",
                $@"Swal.fire({{
            title: '{titulo}',
            text: '{mensaje}',
            icon: '{icono}',
            confirmButtonText: 'OK'
        }});", true);
        }

    }
}
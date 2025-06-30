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
    public partial class ForoCurso : System.Web.UI.Page
    {
        UsuarioAutenticado usuario;
        int IdCurso;
        protected void Page_Load(object sender, EventArgs e)
        {
            usuario = (UsuarioAutenticado)Session["UsuarioAutenticado"];
            CursoServicio servicio = new CursoServicio();
            DebateServicio serDebate = new DebateServicio();

            if (usuario == null)
            {
                Session.Add("error", "Hey, no deberías andar por acá 🤨. Acceso no permitido");
                Response.Redirect("Error.aspx");
            }

            if (usuario.Rol == Rol.Administrador)
                btnAviso.Visible = true;

            IdCurso = Convert.ToInt32(Request.QueryString["IdCurso"]);

            if (!IsPostBack)
            {
                Dominio.Curso curso = new Dominio.Curso();
                curso = servicio.GetCursoPorId(IdCurso);

                imgBannerCurso.ImageUrl = curso.ImagenPortada == null
                        ? "https://previews.123rf.com/images/monsitj/monsitj2007/monsitj200700029/153258909-programming-code-abstract-technology-background-of-software-developer-and-computer-script-banner-3d.jpg"
                        : curso.ImagenPortada.Url;
                litTituloCurso.Text = "Foro: " + curso.Titulo;

                rptAvisos.DataSource = serDebate.ListarDebates(IdCurso, 1);
                rptAvisos.DataBind();

                rptHilos.DataSource = serDebate.ListarDebates(IdCurso, 0);
                rptHilos.DataBind();

            }

        }

        protected void btnLecciones_Click(object sender, EventArgs e)
        {
            Response.Redirect("Curso.aspx?id=" + IdCurso, false);
        }

        protected void btnAviso_Click(object sender, EventArgs e)
        {
            phCuerpo.Visible = false;
            phNuevoAviso.Visible = true;
        }

        protected void btnCancelarAviso_Click(object sender, EventArgs e)
        {
            phCuerpo.Visible = true;
            phNuevoAviso.Visible = false;
        }

        protected void btnAgregarAviso_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(txtTitulo.Text))
                {
                    return;
                }

                string contenidoHilo = Request.Form[txtContenido.UniqueID]?.Trim() ?? string.Empty;
                if (string.IsNullOrWhiteSpace(contenidoHilo))
                {
                    return;
                }

                Debate debate = new Debate
                {
                    IdUsuario = usuario.IdUsuario,
                    IdOrigen = IdCurso,
                    Titulo = txtTitulo.Text.Trim(),
                    Contenido = txtContenido.Text.Trim(),
                    EsAviso = true
                };

                DebateServicio servicio = new DebateServicio();
                servicio.GuardarDebate(debate);

                txtTitulo.Text = string.Empty;
                txtContenido.Text = string.Empty;


                Response.Redirect(Request.RawUrl, false);
                Context.ApplicationInstance.CompleteRequest();

            }
            catch (Exception ex)
            {
                Session["error"] = "Error al guardar el aviso: " + ex.Message;
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void btnAgregarHilo_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(txtTituloHilo.Text))
                {
                    return;
                }

                string contenidoHilo = Request.Form[txtContenidoHilo.UniqueID]?.Trim() ?? string.Empty;
                if (string.IsNullOrWhiteSpace(contenidoHilo))
                {
                    return;
                }

                Debate debate = new Debate
                {
                    IdUsuario = usuario.IdUsuario,
                    IdOrigen = IdCurso,
                    Titulo = txtTituloHilo.Text.Trim(),
                    Contenido = contenidoHilo,
                    EsAviso = false
                };

                DebateServicio servicio = new DebateServicio();
                servicio.GuardarDebate(debate);



                Response.Redirect(Request.RawUrl, false);
                Context.ApplicationInstance.CompleteRequest();

            }
            catch (Exception ex)
            {
                Session["error"] = $"Error al guardar el hilo: {ex.Message}";
                ScriptManager.RegisterStartupScript(this, GetType(), "errorGuardado",
                    $"alert('Error: {ex.Message}');", true);
            }
        }

        protected void btnCancelarHilo_Click(object sender, EventArgs e)
        {
            txtTituloHilo.Text = string.Empty;


            phNuevoHilo.Visible = false;
            phCuerpo.Visible = true;

        }

        protected void btnMdlHilo_Click(object sender, EventArgs e)
        {
            phCuerpo.Visible = false;
            phNuevoHilo.Visible = true;
        }
    }
}
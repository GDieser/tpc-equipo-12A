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
    public partial class ForoDetalle : System.Web.UI.Page
    {
        public UsuarioAutenticado usuarioAutenticado;
        protected Debate debate;
        public bool respuesta = false;
        protected bool puedeEditar;
        protected void Page_Load(object sender, EventArgs e)
        {
            usuarioAutenticado = (UsuarioAutenticado)Session["UsuarioAutenticado"];

            if (usuarioAutenticado == null)
            {
                Session.Add("error", "Hey, no deberías andar por acá 🤨. Acceso no permitido");
                Response.Redirect("Error.aspx");
            }

            if (!IsPostBack)
            {
                int idDebate = Convert.ToInt32(Request.QueryString["id"]);
                DebateServicio servicio = new DebateServicio();
                debate = servicio.GetDebatePorId(idDebate);

                Session.Remove("DebateSeleccionado");
                Session.Add("DebateSeleccionado", debate);

                puedeEditar = PuedeEditarDebate(debate.IdUsuario, debate.FechaCreacion);

                if (debate != null)
                {
                    if(!debate.EsAviso)
                    {
                        btnAgregarComentario.Visible = true;
                        txtAgregarComentario.Visible = true;
                        //btnReportarHilo.Visible = true;
                    }

                    CargarDebate();
                    CargarComentarios();
                }
                else
                {
                    Response.Redirect("Error.aspx");
                }
            }
        }

        protected bool PuedeEditarDebate(int idUsuarioDebate, DateTime fechaCreacion)
        {
            if (usuarioAutenticado == null || usuarioAutenticado.IdUsuario != idUsuarioDebate)
            {
                return false;
            }

            TimeSpan diferencia = DateTime.Now - fechaCreacion;

            return diferencia.TotalMinutes <= 60;
        }

        protected void CargarDebate()
        {
            litTitulo.Text = Server.HtmlEncode(debate.Titulo);
            litNombreCompleto.Text = Server.HtmlEncode($"{debate.Nombre} {debate.Apellido}");
            litNombreUsuario.Text = Server.HtmlEncode(debate.NombreUsuario);
            litFecha.Text = debate.FechaCreacion.ToString("dd/MM/yyyy");
            litContenido.Text = debate.Contenido;
            imgPerfil.ImageUrl = debate.UrlImagen ?? "";
        }

        public void CargarComentarios()
        {
            int idOrigen = Convert.ToInt32(Request.QueryString["id"]);

            ComentarioServicio ser = new ComentarioServicio();
            List<Comentario> todos = ser.ListarPorOrigen(idOrigen, "debates");


            List<Comentario> principales = new List<Comentario>();
            List<Comentario> comentariosPrincipales = new List<Comentario>();
            List<Comentario> respuestas = new List<Comentario>();


            foreach (Comentario comentario in todos)
            {

                if (comentario.IdComentarioPadre == null)
                {

                    comentariosPrincipales.Add(comentario);
                }
                else
                {
                    respuestas.Add(comentario);
                }
            }
            respuestas = respuestas.OrderBy(r => r.FechaCreacion).ToList();

            foreach (Comentario principal in comentariosPrincipales)
            {
                Comentario comentarioConRespuestas = new Comentario
                {

                    IdComentario = principal.IdComentario,

                    IdUsuario = principal.IdUsuario,
                    TipoOrigen = principal.TipoOrigen,
                    IdOrigen = principal.IdOrigen,
                    IdComentarioPadre = principal.IdComentarioPadre,
                    Contenido = principal.Contenido,
                    FechaCreacion = principal.FechaCreacion,
                    FechaEdicion = principal.FechaEdicion,
                    EsEditado = principal.EsEditado,
                    NombreUsuario = principal.NombreUsuario,
                    UrlImagen = principal.UrlImagen,

                    Respuestas = new List<Comentario>()
                };

                foreach (Comentario respuesta in respuestas)
                {
                    if (respuesta.IdComentarioPadre == principal.IdComentario)
                    {


                        comentarioConRespuestas.Respuestas.Add(respuesta);
                    }
                }

                principales.Add(comentarioConRespuestas);
            }

            if (principales.Any() || todos.Any())
            {
                lblCantidadComentarios.Text = $"Comentarios ({todos.Count})";

                rptComentario.DataSource = principales;
                rptComentario.DataBind();

                pnlComentarios.Visible = true;
            }
            else
            {
                lblCantidadComentarios.Text = "Comentarios";
                pnlComentarios.Visible = true;
            }

        }

        protected void btnVolver_Click(object sender, EventArgs e)
        {
            Debate debate = (Debate)Session["DebateSeleccionado"];
            Response.Redirect("ForoCurso.aspx?IdCurso=" + debate.IdOrigen);
        }

        protected bool PuedeEditarComentario(int idUsuarioComentario, DateTime fechaCreacion)
        {

            if (usuarioAutenticado == null || usuarioAutenticado.IdUsuario != idUsuarioComentario)
            {
                return false;
            }

            TimeSpan diferencia = DateTime.Now - fechaCreacion;

            return diferencia.TotalHours <= 1;
        }

        protected void btnAgregarComentario_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(txtAgregarComentario.Text))
            {
                ComentarioServicio ser = new ComentarioServicio();

                Comentario com = new Comentario();

                com.IdUsuario = usuarioAutenticado.IdUsuario;
                com.TipoOrigen = "debates";
                com.IdOrigen = int.Parse(Request.QueryString["id"]);
                com.Contenido = txtAgregarComentario.Text;
                com.IdComentarioPadre = null;

                ser.AgregarComentario(com);

                txtAgregarComentario.Text = "";
                CargarComentarios();
            }
        }

        protected void rptComentario_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Responder")
            {
                Panel pnl = (Panel)e.Item.FindControl("pnlResponder");
                pnl.Visible = true;
                respuesta = true;
            }
            else if (e.CommandName == "EnviarRespuesta")
            {
                TextBox txtRespuesta = (TextBox)e.Item.FindControl("txtRespuesta");

                string[] args = e.CommandArgument.ToString().Split('|');
                if (args.Length == 2 && int.TryParse(args[0], out int idPadre))
                {
                    string nombreUsuario = args[1];
                    string textoRespuesta = txtRespuesta?.Text?.Trim();

                    if (!string.IsNullOrWhiteSpace(textoRespuesta) && !respuesta)
                    {
                        Comentario comentario = new Comentario
                        {
                            IdUsuario = usuarioAutenticado.IdUsuario,
                            TipoOrigen = "debates",
                            IdOrigen = int.Parse(Request.QueryString["id"]),
                            Contenido = $"@{nombreUsuario} {textoRespuesta}",
                            IdComentarioPadre = idPadre
                        };

                        ComentarioServicio ser = new ComentarioServicio();
                        ser.AgregarComentario(comentario);
                        respuesta = true;

                        CargarComentarios();
                        upComentarios.Update();

                    }
                }
            }
        }

        protected void rptRespuestas_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "ResponderRespuesta")
            {
                Panel pnl = (Panel)e.Item.FindControl("pnlReRespuesta");
                pnl.Visible = true;
                respuesta = true;
            }
            else if (e.CommandName == "EnviarReRespuesta")
            {
                TextBox txtRespuesta = (TextBox)e.Item.FindControl("txtReRespuesta");

                string[] args = e.CommandArgument.ToString().Split('|');
                if (args.Length == 2 && int.TryParse(args[0], out int idPadre))
                {
                    string nombreUsuario = args[1];
                    string textoRespuesta = txtRespuesta?.Text?.Trim();

                    if (!string.IsNullOrWhiteSpace(textoRespuesta) && !respuesta)
                    {
                        Comentario comentario = new Comentario
                        {
                            IdUsuario = usuarioAutenticado.IdUsuario,
                            TipoOrigen = "debates",
                            IdOrigen = int.Parse(Request.QueryString["id"]),
                            Contenido = $"@{nombreUsuario} {textoRespuesta}",
                            IdComentarioPadre = idPadre
                        };

                        ComentarioServicio ser = new ComentarioServicio();
                        ser.AgregarComentario(comentario);
                        respuesta = true;

                        CargarComentarios();
                        upComentarios.Update();

                    }
                }
            }
        }

        protected void btnEnviar_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(hfComentarioReportado.Value))
            {
                NotificacionesServicio ser = new NotificacionesServicio();
                Notificacion notifiacion = new Notificacion();

                notifiacion.IdOrigen = Convert.ToInt32(hfComentarioReportado.Value);
                notifiacion.EsReporte = true;
                notifiacion.MotivoReporte = ddlReporte.SelectedItem.Text.ToLower();
                notifiacion.IdUsuarioReportador = usuarioAutenticado.IdUsuario;

                ser.EnviarNotificacion(notifiacion);

                ScriptManager.RegisterStartupScript(this, GetType(), "cerrarModal", "$('#exampleModal').modal('hide');", true);
            }
        }

        protected void btnEliminarComentario_Click(object sender, EventArgs e)
        {
            ComentarioServicio ser = new ComentarioServicio();

            int idComentario = Convert.ToInt32(hfEliminar.Value);

            ser.EliminarComentario(idComentario);

            CargarComentarios();

            ScriptManager.RegisterStartupScript(this, GetType(), "cerrarModal", "$('#exampleModal').modal('hide');", true);
        }

        protected void btnGuardarEdicion_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(txtComentarioEditado.Text))
            {
                ComentarioServicio ser = new ComentarioServicio();

                int idComentario = Convert.ToInt32(hfIdComentarioEditar.Value);
                string nuevoContenido = txtComentarioEditado.Text;

                ser.ModificarComentario(idComentario, nuevoContenido);

                CargarComentarios();
                upComentarios.Update();

                ScriptManager.RegisterStartupScript(this, GetType(), "cerrarModal",
                    "$('#modalEdicion').modal('hide');", true);
            }
        }

        protected void btnEliminarHilo_Click(object sender, EventArgs e)
        {
            DebateServicio servicio = new DebateServicio();
            int idDebate = Convert.ToInt32(hfEliminarHilo.Value);

            Debate debate = (Debate)Session["DebateSeleccionado"];
            servicio.EliminarDebate(idDebate);

            ScriptManager.RegisterStartupScript(this, GetType(), "cerrarModalHilo", "$('#modalEliminarHilo').modal('hide');", true);

            Response.Redirect("ForoCurso.aspx?IdCurso=" + debate.IdOrigen);
        }

        protected void btnEditarHilo_Click(object sender, EventArgs e)
        {
            phCuerpo.Visible = false;
            Debate debate = (Debate)Session["DebateSeleccionado"];

            if (debate.EsAviso)
            {
                phNuevoAviso.Visible = true;

                txtTitulo.Text = debate.Titulo;
                txtContenido.Text = debate.Contenido;

                
                ScriptManager.RegisterStartupScript(this, GetType(), "setCkEditorAviso",
                    $"CKEDITOR.instances['{txtContenido.ClientID}'].setData({HttpUtility.JavaScriptStringEncode(debate.Contenido)});", true);
            }
            else
            {
                phNuevoHilo.Visible = true;

                txtTituloHilo.Text = debate.Titulo;
                txtContenidoHilo.InnerText = debate.Contenido;

                ScriptManager.RegisterStartupScript(this, GetType(), "setCkEditorHilo",
                    $"CKEDITOR.instances['{txtContenidoHilo.ClientID}'].setData({HttpUtility.JavaScriptStringEncode(debate.Contenido)});", true);
            }
        }

        protected void btnCancelarAviso_Click(object sender, EventArgs e)
        {
            phCuerpo.Visible = true;
            phNuevoAviso.Visible = false;

            Response.Redirect(Request.RawUrl);
        }

        protected void btnEditarAviso_Click(object sender, EventArgs e)
        {
            DebateServicio servicio = new DebateServicio();

            int idDebate = Convert.ToInt32(Request.QueryString["id"]);
            string nuevoTitulo = txtTitulo.Text;
            string nuevoContenido = txtContenido.Text.Trim();

            servicio.EditarDebate(idDebate, nuevoTitulo, nuevoContenido);

            Response.Redirect(Request.RawUrl);
        }

        protected void btnCancelarHilo_Click(object sender, EventArgs e)
        {
            phCuerpo.Visible = true;
            phNuevoHilo.Visible = false;

            Response.Redirect(Request.RawUrl);
        }


        protected void btnEditHilo_Click(object sender, EventArgs e)
        {
            DebateServicio servicio = new DebateServicio();

            int idDebate = Convert.ToInt32(Request.QueryString["id"]);
            string nuevoTitulo = txtTituloHilo.Text;
            string nuevoContenido = Request.Form[txtContenidoHilo.UniqueID];

            servicio.EditarDebate(idDebate, nuevoTitulo, nuevoContenido);

            Response.Redirect(Request.RawUrl);
        }
    }
}
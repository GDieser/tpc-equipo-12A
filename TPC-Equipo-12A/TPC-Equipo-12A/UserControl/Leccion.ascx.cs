using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dominio;
using Ganss.Xss;
using Servicio;
using Utils;

namespace TPC_Equipo_12A.UserControl
{
    public partial class Leccion : System.Web.UI.UserControl
    {
        public int IdLeccion { get; set; }
        public int IdCurso
        {
            get => ViewState["IdCurso"] as int? ?? 0;
            private set => ViewState["IdCurso"] = value;
        }
        public int IdModulo
        {
            get => ViewState["IdModulo"] as int? ?? 0;
            private set => ViewState["IdModulo"] = value;
        }
        public string NombreCurso
        {
            get => ViewState["NombreCurso"] as string ?? string.Empty;
            private set => ViewState["NombreCurso"] = value;
        }
        public string NombreModulo
        {
            get => ViewState["NombreModulo"] as string ?? string.Empty;
            private set => ViewState["NombreModulo"] = value;
        }

        public event EventHandler<ControlEventArgs> VistaCambiada;
        protected void OnVistaCambiada(string vista, int id)
        {
            VistaCambiada?.Invoke(this, new ControlEventArgs(id, vista));
        }
        private int LeccionActual
        {
            get => ViewState["IdLeccion"] as int? ?? 0;
            set => ViewState["IdLeccion"] = value;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (LeccionActual != IdLeccion)
            {
                InicializarLeccion();
                LeccionActual = IdLeccion;
            }
        }

        private void InicializarLeccion()
        {
            var usuario = Session["UsuarioAutenticado"] as UsuarioAutenticado;
            if (usuario == null)
                Response.Redirect("Login.aspx");

            var servicio = new LeccionServicio();
            bool isAdmin = usuario.Rol == Rol.Administrador;
            bool isHabilitado = servicio.EsUsuarioHabilitado(usuario.IdUsuario, IdLeccion);

            if (!isAdmin && !isHabilitado)
                RedirigirError("Usted no tiene permisos para acceder a esta lección.");

            var leccion = servicio.ObtenerPorId(IdLeccion, usuario.IdUsuario);
            if (leccion == null)
                RedirigirError("La lección solicitada no existe.");

            if (!isAdmin && leccion.Estado != EstadoPublicacion.Publicado)
                RedirigirError("La lección está momentáneamente deshabilitada.");

            IdCurso = leccion.IdCurso;
            NombreCurso = leccion.NombreCurso;
            IdModulo = leccion.IdModulo;
            NombreModulo = leccion.NombreModulo;

            litTitulo.Text = leccion.Titulo;
            litDescripcion.Text = leccion.Introduccion;
            litContenido.Text = leccion.Contenido;
            Session["Leccion"] = leccion;

            if (!isAdmin)
                btnAgregarContenido.Visible = false;

            if (leccion.Completado)
            {
                btnMarcarCompletada.Text = "¡Lección completada!";
                btnMarcarCompletada.Enabled = false;
                btnMarcarCompletada.CssClass = "btn btn-success";
            }

            RegistrarScriptCKEditor();
            ScriptManager.RegisterStartupScript(
                this,
                GetType(),
                "initCKEditor",
                "CKEDITOR.replace('" + txtContenidoHTML.ClientID + "', { " +
                   "extraAllowedContent: 'iframe[*]'," +
                   "contentsCss: ['https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css']," +
                   "height: 1000 " +
                "});",
                true);

            phContenido.Visible = false;
        }

        private void RedirigirError(string mensaje)
        {
            Session["error"] = mensaje;
            Response.Redirect("Error.aspx");
        }

        public void mensajeSweetAlert(string mensaje, string titulo, string tipo)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "sweetalert",
                        $@"Swal.fire({{
                            title: '{titulo}',
                            text: '{mensaje}',
                            icon: '{tipo}',
                            confirmButtonText: 'OK'
                        }})", true);
        }

        protected void btnMarcarCompletada_Click(object sender, EventArgs e)
        {
            LeccionServicio leccionServicio = new LeccionServicio();
            UsuarioAutenticado usuarioAutenticado = Session["UsuarioAutenticado"] as UsuarioAutenticado;
            int idLeccion = int.Parse(Request.QueryString["id"]);
            if (leccionServicio.MarcarCompletada(idLeccion, usuarioAutenticado.IdUsuario))
            {
                btnMarcarCompletada.Text = "¡Lección completada!";
                btnMarcarCompletada.Enabled = false;
                btnMarcarCompletada.CssClass = "btn btn-success";
            }
            mensajeSweetAlert("¡Lección completada!", "Excelente", "success");
        }

        protected void btnGuardarContenido_Click(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsValid)
                {
                    return;
                }
                LeccionServicio leccionServicio = new LeccionServicio();
                string contenidoHtml = Request.Form[txtContenidoHTML.UniqueID];
                if (string.IsNullOrEmpty(contenidoHtml))
                {
                    mensajeSweetAlert("El contenido HTML no puede estar vacío.", "Error", "error");
                    return;
                }
                HtmlSanitizer sanitizer = new HtmlSanitizer();
                sanitizer.AllowedTags.Add("iframe");
                sanitizer.AllowedAttributes.Add("src");
                sanitizer.AllowedAttributes.Add("width");
                sanitizer.AllowedAttributes.Add("height");
                sanitizer.AllowedAttributes.Add("frameborder");
                sanitizer.AllowedAttributes.Add("allow");
                sanitizer.AllowedAttributes.Add("allowfullscreen");

                contenidoHtml = sanitizer.Sanitize(contenidoHtml);

                Dominio.Leccion leccion = (Dominio.Leccion)Session["Leccion"];

                if (leccion != null)
                {
                    leccion.Titulo = txtTitulo.Text;
                    leccion.Introduccion = txtIntroduccion.Text;
                    leccion.Contenido = contenidoHtml;
                    Session["Leccion"] = leccion;
                    litContenido.Text = leccion.Contenido;
                    litTitulo.Text = leccion.Titulo;
                    litDescripcion.Text = leccion.Introduccion;
                }
                else
                {
                    mensajeSweetAlert("Leccion inexistente", "ERROR", "error");
                    return;
                }

                leccionServicio.ActualizarOCrear(leccion);
                IdCurso = leccion.IdCurso;
                NombreCurso = leccion.NombreCurso;
                IdModulo = leccion.IdModulo;
                NombreModulo = leccion.NombreModulo;
                litContenido.Text = leccion.Contenido;
                litTitulo.Text = leccion.Titulo;
                litDescripcion.Text = leccion.Introduccion;
                mensajeSweetAlert("¡Leccion guardada correctamente!", "¡Éxito!", "success");


                phContenido.Visible = false;
                btnAgregarContenido.Visible = true;
                phCuerpo.Visible = true;

                btnGuardarContenido.Visible = false;
                btnGuardarContenido.Enabled = false;
                litContenido.Visible = true;

            }
            catch (Exception ex)
            {
                mensajeSweetAlert($"Error: {ex.Message}", "ERROR", "error");
            }
        }
        protected void btnAgregarContenido_Click(object sender, EventArgs e)
        {
            txtContenidoHTML.InnerText = litContenido.Text;
            txtTitulo.Text = litTitulo.Text;
            txtIntroduccion.Text = litDescripcion.Text;

            phContenido.Visible = true;
            btnAgregarContenido.Visible = false;
            phCuerpo.Visible = false;

            btnGuardarContenido.Visible = true;
            btnGuardarContenido.Enabled = true;
        }

        protected void btnCancelarEdicion_Click(object sender, EventArgs e)
        {
            phContenido.Visible = false;
            btnAgregarContenido.Visible = true;
            phCuerpo.Visible = true;
        }

        private void RegistrarScriptCKEditor()
        {
            string script = @"
        CKEDITOR.replace('" + txtContenidoHTML.ClientID + @"', {
            extraAllowedContent: 'iframe[*]',
            contentsCss: ['https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css'],
            height: 1000
        });
    ";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "initCKEditor", script, true);
        }
    }
}
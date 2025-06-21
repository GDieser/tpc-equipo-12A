using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using Dominio;
using Ganss.Xss;
using Servicio;
using static System.Collections.Specialized.BitVector32;

namespace TPC_Equipo_12A
{
    public partial class Leccion : System.Web.UI.Page
    {
        public int IdCurso { get; set; } = 0;
        public int IdModulo { get; set; } = 0;
        public string NombreCurso { get; set; } = string.Empty;
        public string NombreModulo { get; set; } = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] == null)
                {
                    redirigirConError("Debe indicar un ID de lección para poder acceder a ella.");
                }

                var usuarioAutenticado = Session["UsuarioAutenticado"] as UsuarioAutenticado;
                if (usuarioAutenticado == null)
                {
                    Response.Redirect("Login.aspx");
                    return;
                }

                int idLeccion;
                if (!int.TryParse(Request.QueryString["id"], out idLeccion))
                {
                    redirigirConError("ID de lección inválido.");
                }

                bool isAdmin = usuarioAutenticado.Rol == Rol.Administrador;

                LeccionServicio leccionServicio = new LeccionServicio();
                bool isHabilitado = leccionServicio.EsUsuarioHabilitado(usuarioAutenticado.IdUsuario, idLeccion);

                if (!isAdmin && !isHabilitado)
                {
                    redirigirConError("Usted no tiene permisos para acceder a este curso");
                }

                Dominio.Leccion leccion = leccionServicio.ObtenerPorId(idLeccion, usuarioAutenticado.IdUsuario);
                if (leccion == null)
                {
                    redirigirConError("La lección a la que intentas acceder no existe");
                }

                if (!isAdmin && leccion.Estado != EstadoPublicacion.Publicado)
                {
                    redirigirConError("La lección está momentáneamente deshabilitada");
                }

                if (!isAdmin)
                    btnAgregarContenido.Visible = false;

                IdCurso = leccion.IdCurso;
                NombreCurso = leccion.NombreCurso;
                IdModulo = leccion.IdModulo;
                NombreModulo = leccion.NombreModulo;
                litTitulo.Text = leccion.Titulo;
                litDescripcion.Text = leccion.Introduccion;
                litContenido.Text = leccion.Contenido;
                Session["Leccion"] = leccion;
                phContenido.Visible = false;

                if (leccion.Completado)
                {
                    btnMarcarCompletada.Text = "¡Lección completada!";
                    btnMarcarCompletada.Enabled = false;
                    btnMarcarCompletada.CssClass = "btn btn-success";
                }
            }
        }


        public void redirigirConError(string mensaje)
        {
            Session["error"] = mensaje;
            Response.Redirect("Error.aspx");
            return;
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
    }
}
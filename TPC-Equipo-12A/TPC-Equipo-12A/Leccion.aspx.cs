using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dominio;
using Servicio;
using static System.Collections.Specialized.BitVector32;

namespace TPC_Equipo_12A
{
    public partial class Leccion : System.Web.UI.Page
    {
        public int IdCurso { get; set; } = 0;
        public int IdModulo { get; set; } = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] == null)
                {
                    Session["error"] = "Debe indicar un ID de lección para poder acceder a ella.";
                    Response.Redirect("Error.aspx");
                }
                UsuarioAutenticado usuarioAutenticado = Session["UsuarioAutenticado"] as UsuarioAutenticado;
                int idLeccion = int.Parse(Request.QueryString["id"]);
                bool isAdmin = (usuarioAutenticado.Rol == Rol.Administrador);

                LeccionServicio leccionServicio = new LeccionServicio();

                bool isHabilitado = leccionServicio.EsUsuarioHabilitado(usuarioAutenticado.IdUsuario, idLeccion);
                if (isAdmin || isHabilitado)
                {
                    Dominio.Leccion leccion = leccionServicio.ObtenerPorId(idLeccion);
                    if (leccion == null)
                    {
                        string titulo = "Curso inexistente";
                        string mensaje = "El curso al que intentas acceder no existe";
                        string tipo = TipoErrorUtils.EnumATexto(TipoError.ERROR);
                        mensajeSweetAlert(mensaje, titulo, tipo);
                    }
                    if (!isAdmin && leccion.Estado != EstadoPublicacion.Publicado)
                    {
                        string titulo = "Curso Deshabilitado";
                        string mensaje = "El curso esta momentaneamente deshabilitado";
                        string tipo = TipoErrorUtils.EnumATexto(TipoError.WARNING);
                        mensajeSweetAlert(mensaje, titulo, tipo);
                        return;
                    }
                    IdCurso = leccion.IdCurso;
                    IdModulo = leccion.IdModulo;
                    litTitulo.Text = leccion.Titulo;
                    litDescripcion.Text = leccion.Introduccion;
                    foreach (Componente comp in leccion.Componentes)
                    {
                        litContenido.Text += RenderizarComponente(comp);
                    }
                }
                else
                {
                    string titulo = "Permiso denegado";
                    string mensaje = "Usted no tiene permisos para acceder a este curso";
                    string tipo = TipoErrorUtils.EnumATexto(TipoError.ERROR);
                    mensajeSweetAlert(mensaje, titulo, tipo);
                    return;
                }
            }
        }


        protected string RenderizarComponente(Componente comp)
        {
            if (comp == null) return "";

            string html = "";

            switch ((int)comp.TipoContenido)
            {
                case 0: 
                    html = $"<div class='my-4 text-justify'>{comp.Contenido}</div>";
                    break;

                case 1: 
                    html = $"<div class='text-center my-4'><img src='{comp.Contenido}' class='img-fluid rounded' alt='Imagen lección' /></div>";
                    break;

                case 2:
                    html = $@"
                    <div class='text-center my-4'>
                        <div class='ratio ratio-16x9'>
                            <iframe src='{TransformarAEmbed(comp.Contenido)}' 
                                    frameborder='0' 
                                    allow='accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share' 
                                    allowfullscreen>
                            </iframe>
                        </div>
                    </div>"; 
                    break;
                case 3: 
                    html = $@"
            <div class='my-3'>
                <i class='bi bi-file-earmark-text-fill text-primary'></i>
                <a href='{comp.Contenido}' target='_blank'>Ver archivo</a>
            </div>";
                    break;
            }
            return html;
        }


        public void mensajeSweetAlert(string mensaje, string titulo, string tipo)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "sweetalert",
                        $@"Swal.fire({{
                            title: '{titulo}',
                            text: '{mensaje}',
                            icon: '{tipo}',
                            confirmButtonText: 'OK'
                        }}).then((result) => {{
                            if (result.isConfirmed) {{
                                window.location.href = 'Default.aspx';
                            }}
                        }});", true);
        }

        private string TransformarAEmbed(string url)
        {
            if (url.Contains("watch?v="))
            {
                var videoId = url.Split(new[] { "watch?v=" }, StringSplitOptions.None)[1].Split('&')[0];
                return $"https://www.youtube.com/embed/{videoId}";
            }
            else if (url.Contains("youtu.be/"))
            {
                var videoId = url.Split(new[] { "youtu.be/" }, StringSplitOptions.None)[1].Split('?')[0];
                return $"https://www.youtube.com/embed/{videoId}";
            }
            else if (url.Contains("youtube.com/embed/"))
            {
                return url; // Ya está en formato correcto
            }

            return ""; // URL no válida o no reconocida
        }

    }
}
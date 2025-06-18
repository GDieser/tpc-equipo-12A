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
                    Dominio.Leccion leccion = leccionServicio.ObtenerPorId(idLeccion, usuarioAutenticado.IdUsuario);
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

                    rptComponentes.DataSource = leccion.Componentes;
                    rptComponentes.DataBind();

                    if (leccion.Completado)
                    {
                        btnMarcarCompletada.Text = "¡Lección completada!";
                        btnMarcarCompletada.Enabled = false;
                        btnMarcarCompletada.CssClass = "btn btn-success";
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


        protected void rptComponentes_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                var comp = (Componente)e.Item.DataItem;

                var pnlTexto = (Panel)e.Item.FindControl("pnlTexto");
                var pnlImagen = (Panel)e.Item.FindControl("pnlImagen");
                var pnlVideo = (Panel)e.Item.FindControl("pnlVideo");
                var pnlArchivo = (Panel)e.Item.FindControl("pnlArchivo");

                switch ((int)comp.TipoContenido)
                {
                    case 0: // Texto
                        pnlTexto.Visible = true;
                        ((Literal)e.Item.FindControl("litTexto")).Text = comp.Contenido;
                        break;

                    case 1: // Imagen
                        pnlImagen.Visible = true;
                        ((Image)e.Item.FindControl("imgContenido")).ImageUrl = comp.Contenido;
                        break;

                    case 2: // Video
                        var phVideo = (PlaceHolder)e.Item.FindControl("phVideo");
                        phVideo.Visible = true;

                        string iframeHtml = $@"
                                            <div class='my-4 d-flex justify-content-center'>
                                                <div class='ratio ratio-16x9' style='width: 50%;'>
                                                    <iframe src='{TransformarAEmbed(comp.Contenido)}' frameborder='0' allowfullscreen
                                                        allow='accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share'>
                                                    </iframe>
                                                </div>
                                            </div>";

                        phVideo.Controls.Add(new Literal { Text = iframeHtml });
                        break;



                    case 3: // Archivo
                        pnlArchivo.Visible = true;
                        HyperLink hiperlink = (HyperLink)(e.Item.FindControl("lnkArchivo"));
                        hiperlink.NavigateUrl = comp.Contenido.ToString();
                        hiperlink.Text = comp.Titulo.ToString();
                        break;
                }
            }
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
        }
    }
}
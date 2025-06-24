using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dominio;
using Servicio;

namespace TPC_Equipo_12A
{
    public partial class DetalleNovedad : System.Web.UI.Page
    {
        Publicacion novedad;
        public UsuarioAutenticado usuarioAutenticado;
        public bool respuesta = false;

        protected void Page_Load(object sender, EventArgs e)
        {
            NovedadesServicio servicio = new NovedadesServicio();

            //rptComentarios.ItemCommand += rptComentarios_ItemCommand;

            if (Session["UsuarioAutenticado"] != null)
            {
                usuarioAutenticado = (UsuarioAutenticado)Session["UsuarioAutenticado"];

                if (usuarioAutenticado.Rol == 0)
                {
                    btnModificar.Visible = true;
                }
                else
                {
                    btnModificar.Visible = false;
                }
            }
            else
            {
                btnModificar.Visible = false;
            }

            if (!IsPostBack)
            {
                int id = Request.QueryString["IdNovedad"] != null ? int.Parse(Request.QueryString["IdNovedad"]) : 1;

                novedad = servicio.GetPublicacion(id);

                Session.Remove("NovedadSeleccionada");
                Session.Add("NovedadSeleccionada", novedad);

                CargarNovedad();

                CargarComentarios();

            }

        }


        public void CargarNovedad()
        {
            imgBanner.ImageUrl = novedad.Imagenes[1].Url;
            lblTitulo.Text = novedad.Titulo;
            lblFechaPublicacion.Text = "Publicado el: " + novedad.FechaPublicacion.ToString();
            lblResumen.Text = novedad.Resumen;
            //lblDescripcion.Text = novedad.Descripcion;

            litDescripcion.Text = novedad.Descripcion;
        }

        public void CargarComentarios()
        {
            int idOrigen = Convert.ToInt32(Request.QueryString["IdNovedad"]);

            ComentarioServicio ser = new ComentarioServicio();
            List<Comentario> todos = ser.ListarPorOrigen(idOrigen);


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


        protected void btnModificar_Click(object sender, EventArgs e)
        {
            Response.Redirect("FormularioPublicacion.aspx");
        }

        protected void btnAgregarComentario_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(txtAgregarComentario.Text))
            {
                ComentarioServicio ser = new ComentarioServicio();

                Comentario com = new Comentario();

                com.IdUsuario = usuarioAutenticado.IdUsuario;
                com.TipoOrigen = "novedades";
                com.IdOrigen = int.Parse(Request.QueryString["IdNovedad"]);
                com.Contenido = txtAgregarComentario.Text;
                com.IdComentarioPadre = null;

                ser.AgregarComentario(com);

                txtAgregarComentario.Text = "";
                CargarComentarios();
            }
        }

        protected void rptComentarios_ItemCommand(object source, RepeaterCommandEventArgs e)
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

                if (!string.IsNullOrWhiteSpace(txtRespuesta.Text) && int.TryParse(e.CommandArgument.ToString(), out int idPadre) && !respuesta)
                {
                    Comentario comentario = new Comentario
                    {
                        IdUsuario = usuarioAutenticado.IdUsuario,
                        TipoOrigen = "novedades",
                        IdOrigen = int.Parse(Request.QueryString["IdNovedad"]),
                        Contenido = txtRespuesta.Text,
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
}
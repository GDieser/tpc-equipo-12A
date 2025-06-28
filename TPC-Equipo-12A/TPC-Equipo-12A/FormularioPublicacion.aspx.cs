using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Servicio;
using Dominio;
using Ganss.Xss;

namespace TPC_Equipo_12A
{
    public partial class NuevaPublicacion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Seguridad.esAdmin(Session["UsuarioAutenticado"]))
            {
                Session.Add("error", "Hey, no deberías andar por acá 🤨. Acceso no permitido");
                Response.Redirect("Error.aspx");
            }

            try
            {

                if (!IsPostBack)
                {
                    CategoriaServicio servicio = new CategoriaServicio();
                    List<Categoria> lista = servicio.ListarActivas();

                    ddlCategoria.DataSource = lista;
                    ddlCategoria.DataValueField = "IdCategoria";
                    ddlCategoria.DataTextField = "Nombre";
                    ddlCategoria.DataBind();

                    ddlEstado.Items.Add(new ListItem("Borrador", "0"));
                    ddlEstado.Items.Add(new ListItem("Publicado", "1"));
                    ddlEstado.Items.Add(new ListItem("Oculto", "2"));
                }

                if (Session["NovedadSeleccionada"] != null && !IsPostBack)
                {
                    Publicacion novedad = (Publicacion)Session["NovedadSeleccionada"];

                    txtTitulo.Text = novedad.Titulo;
                    txtResumen.Text = novedad.Resumen;

                    txtDes.InnerText = novedad.Descripcion;

                    ddlCategoria.SelectedValue = novedad.Categoria.IdCategoria.ToString();
                    ddlEstado.SelectedValue = ((int)novedad.Estado).ToString();

                    txtMiniatura.Text = novedad.Imagenes[0].Url;
                    txtImagen.Text = novedad.Imagenes[1].Url;
                    txtImagen_TextChanged(sender, e);
                }

            }
            catch (Exception ex)
            {

                Session.Add("Error", ex.ToString());
                Response.Redirect("Error.aspx");
            }
        }

        protected void txtImagen_TextChanged(object sender, EventArgs e)
        {
            imgPreviewMin.ImageUrl = txtMiniatura.Text;
            imgPreview.ImageUrl = txtImagen.Text;
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                Publicacion nueva = new Publicacion();
                NovedadesServicio servicio = new NovedadesServicio();

                nueva.Titulo = txtTitulo.Text;
                nueva.Resumen = txtResumen.Text;

                //nueva.Descripcion = txtDescripcion.Text;

                /*string descIngreso = Request.Form[txtDes.UniqueID];
                HtmlSanitizer sanit = new HtmlSanitizer();


                string descAux = sanit.Sanitize(descIngreso);*/
                /*
                string url = txtUrl.Text;
                string ancho = txtAncho.Text;
                string alto = txtAlto.Text;

                string videoId = ObtenerIdDeYoutube(url);

                string iframe = $"<hr /> <iframe width=\"{ancho}\" height=\"{alto}\" src=\"https://www.youtube.com/embed/{videoId}\" ></iframe> <hr />";
                */
                nueva.Descripcion = Request.Form[txtDes.UniqueID];


                nueva.Categoria = new Categoria();
                nueva.Categoria.IdCategoria = int.Parse(ddlCategoria.SelectedValue);

                nueva.Estado = new EstadoPublicacion();
                nueva.Estado = (EstadoPublicacion)Convert.ToInt32(ddlEstado.SelectedValue);

                nueva.FechaCreacion = DateTime.Now;
                nueva.FechaPublicacion = DateTime.Now;

                List<Imagen> listaImg = new List<Imagen>();
                Imagen img1 = new Imagen();

                img1.Url = txtMiniatura.Text;
                img1.Nombre = "Miniatura";
                listaImg.Add(img1);

                Imagen img2 = new Imagen();
                img2.Url = txtImagen.Text;
                img2.Nombre = "Banner";
                listaImg.Add(img2);

                nueva.Imagenes = listaImg;

                if (Session["NovedadSeleccionada"] != null)
                {
                    Publicacion novedad = (Publicacion)Session["NovedadSeleccionada"];
                    nueva.IdPublicacion = novedad.IdPublicacion;
                    nueva.Imagenes[0].IdImagen = novedad.Imagenes[0].IdImagen;
                    nueva.Imagenes[1].IdImagen = novedad.Imagenes[1].IdImagen;

                    servicio.modificarPublicacion(nueva);

                }
                else
                {
                    servicio.AgregarPublicacion(nueva);
                }


                Response.Redirect("Novedades.aspx", false);

            }
            catch (Exception ex)
            {

                Session.Add("Error", ex.ToString());
                Response.Redirect("Error.aspx");
            }
        }

        /*private string ObtenerIdDeYoutube(string url)
        {
            try
            {
                Uri uri = new Uri(url);
                var query = System.Web.HttpUtility.ParseQueryString(uri.Query);
                string videoId = query["v"];
                                
                if (string.IsNullOrEmpty(videoId) && uri.Host.Contains("youtu.be"))
                {
                    videoId = uri.AbsolutePath.Trim('/');
                }

                return videoId;
            }
            catch
            {
                return null;
            }
        }*/
    }
}
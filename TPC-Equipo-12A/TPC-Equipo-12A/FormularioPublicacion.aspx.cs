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
    public partial class NuevaPublicacion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {

                if (!IsPostBack)
                {
                    CategoriaServicio servicio = new CategoriaServicio();
                    List<Categoria> lista = servicio.listar();

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
                    txtDescripcion.Text = novedad.Descripcion;

                    ddlCategoria.SelectedValue = novedad.Categoria.IdCategoria.ToString();
                    ddlEstado.SelectedValue = ((int)novedad.Estado).ToString();

                    txtImagen.Text = novedad.UrlImagen;
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
                nueva.Descripcion = txtDescripcion.Text;
               
                nueva.Categoria = new Categoria();
                nueva.Categoria.IdCategoria = int.Parse(ddlCategoria.SelectedValue);
                
                nueva.Estado = new EstadoPublicacion();
                nueva.Estado = (EstadoPublicacion)Convert.ToInt32(ddlEstado.SelectedValue);

                nueva.FechaCreacion = DateTime.Now;
                nueva.FechaPublicacion = DateTime.Now;

                nueva.Url = txtImagen.Text;

                if(Session["NovedadSeleccionada"] != null)
                {
                    Publicacion novedad = (Publicacion)Session["NovedadSeleccionada"];
                    nueva.IdPublicacion = novedad.IdPublicacion;
                    nueva.Imagenes = novedad.Imagenes;

                    servicio.modificarPublicacion(nueva);
                
                }
                else
                {
                    servicio.agregar(nueva);
                }

                
                Response.Redirect("Novedades.aspx", false);

            }
            catch (Exception ex)
            {

                Session.Add("Error", ex.ToString());
                Response.Redirect("Error.aspx");
            }
        }
    }
}
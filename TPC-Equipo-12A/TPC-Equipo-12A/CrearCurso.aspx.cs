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
    public partial class CrearCurso : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                cargarCategorias();
            }
        }

        private void cargarCategorias()
        {
            CategoriaServicio servicio = new CategoriaServicio();
            ddlCategoria.DataSource = servicio.listar();    
            ddlCategoria.DataTextField = "Nombre";
            ddlCategoria.DataValueField = "IdCategoria";
            ddlCategoria.DataBind();
        }

        protected void txtImagen_TextChanged(object sender, EventArgs e)
        {
            imgPreview.ImageUrl = txtImagen.Text;
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            Curso nuevo = new Curso();
            CursoServicio cursoServicio = new CursoServicio();

            try
            {

                nuevo.Titulo = txtTitulo.Text;
                nuevo.Resumen = txtResumen.Text;
                nuevo.Descripcion = Request.Form[txtDescripcion.UniqueID];
                nuevo.Precio = decimal.Parse(txtPrecio.Text);
                nuevo.Duracion = int.Parse(txtDuracion.Text);
                nuevo.Certificado = chkCertificado.Checked;
                nuevo.FechaCreacion = DateTime.Now;
                nuevo.FechaPublicacion = DateTime.Now;
                nuevo.Estado = EstadoPublicacion.Publicado;

                nuevo.Categoria = new Categoria
                {
                    IdCategoria = int.Parse(ddlCategoria.SelectedValue)
                };

                nuevo.ImagenPortada = new Imagen
                {
                    Url = txtImagen.Text,        
                    Nombre = "Imagen curso",      // agregar txtbox a formulario 
                    Tipo = 1                      //  agragar lista tipo a formulario
                };

                cursoServicio.GuardarCurso(nuevo);

                Response.Redirect("ListaCursos.aspx");
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error al guardar curso: " + ex.Message + "');</script>");
            }
        }

    }
}

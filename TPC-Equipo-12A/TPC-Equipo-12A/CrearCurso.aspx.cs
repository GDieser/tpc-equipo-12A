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
        private Dominio.Curso cursoSeleccionado;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                cargarCategorias();
                cargarEstados();

                if (Request.QueryString["id"] != null)
                {
                    litTituloFormulario.Text = "Modificar curso";
                    int id = int.Parse(Request.QueryString["id"]);
                    CursoServicio s = new CursoServicio();
                    cursoSeleccionado = s.GetCursoPorId(id);

                    if (cursoSeleccionado != null)
                    {
                        txtTitulo.Text = cursoSeleccionado.Titulo;
                        txtResumen.Text = cursoSeleccionado.Resumen;
                        txtDescripcion.InnerText = cursoSeleccionado.Descripcion;
                        txtPrecio.Text = cursoSeleccionado.Precio.ToString();
                        txtDuracion.Text = cursoSeleccionado.Duracion.ToString();
                        chkCertificado.Checked = cursoSeleccionado.Certificado;
                        ddlCategoria.SelectedValue = cursoSeleccionado.Categoria.IdCategoria.ToString();
                        ddlEstado.SelectedValue = ((int)cursoSeleccionado.Estado).ToString();
                        txtImagen.Text = cursoSeleccionado.ImagenPortada.Url;
                        imgPreview.ImageUrl = cursoSeleccionado.ImagenPortada.Url;
                        Session["CursoSeleccionado"] = cursoSeleccionado;
                    }

                }
                else
                {
                    litTituloFormulario.Text = "Crear nuevo curso";
                }

            }
            else
            {
               
                cursoSeleccionado = (Dominio.Curso)Session["CursoSeleccionado"];
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

        private void cargarEstados()
        {
            ddlEstado.Items.Clear();
            foreach (EstadoPublicacion estado in Enum.GetValues(typeof(EstadoPublicacion)))
            {
                ddlEstado.Items.Add(new ListItem(estado.ToString(), ((int)estado).ToString()));
            }
        }


        protected void txtImagen_TextChanged(object sender, EventArgs e)
        {
            imgPreview.ImageUrl = txtImagen.Text;
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            Dominio.Curso nuevo = new Dominio.Curso();
            CursoServicio cursoServicio = new CursoServicio();
            decimal precio;
            int duracion;

            if (!decimal.TryParse(txtPrecio.Text, out precio) || precio < 0)
            {
                Response.Write("<script>alert('Ingrese un precio válido.');</script>");
                return;
            }

            if (!int.TryParse(txtDuracion.Text, out duracion) || duracion <= 0)
            {
                Response.Write("<script>alert('Ingrese una duración válida.');</script>");
                return;
            }

            CursoServicio s = new CursoServicio();
            Dominio.Curso entidad = new Dominio.Curso
            {
                Titulo = txtTitulo.Text,
                Resumen = txtResumen.Text,
                Descripcion = Request.Form[txtDescripcion.UniqueID],
                Precio = precio,
                Duracion = duracion,
                Certificado = chkCertificado.Checked,
                FechaCreacion = DateTime.Now,
                FechaPublicacion = DateTime.Now,
                Estado = (EstadoPublicacion)int.Parse(ddlEstado.SelectedValue),
                Categoria = new Categoria { IdCategoria = int.Parse(ddlCategoria.SelectedValue) },
                ImagenPortada = new Imagen { Url = txtImagen.Text, Nombre = "Imagen curso", Tipo = 1 }
            };

            if (cursoSeleccionado != null)
            {
                entidad.IdCurso = cursoSeleccionado.IdCurso;
                entidad.ImagenPortada.IdImagen = cursoSeleccionado.ImagenPortada.IdImagen;
                s.ModificarCurso(entidad);
            }
            else
            {
                s.GuardarCurso(entidad);
            }

            Response.Redirect("ListaCursosAdmin.aspx");
        }


    }
}


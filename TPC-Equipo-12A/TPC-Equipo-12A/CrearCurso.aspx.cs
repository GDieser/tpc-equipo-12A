using System;
using System.Collections.Generic;
using System.Diagnostics.Eventing.Reader;
using System.IO;
using System.Linq;
using System.Net.NetworkInformation;
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

            if (!Seguridad.esAdmin(Session["UsuarioAutenticado"]))
            {
                Session.Add("error", "Hey, no deberías andar por acá 🤨. Acceso no permitido");
                Response.Redirect("Error.aspx");
            }

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
                        txtUrlImagen.Text = cursoSeleccionado.ImagenPortada.Url;
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

        protected void cargarCategorias()
        {
            CategoriaServicio servicio = new CategoriaServicio();
            ddlCategoria.DataSource = servicio.ListarActivas();
            ddlCategoria.DataTextField = "Nombre";
            ddlCategoria.DataValueField = "IdCategoria";
            ddlCategoria.DataBind();
            ddlCategoria.Items.Add(new ListItem("Nueva categoría", "-1"));
        }

        protected void btnGuardarCategoriaModal_Click(object sender, EventArgs e)
        {
            string nombre = txtNuevaCategoriaModal.Text.Trim();
            if (nombre.Length == 0) return;

            CategoriaServicio servicio = new CategoriaServicio();
            Categoria nueva = servicio.AgregarCategoriaSiNoExiste(nombre);

            cargarCategorias();

            ListItem item = ddlCategoria.Items.FindByValue(nueva.IdCategoria.ToString());

            if (item == null)
            {
                ddlCategoria.Items.Add(new ListItem(nueva.Nombre, nueva.IdCategoria.ToString()));
            }

            ddlCategoria.SelectedValue = nueva.IdCategoria.ToString();
            txtNuevaCategoriaModal.Text = string.Empty;

            ScriptManager.RegisterStartupScript(this, GetType(), "cerrarModal", @"
        setTimeout(function() {
            var modal = bootstrap.Modal.getInstance(document.getElementById('modalNuevaCategoria'));
            if (modal) {
                modal.hide();
            }
        }, 200);", true);
        }


        private void cargarEstados()
        {
            ddlEstado.Items.Clear();
            foreach (EstadoPublicacion estado in Enum.GetValues(typeof(EstadoPublicacion)))
            {
                ddlEstado.Items.Add(new ListItem(estado.ToString(), ((int)estado).ToString()));
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
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
                Categoria = new Categoria { IdCategoria = int.Parse(ddlCategoria.SelectedValue) }
            };

            bool imagenAsignada = false;

            if (fuImagenCurso.HasFile)
            {
                string extension = Path.GetExtension(fuImagenCurso.FileName).ToLower();
                var extensionesPermitidas = new[] { ".jpg", ".jpeg", ".png", ".webp", ".gif" };

                if (!extensionesPermitidas.Contains(extension))
                {
                    Response.Write("<script>alert('Formato de imagen no válido.');</script>");
                    return;
                }

                string nombreArchivo = $"curso-{Guid.NewGuid()}{extension}";
                string rutaRelativa = $"~/imagenes/cursos/{nombreArchivo}";
                string rutaFisica = Server.MapPath(rutaRelativa);

                try
                {
                    fuImagenCurso.SaveAs(rutaFisica);
                    entidad.ImagenPortada = new Imagen
                    {
                        Url = ResolveUrl(rutaRelativa),
                        Nombre = nombreArchivo
                    };
                    imagenAsignada = true;
                }
                catch (Exception)
                {
                    Response.Write("<script>alert('Error al guardar la imagen.');</script>");
                    return;
                }
            }
            else if (!string.IsNullOrWhiteSpace(txtUrlImagen.Text))
            {
                if (cursoSeleccionado?.ImagenPortada != null && cursoSeleccionado.ImagenPortada.Url == txtUrlImagen.Text)
                {
                    entidad.ImagenPortada = cursoSeleccionado.ImagenPortada;
                }
                else
                {
                    string nombreImagen = $"Imagen portada - {entidad.Titulo}";

                    if (nombreImagen.Length > 50)
                    {
                        nombreImagen = nombreImagen.Substring(0, 50);
                    }

                    entidad.ImagenPortada = new Imagen
                    {
                        Url = txtUrlImagen.Text,
                        Nombre = nombreImagen
                    };
                }
                imagenAsignada = true;
            }

            if (cursoSeleccionado?.ImagenPortada != null &&
                cursoSeleccionado.ImagenPortada.IdImagen > 0)
            {
                entidad.ImagenPortada.IdImagen = cursoSeleccionado.ImagenPortada.IdImagen;
            }
            else
            {
                entidad.ImagenPortada.IdImagen = 0;
            }

            int idCurso;

            if (!imagenAsignada && cursoSeleccionado?.ImagenPortada != null)
            {
                entidad.ImagenPortada = cursoSeleccionado.ImagenPortada;
            }

            if (cursoSeleccionado != null)

            {
                entidad.IdCurso = cursoSeleccionado.IdCurso;
                idCurso = cursoSeleccionado.IdCurso;
                cursoServicio.ModificarCurso(entidad);
            }
            else
            {
                idCurso = cursoServicio.GuardarCurso(entidad);
            }
            Session.Remove("CursoSeleccionado");

            Response.Redirect($"Curso.aspx?id={idCurso}");
        }

        protected void txtUrlImagen_TextChanged(object sender, EventArgs e)
        {
            imgPreview.ImageUrl = txtUrlImagen.Text;
        }
    }
}


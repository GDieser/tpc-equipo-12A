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
    public partial class Curso : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] == null)
                {
                    Session["error"] = "Debe indicar un ID de curso para poder acceder a ella.";
                    Response.Redirect("Error.aspx");
                }
                UsuarioAutenticado usuarioAutenticado = Session["UsuarioAutenticado"] as UsuarioAutenticado;
                if (usuarioAutenticado == null)
                {
                    Response.Redirect("Login.aspx");
                }
                int idCurso = int.Parse(Request.QueryString["id"]);
                bool isAdmin = (usuarioAutenticado.Rol == Rol.Administrador);

                CursoServicio cursoServicio = new CursoServicio();

                bool isHabilitado = cursoServicio.EsUsuarioHabilitado(usuarioAutenticado.IdUsuario, idCurso);
                if (isAdmin || isHabilitado)
                {
                    Dominio.Curso curso = cursoServicio.ObtenerCursoPorId(idCurso);

                    if (curso == null)
                    {
                        Session["error"] = "El curso no existe.";
                        Response.Redirect("Error.aspx");
                        return;
                    }
                    Session["Curso"] = curso;
                    litTituloCurso.Text = curso.Titulo;
                    litIntroCurso.Text = curso.Descripcion;
                    imgBannerCurso.ImageUrl = curso.ImagenPortada == null ? "https://previews.123rf.com/images/monsitj/monsitj2007/monsitj200700029/153258909-programming-code-abstract-technology-background-of-software-developer-and-computer-script-banner-3d.jpg" : curso.ImagenPortada.Url;

                    rptModulos.DataSource = curso.Modulos;
                    rptModulos.DataBind();
                }
            }
        }

        protected void btnGuardarModulo_Click(object sender, EventArgs e)
        {

            Dominio.Curso curso = (Dominio.Curso)Session["Curso"];

            string titulo = txtTituloLeccion.Text.Trim();
            string introduccion = txtIntroLeccion.Text.Trim();
            string imagenUrl = txtImagenLeccion.Text.Trim();

            if (string.IsNullOrEmpty(titulo) || string.IsNullOrEmpty(introduccion))
                return;

            if (curso.Modulos == null)
                curso.Modulos = new List<Dominio.Modulo>();

            int.TryParse(hfIdLeccion.Value, out int idModulo);
            if (idModulo <= 0)
            {
                int minimo = 0;
                if (curso.Modulos.Min(m => m.IdModulo) > 0)
                {
                    minimo = 0;
                }
                else
                {
                    minimo = curso.Modulos.Min(m => m.IdModulo);
                }
                idModulo = minimo - 1;
            }

            Imagen imagen = new Imagen
            {
                IdImagen = 0,
                Nombre = string.IsNullOrEmpty(imagenUrl) ? "Imagen por defecto" : $"Banner módulo {curso.Titulo}",
                Url = string.IsNullOrEmpty(imagenUrl)
                    ? "https://www.entramar.mvl.edu.ar/wp-content/uploads/2018/06/lenguajes-800x445.webp"
                    : imagenUrl
            };

            Dominio.Modulo modulo = new Dominio.Modulo
            {
                IdModulo = idModulo,
                Titulo = titulo,
                Introduccion = introduccion,
                imagen = imagen,
                Orden = curso.Modulos.Count
            };

            int index = curso.Modulos.FindIndex(m => m.IdModulo == idModulo);
            if (index >= 0)
                curso.Modulos[index] = modulo;
            else
                curso.Modulos.Add(modulo);

            curso.Modulos = curso.Modulos.OrderBy(m => m.Orden).ToList();
            Session["Curso"] = curso;

            rptModulos.DataSource = curso.Modulos;
            rptModulos.DataBind();

            ScriptManager.RegisterStartupScript(this, GetType(), "cerrarModal", @"
            const modalEl = document.getElementById('modalLeccion');
            if (modalEl) {
                const modal = bootstrap.Modal.getOrCreateInstance(modalEl);
                modal.hide();
                document.body.classList.remove('modal-open');
                const backdrop = document.querySelector('.modal-backdrop');
                if (backdrop) backdrop.remove();
            }", true);

            txtTituloLeccion.Text = "";
            txtIntroLeccion.Text = "";
            txtImagenLeccion.Text = "";
            hfIdLeccion.Value = "";
            hfIdImagen.Value = "";
        }

        protected void rptModulos_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int id = int.Parse(e.CommandArgument.ToString());
            Dominio.Curso curso = (Dominio.Curso)Session["Curso"];

            switch (e.CommandName)
            {
                case "Subir":
                    ReordenarModulo(curso.Modulos, id, -1);
                    break;

                case "Bajar":
                    ReordenarModulo(curso.Modulos, id, +1);
                    break;

                case "Editar":
                    Dominio.Modulo modulo = curso.Modulos.FirstOrDefault(x => x.IdModulo == id);
                    if (modulo != null)
                    {
                        hfIdLeccion.Value = modulo.IdModulo.ToString();
                        hfIdImagen.Value = modulo.imagen?.IdImagen.ToString() ?? "0";
                        txtTituloLeccion.Text = modulo.Titulo;
                        txtIntroLeccion.Text = modulo.Introduccion;
                        txtImagenLeccion.Text = modulo.imagen?.Url ?? "";

                        ScriptManager.RegisterStartupScript(this, GetType(), "abrirModal",
                            "var modal = new bootstrap.Modal(document.getElementById('modalLeccion')); modal.show();", true);
                    }
                    break;
            }

            curso.Modulos = curso.Modulos.OrderBy(m => m.Orden).ToList();
            Session["Curso"] = curso;
            rptModulos.DataSource = curso.Modulos;
            rptModulos.DataBind();
        }

        private void ReordenarModulo(List<Dominio.Modulo> modulos, int idModulo, int desplazamiento)
        {
            List<Dominio.Modulo> listaOrdenada = modulos.OrderBy(m => m.Orden).ToList();
            int index = listaOrdenada.FindIndex(m => m.IdModulo == idModulo);

            int nuevoIndex = index + desplazamiento;

            if (index < 0 || nuevoIndex < 0 || nuevoIndex >= listaOrdenada.Count)
                return;

            Dominio.Modulo actual = listaOrdenada[index];
            Dominio.Modulo destino = listaOrdenada[nuevoIndex];

            int temp = actual.Orden;
            actual.Orden = destino.Orden;
            destino.Orden = temp;
        }

        protected void btnGuardarCambios_Click(object sender, EventArgs e)
        {
            Dominio.Curso curso = (Dominio.Curso)Session["Curso"];
            ModuloServicio moduloServicio = new ModuloServicio();

            if (curso.Modulos != null && curso.Modulos.Any())
            {
                foreach (Dominio.Modulo modulo in curso.Modulos)
                {
                    modulo.IdCurso = curso.IdCurso;
                    moduloServicio.ActualizarOCrear(modulo);
                }
            }
        }
    }
}
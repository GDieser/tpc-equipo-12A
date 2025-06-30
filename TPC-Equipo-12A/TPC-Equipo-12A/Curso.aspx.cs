using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using Dominio;
using Servicio;

namespace TPC_Equipo_12A
{
    public partial class Curso : System.Web.UI.Page
    {

        public UsuarioAutenticado UsuarioAutenticado
        {
            get
            {
                return Session["UsuarioAutenticado"] as UsuarioAutenticado;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] == null)
                {
                    Session["error"] = "Debe indicar un ID de curso para poder acceder a ella.";
                    Response.Redirect("Error.aspx");
                }

                if (UsuarioAutenticado == null)
                {
                    Response.Redirect("Login.aspx");
                }

                ScriptManager.GetCurrent(this.Page).RegisterAsyncPostBackControl(rptModulos);

                int idCurso = int.Parse(Request.QueryString["id"]);
                bool isAdmin = (UsuarioAutenticado.Rol == Rol.Administrador);
                CursoServicio cursoServicio = new CursoServicio();
                bool isHabilitado = cursoServicio.EsUsuarioHabilitado(UsuarioAutenticado.IdUsuario, idCurso);

                if (isAdmin || isHabilitado)
                {

                    btnAgregarLeccion.Visible = isAdmin;
                    btnGuardarCambios.Visible = isAdmin;

                    Dominio.Curso curso = cursoServicio.ObtenerCursoPorId(idCurso, UsuarioAutenticado.IdUsuario);
                    if (curso == null)
                    {
                        Session["error"] = "El curso no existe.";
                        Response.Redirect("Error.aspx");
                        return;
                    }

                    Session["Curso"] = curso;
                    litTituloCurso.Text = curso.Titulo;
                    litIntroCurso.Text = curso.Resumen;
                    imgBannerCurso.ImageUrl = curso.ImagenPortada == null
                        ? "https://previews.123rf.com/images/monsitj/monsitj2007/monsitj200700029/153258909-programming-code-abstract-technology-background-of-software-developer-and-computer-script-banner-3d.jpg"
                        : curso.ImagenPortada.Url;

                    curso.Modulos = curso.Modulos.OrderBy(m => m.Orden).ToList();
                    btnGuardarCambios.Enabled = false;
                    Session["Curso"] = curso;
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

            if (string.IsNullOrEmpty(titulo) || string.IsNullOrEmpty(introduccion))
                return;

            if (curso.Modulos == null)
                curso.Modulos = new List<Dominio.Modulo>();

            string imagenUrl = null;
            int idImagen = 0;
            string nombreImagen = "";

            if (fuImagenLeccion.HasFile)
            {
                string extension = Path.GetExtension(fuImagenLeccion.FileName).ToLower();
                var extensionesPermitidas = new[] { ".jpg", ".jpeg", ".png", ".webp", ".gif" };

                if (!extensionesPermitidas.Contains(extension))
                {
                    MostrarMensaje("Error", "El archivo debe ser extension: .jpg, .jpeg, .png, .webp, .gif", "error");
                    return;
                }

                string nombreArchivo = $"leccion-{Guid.NewGuid()}{extension}";
                string rutaRelativa = $"~/imagenes/modulos/{nombreArchivo}";
                string rutaFisica = Server.MapPath(rutaRelativa);

                try
                {
                    fuImagenLeccion.SaveAs(rutaFisica);
                }
                catch (Exception)
                {
                    MostrarMensaje("Error", "Error al cargar el archivo", "error");
                    return;
                }

                imagenUrl = rutaRelativa;
                nombreImagen = nombreArchivo;

                Imagen img = new Imagen { Url = rutaRelativa, Nombre = nombreArchivo };
                idImagen = new ImagenServicio().agregarImagen(img);
            }
            else
            {
                imagenUrl = "~/imagenes/modulos/default-modulo.jpg";
                nombreImagen = "Imagen por defecto";
                idImagen = 0;
            }

            int.TryParse(hfIdLeccion.Value, out int idModulo);
            if (idModulo == 0)
            {
                int minimo = curso.Modulos.Any() ? curso.Modulos.Min(m => m.IdModulo) : 0;
                idModulo = (minimo <= 0 ? minimo : 0) - 1;
            }

            var modExistente = curso.Modulos.FirstOrDefault(m => m.IdModulo == idModulo);
            int orden = modExistente != null
                ? modExistente.Orden
                : curso.Modulos.Any() ? curso.Modulos.Max(m => m.Orden) + 1 : 1;

            Imagen imagen = new Imagen
            {
                IdImagen = idImagen,
                Nombre = nombreImagen,
                Url = imagenUrl
            };

            Dominio.Modulo modulo = new Dominio.Modulo
            {
                IdModulo = idModulo,
                Titulo = titulo,
                Introduccion = introduccion,
                imagen = imagen,
                Orden = orden
            };

            int index = curso.Modulos.FindIndex(m => m.IdModulo == idModulo);
            if (index >= 0)
                curso.Modulos[index] = modulo;
            else
                curso.Modulos.Add(modulo);

            curso.Modulos = curso.Modulos.OrderBy(m => m.Orden).ToList();
            Session["Curso"] = curso;

            btnGuardarCambios.Enabled = true;

            rptModulos.DataSource = curso.Modulos;
            rptModulos.DataBind();

            CerrarModal("modalLeccion");
            LimpiarCamposFormulario();
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
                        txtNombreArchivoLeccion.Text = Path.GetFileName(modulo.imagen?.Url ?? "");

                        updModal.Update();
                        ScriptManager.RegisterStartupScript(this, GetType(), "abrirModal",
                            "var modal = new bootstrap.Modal(document.getElementById('modalLeccion')); modal.show();", true);
                    }
                    break;

                case "Eliminar":
                    if (id > 0)
                    {
                        ModuloServicio moduloServicio = new ModuloServicio();
                        try
                        {
                            moduloServicio.Eliminar(id);
                        }
                        catch (Exception ex)
                        {
                            MostrarMensaje("¡Ups...!", $"¡Ocurrio un problema: {ex.Message}!", "error");
                        }
                        finally
                        {
                            Response.Redirect($"Curso.aspx?id={((Dominio.Curso)Session["Curso"]).IdCurso}");
                        }
                    }
                    else
                    {
                        curso.Modulos.RemoveAll(m => m.IdModulo == id);
                        Session["Curso"] = curso;

                        rptModulos.DataSource = curso.Modulos.OrderBy(m => m.Orden).ToList();
                        rptModulos.DataBind();

                        MostrarMensaje("¡Info!", "Módulo eliminado correctamente.", "success");
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

            ModuloServicio moduloServicio = new ModuloServicio();

            try
            {
                foreach (Dominio.Modulo modulo in modulos)
                {
                    moduloServicio.ActualizarOCrear(modulo);
                }
                ActualizarCursoEnSesionYBindear();
                MostrarMensaje("¡Exito!", "¡Curso Actualizado Correctamente!", "success");
            }
            catch (Exception ex)
            {
                MostrarMensaje("¡Ups...!", $"¡Ocurrió un problema: {ex.Message}!", "error");
            }
        }

        protected void btnGuardarCambios_Click(object sender, EventArgs e)
        {
            Dominio.Curso curso = (Dominio.Curso)Session["Curso"];
            ModuloServicio moduloServicio = new ModuloServicio();

            try
            {
                if (curso.Modulos != null && curso.Modulos.Any())
                {
                    foreach (Dominio.Modulo modulo in curso.Modulos)
                    {
                        modulo.IdCurso = curso.IdCurso;
                        moduloServicio.ActualizarOCrear(modulo);
                    }
                }

                MostrarMensaje("¡Exito!", "¡Curso Actualizado Correctamente!", "success");
                ActualizarCursoEnSesionYBindear();
                btnGuardarCambios.Enabled = false;

            }
            catch (Exception ex)
            {
                MostrarMensaje("¡Ups...!", $"¡Ocurrió un problema: {ex.Message}!", "error");
            }
        }

        private void MostrarMensaje(string titulo, string mensaje, string icono)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "sweetalert",
                $@"Swal.fire({{
            title: '{titulo}',
            text: '{mensaje}',
            icon: '{icono}',
            confirmButtonText: 'OK'
        }});", true);
        }

        private void CerrarModal(string idModal)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "cerrarModal", $@"
        const modalEl = document.getElementById('{idModal}');
        if (modalEl) {{
            const modal = bootstrap.Modal.getOrCreateInstance(modalEl);
            modal.hide();
        }}
        document.body.classList.remove('modal-open');
        const backdrop = document.querySelector('.modal-backdrop');
        if (backdrop) backdrop.remove();", true);
        }

        private void LimpiarCamposFormulario()
        {
            txtTituloLeccion.Text = "";
            txtIntroLeccion.Text = "";
            txtNombreArchivoLeccion.Text = "";
            hfIdLeccion.Value = "";
            hfIdImagen.Value = "";
        }

        private void ActualizarCursoEnSesionYBindear()
        {
            CursoServicio cursoServicio = new CursoServicio();
            Dominio.Curso curso = cursoServicio.ObtenerCursoPorId(((Dominio.Curso)Session["Curso"]).IdCurso, UsuarioAutenticado.IdUsuario);

            if (curso == null)
            {
                Session["error"] = "El curso no existe.";
                Response.Redirect("Error.aspx");
                return;
            }

            Session["Curso"] = curso;
            rptModulos.DataSource = curso.Modulos.OrderBy(m => m.Orden).ToList();
            rptModulos.DataBind();
        }

        protected void rptModulos_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                LinkButton btnEliminar = (LinkButton)e.Item.FindControl("btnEliminar");
                if (btnEliminar != null)
                {
                    btnEliminar.Attributes["data-uid"] = btnEliminar.UniqueID;
                }

                var grupoAdmin = (HtmlGenericControl)e.Item.FindControl("grupoAdmin");
                if (grupoAdmin != null && UsuarioAutenticado != null)
                {
                    grupoAdmin.Visible = UsuarioAutenticado.Rol == Rol.Administrador;
                }

                var modulo = (Dominio.Modulo)e.Item.DataItem;
                var iconoEstado = (Literal)e.Item.FindControl("ltEstadoModulo");

                bool estaCompleto = ModuloServicio.EstaCompletoModulo(modulo);
                string color = estaCompleto ? "text-success bi-check-circle-fill" : "text-secondary bi-circle-fill";
                string tooltip = estaCompleto ? "Completado" : "Incompleto";

                iconoEstado.Text = $"<i class='bi {color}' title='{tooltip}' style='margin-left: 10px;'></i>";
            }
        }

        protected void rptModulos_ItemCreated(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                ScriptManager scriptMan = ScriptManager.GetCurrent(this);

                LinkButton btnSubir = e.Item.FindControl("btnSubir") as LinkButton;
                LinkButton btnBajar = e.Item.FindControl("btnBajar") as LinkButton;
                LinkButton btnEditar = e.Item.FindControl("btnEditar") as LinkButton;
                LinkButton btnEliminar = e.Item.FindControl("btnEliminar") as LinkButton;

                if (btnSubir != null)
                    scriptMan.RegisterAsyncPostBackControl(btnSubir);

                if (btnBajar != null)
                    scriptMan.RegisterAsyncPostBackControl(btnBajar);

                if (btnEditar != null)
                    scriptMan.RegisterAsyncPostBackControl(btnEditar);

                if (btnEliminar != null)
                    scriptMan.RegisterAsyncPostBackControl(btnEliminar);
            }
        }
    }
}
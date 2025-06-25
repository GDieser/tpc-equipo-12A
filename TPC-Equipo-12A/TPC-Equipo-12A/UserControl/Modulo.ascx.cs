using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dominio;
using Servicio;
using Utils;

namespace TPC_Equipo_12A.UserControl
{
    public partial class Modulo : System.Web.UI.UserControl
    {
        public int IdModulo { get; set; }

        public event EventHandler<ControlEventArgs> VistaCambiada;
        public void OnVistaCambiada(string vista, int id)
        {
            VistaCambiada?.Invoke(this, new ControlEventArgs(id, vista));
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            InicializarModulo();
        }

        private void InicializarModulo()
        {
            if (IdModulo == 0)
                Response.Redirect("Error.aspx");

            var usuario = (UsuarioAutenticado)Session["UsuarioAutenticado"];
            if (!(new ModuloServicio().EsUsuarioHabilitado(usuario.IdUsuario, IdModulo) || (usuario.Rol == Rol.Administrador)))
                Response.Redirect("Error.aspx?mensaje=No tienes acceso");

            var modulo = new ModuloServicio()
                             .ObtenerModuloPorId(IdModulo, usuario.IdUsuario);

            Session["Modulo"] = modulo;
            imgModulo.ImageUrl = modulo.imagen.Url;
            litTitulo.Text = modulo.Titulo;
            litIntro.Text = modulo.Introduccion;

            BindLecciones();
        }

        private void BindLecciones()
        {
            var modulo = (Dominio.Modulo)Session["Modulo"];
            rptLecciones.DataSource = modulo.Lecciones.OrderBy(l => l.Orden);
            rptLecciones.DataBind();
        }


        protected void btnGuardarLeccion_Click(object sender, EventArgs e)
        {
            Dominio.Modulo modulo = (Dominio.Modulo)Session["Modulo"];

            int.TryParse(hfIdLeccion.Value, out int idLeccion);
            string titulo = txtTituloLeccion.Text;
            string introduccion = txtIntroLeccion.Text;

            if (string.IsNullOrWhiteSpace(titulo) || string.IsNullOrWhiteSpace(introduccion))
                return;

            if (modulo.Lecciones == null)
                modulo.Lecciones = new List<Dominio.Leccion>();

            if (idLeccion == 0)
            {
                int minimo = modulo.Lecciones.Any() ? modulo.Lecciones.Min(l => l.IdLeccion) : 0;
                idLeccion = (minimo <= 0 ? minimo : 0) - 1;
            }

            var lecExistente = modulo.Lecciones.FirstOrDefault(l => l.IdLeccion == idLeccion);
            int orden = lecExistente != null
                ? lecExistente.Orden
                : modulo.Lecciones.Any() ? modulo.Lecciones.Max(l => l.Orden) + 1 : 1;

            Dominio.Leccion leccion = new Dominio.Leccion
            {
                IdLeccion = idLeccion,
                Titulo = titulo,
                Introduccion = introduccion,
                Orden = orden
            };

            int index = modulo.Lecciones.FindIndex(l => l.IdLeccion == idLeccion);
            if (index >= 0)
                modulo.Lecciones[index] = leccion;
            else
                modulo.Lecciones.Add(leccion);

            Session["Modulo"] = modulo;

            btnGuardarCambios.Enabled = true;

            BindLecciones();
            updLecciones.Update();

            CerrarModalLeccion();
            LimpiarCamposLeccion();
        }

        protected void btnGuardarCambios_Click(object sender, EventArgs e)
        {
            Dominio.Modulo modulo = (Dominio.Modulo)Session["Modulo"];
            LeccionServicio leccionServicio = new LeccionServicio();

            try
            {
                if (modulo.Lecciones != null && modulo.Lecciones.Any())
                {
                    foreach (Dominio.Leccion leccion in modulo.Lecciones)
                    {
                        leccion.IdModulo = modulo.IdModulo;
                        leccionServicio.ActualizarOCrear(leccion);
                    }
                }

                MostrarMensaje("¡Todo ok!", "¡Modulo Actualizado Correctamente!", "success");
                ActualizarModuloEnSesionYBindear();
                btnGuardarCambios.Enabled = false;

            }
            catch (Exception ex)
            {
                MostrarMensaje("¡Ups...!", $"¡Ocurrio un problema: {ex.Message}!", "error");
            }
        }

        protected void rptLecciones_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int id = int.Parse(e.CommandArgument.ToString());
            Dominio.Modulo modulo = (Dominio.Modulo)Session["Modulo"];

            switch (e.CommandName)
            {
                case "VerLeccion":
                    OnVistaCambiada("leccion", id);
                    return;

                case "Subir":
                    ReordenarModulo(modulo.Lecciones, id, -1);
                    break;

                case "Bajar":
                    ReordenarModulo(modulo.Lecciones, id, +1);
                    break;

                case "Editar":
                    Dominio.Leccion leccion = modulo.Lecciones.FirstOrDefault(x => x.IdLeccion == id);
                    if (leccion != null)
                    {
                        hfIdLeccion.Value = leccion.IdLeccion.ToString();
                        txtTituloLeccion.Text = leccion.Titulo;
                        txtIntroLeccion.Text = leccion.Introduccion;

                        ScriptManager.RegisterStartupScript(this, GetType(), "abrirModal",
                            "var modal = new bootstrap.Modal(document.getElementById('modalLeccion')); modal.show();", true);
                    }
                    updtModal.Update();
                    break;

                case "Eliminar":
                    LeccionServicio leccionServicio = new LeccionServicio();
                    try
                    {
                        leccionServicio.Eliminar(id);
                    }
                    catch (Exception ex)
                    {
                        MostrarMensaje("¡Ups...!", $"¡Ocurrio un problema: {ex.Message}!", "error");
                    }
                    finally
                    {
                        Response.Redirect($"Modulo.aspx?id={((Dominio.Modulo)Session["Modulo"]).IdModulo}");
                    }
                    break;
            }

            modulo.Lecciones = modulo.Lecciones.OrderBy(m => m.Orden).ToList();
            Session["Modulo"] = modulo;
            rptLecciones.DataSource = modulo.Lecciones;
            rptLecciones.DataBind();
        }

        private void ReordenarModulo(List<Dominio.Leccion> lecciones, int idLeccion, int desplazamiento)
        {
            var listaOrdenada = lecciones.OrderBy(m => m.Orden).ToList();
            int index = listaOrdenada.FindIndex(m => m.IdLeccion == idLeccion);
            int nuevoIndex = index + desplazamiento;

            if (index < 0 || nuevoIndex < 0 || nuevoIndex >= listaOrdenada.Count)
                return;

            var actual = listaOrdenada[index];
            var destino = listaOrdenada[nuevoIndex];

            int temp = actual.Orden;
            actual.Orden = destino.Orden;
            destino.Orden = temp;

            LeccionServicio leccionServicio = new LeccionServicio();

            try
            {
                foreach (Dominio.Leccion leccion in listaOrdenada)
                {
                    leccionServicio.ActualizarOCrear(leccion);
                }

                MostrarMensaje("¡Todo ok!", "¡Modulo Actualizado Correctamente!", "success");
                ActualizarModuloEnSesionYBindear();
            }
            catch (Exception ex)
            {
                MostrarMensaje("¡Ups...!", $"¡Ocurrio un problema: {ex.Message}!", "error");
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

        private void CerrarModalLeccion()
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "cerrarModal", @"
        const modalEl = document.getElementById('modalLeccion');
        if (modalEl) {
            const modal = bootstrap.Modal.getOrCreateInstance(modalEl);
            modal.hide();
            document.body.classList.remove('modal-open');
            const backdrop = document.querySelector('.modal-backdrop');
            if (backdrop) backdrop.remove();
        }", true);
        }

        private void LimpiarCamposLeccion()
        {
            txtTituloLeccion.Text = "";
            txtIntroLeccion.Text = "";
            hfIdLeccion.Value = "";
        }

        private void ActualizarModuloEnSesionYBindear()
        {
            ModuloServicio moduloServicio = new ModuloServicio();
            UsuarioAutenticado usuario = (UsuarioAutenticado)Session["UsuarioAutenticado"];
            Dominio.Modulo modulo = moduloServicio.ObtenerModuloPorId(((Dominio.Modulo)Session["Modulo"]).IdModulo, usuario.IdUsuario);
            Session["Modulo"] = modulo;
            rptLecciones.DataSource = modulo.Lecciones.OrderBy(l => l.Orden).ToList();
            rptLecciones.DataBind();
        }

        protected void rptLecciones_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                LinkButton btnEliminar = (LinkButton)e.Item.FindControl("btnEliminar");
                btnEliminar.Attributes["data-uid"] = btnEliminar.UniqueID;
            }
        }

        protected void rptLecciones_ItemCreated(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                ScriptManager scriptMan = ScriptManager.GetCurrent(Page);

                LinkButton btnSubir = e.Item.FindControl("btnSubir") as LinkButton;
                LinkButton btnBajar = e.Item.FindControl("btnBajar") as LinkButton;
                LinkButton btnEditar = e.Item.FindControl("btnEditar") as LinkButton;
                LinkButton btnEliminar = e.Item.FindControl("btnEliminar") as LinkButton;
                LinkButton btnVerLeccion = e.Item.FindControl("btnVerLeccion") as LinkButton;

                if (btnVerLeccion != null)
                    scriptMan.RegisterAsyncPostBackControl(btnVerLeccion);

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
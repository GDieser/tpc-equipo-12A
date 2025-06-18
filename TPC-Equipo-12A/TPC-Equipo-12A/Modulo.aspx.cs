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
    public partial class Modulo : System.Web.UI.Page
    {
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
                int idModulo = int.Parse(Request.QueryString["id"]);
                bool isAdmin = (usuarioAutenticado.Rol == Rol.Administrador);

                ModuloServicio moduloServicio = new ModuloServicio();
                bool isHabilitado = moduloServicio.EsUsuarioHabilitado(usuarioAutenticado.IdUsuario, idModulo);

                if (isAdmin || isHabilitado)
                {
                    Dominio.Modulo modulo = moduloServicio.ObtenerModuloPorId(idModulo, usuarioAutenticado.IdUsuario);
                    if (modulo == null)
                    {
                        Session["error"] = "El módulo no existe.";
                        Response.Redirect("Error.aspx");
                        return;
                    }

                    Session["Modulo"] = modulo;
                    litTitulo.Text = modulo.Titulo;
                    litIntro.Text = modulo.Introduccion;
                    rptLecciones.DataSource = modulo.Lecciones;
                    rptLecciones.DataBind();
                }
            }
        }

        protected void btnGuardarLeccion_Click(object sender, EventArgs e)
        {
            Dominio.Modulo modulo = (Dominio.Modulo)Session["Modulo"];

            int.TryParse(hfIdLeccion.Value, out int idLeccion);
            string titulo = txtTituloLeccion.Text;
            string introduccion = txtIntroLeccion.Text;

            if (titulo == "" || introduccion == "")
                return;

            Dominio.Leccion leccion = new Dominio.Leccion
            {
                IdLeccion = idLeccion,
                Titulo = titulo,
                Introduccion = introduccion,
                Orden = modulo.Lecciones != null ? modulo.Lecciones.Count : 0,
            };

            if (modulo.Lecciones == null)
                modulo.Lecciones = new List<Dominio.Leccion>();

            if (idLeccion > 0)
            {
                int index = modulo.Lecciones.FindIndex(l => l.IdLeccion == idLeccion);
                if (index >= 0)
                    modulo.Lecciones[index] = leccion;
            }
            else
            {
                modulo.Lecciones.Add(leccion);
            }

            Session["Modulo"] = modulo;

            rptLecciones.DataSource = modulo.Lecciones.OrderBy(m => m.Orden).ToList();
            rptLecciones.DataBind();

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
        }

        protected void btnGuardarCambios_Click(object sender, EventArgs e)
        {
            Dominio.Modulo modulo = (Dominio.Modulo)Session["Modulo"];
            LeccionServicio leccionServicio = new LeccionServicio();

            if (modulo.Lecciones != null && modulo.Lecciones.Any())
            {
                foreach (Dominio.Leccion leccion in modulo.Lecciones)
                {
                    leccion.IdModulo = modulo.IdModulo;
                    leccionServicio.ActualizarOCrear(leccion);
                }
            }
        }

        protected void rptLecciones_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int id = int.Parse(e.CommandArgument.ToString());
            Dominio.Modulo modulo = (Dominio.Modulo)Session["Modulo"];

            switch (e.CommandName)
            {
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
        }
    }
}
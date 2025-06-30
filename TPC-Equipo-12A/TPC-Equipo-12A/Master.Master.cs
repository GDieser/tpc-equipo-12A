using System;
using System.Security.Cryptography;
using System.Web.UI;
using Dominio;
using Servicio;

namespace TPC_Equipo_12A
{
    public partial class Master : System.Web.UI.MasterPage
    {
        protected UsuarioAutenticado usuario;
        protected Carrito carrito;
        protected int cantidadCarrito;
        protected int cantidadNotificaciones;
        protected void Page_Load(object sender, EventArgs e)
        {
            NotificacionesServicio servicio = new NotificacionesServicio();
            usuario = (UsuarioAutenticado)Session["UsuarioAutenticado"];
            btnNotificaciones.Visible = false;

            if (usuario != null)
            {
                cargarCarrito();

                carrito = (Carrito)Session["Carrito"];

                cantidadCarrito = carrito.CarritoCursos.Count;

                if (usuario.Rol == Rol.Administrador)
                {
                    cantidadNotificaciones = servicio.ContarNoVistas(usuario.IdUsuario);
                }
                else
                {
                    cantidadNotificaciones = servicio.ContarNoVistas(usuario.IdUsuario, false);

                    var lista = servicio.ListaNotificaciones(usuario.IdUsuario);

                    if (lista != null && lista.Count > 0)
                    {
                        rptNotificaciones.DataSource = lista;
                        rptNotificaciones.DataBind();
                        pnlSinNotificaciones.Visible = false;
                    }
                    else
                    {
                        pnlSinNotificaciones.Visible = true;
                    }

                }

                Session["CantidadNotificaciones"] = cantidadNotificaciones;
            }

            if (Seguridad.esAdmin(usuario))
            {
                btnNotificaciones.Visible = true;
            }

            if (!IsPostBack)
            {
                if (Page is Login || usuario != null)
                {
                    btnLogin.Visible = false;
                }

                if (Page is Curso || Page is Modulo || Page is Leccion)
                    return;

                Session.Remove("LeccionesCompletadas");


            }
        }

        protected void cargarCarrito()
        {
            CursoServicio servicio = new CursoServicio();
            Carrito carrito = new Carrito();

            carrito = servicio.ListarCursoCarrito(usuario.IdUsuario);

            Session["Carrito"] = carrito;
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            /*
            var usuario = Session["UsuarioAutenticado"] as UsuarioAutenticado; 
            string mensaje = usuario != null ? $"¡Esperamos verte pronto {usuario.Nombre}!" : "¡Esperamos verte pronto!";

            ScriptManager.RegisterStartupScript(this, GetType(), "sweetalert",
            $@"Swal.fire({{
                title: '¡Sesion cerrada correctamente!',
                text: '{mensaje}',
                icon: 'info',
                confirmButtonText: 'OK'
            }}).then((result) => {{
                if (result.isConfirmed) {{
                    window.location.href = 'Default.aspx';
                }}
            }});", true);

            Session["UsuarioAutenticado"] = null; 
            */

            var usuario = Session["UsuarioAutenticado"] as UsuarioAutenticado;
            string mensaje = usuario != null ? $"¡Esperamos verte pronto {usuario.Nombre}!" : "¡Esperamos verte pronto!";

            ScriptManager.RegisterStartupScript(this, GetType(), "sweetalert",
            $@"Swal.fire({{
                title: '¡Sesión cerrada correctamente!',
                text: '{mensaje}',
                icon: 'info',
                toast: true,
                position: 'top',
                showConfirmButton: false,
                timer: 1500,
                timerProgressBar: true,
                background: '#1e1e2f',
                color: '#fff',
                iconColor: '#3fc3ee',
                didOpen: (toast) => {{
                    toast.addEventListener('mouseenter', Swal.stopTimer)
                    toast.addEventListener('mouseleave', Swal.resumeTimer)
                }}
            }});
            setTimeout(function() {{
                window.location.href = 'Default.aspx';
            }}, 1600);", true);

            Session["UsuarioAutenticado"] = null;


        }

        protected void rptNotificaciones_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Ver")
            {
                string[] datos = e.CommandArgument.ToString().Split(';');
                int idNotificacion = int.Parse(datos[0]);
                int idOrigen = int.Parse(datos[1]);
                int idEstudiante = usuario.IdUsuario;

                NotificacionesServicio servicio = new NotificacionesServicio();

                servicio.MarcarNotificacionVista(idEstudiante, idNotificacion);

                Session["CantidadNotificaciones"] = (int)Session["CantidadNotificaciones"] - 1;

                Response.Redirect("ForoDetalle.aspx?id=" + idOrigen);
            }
        }
    }
}
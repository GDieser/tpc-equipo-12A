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
        protected void Page_Load(object sender, EventArgs e)
        {
            usuario = (UsuarioAutenticado)Session["UsuarioAutenticado"];
            

            if(usuario != null)
            {
                cargarCarrito();

                carrito = (Carrito)Session["Carrito"];

                cantidadCarrito = carrito.CarritoCursos.Count;
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
        }
    }
}
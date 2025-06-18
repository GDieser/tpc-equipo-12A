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
        protected void Page_Load(object sender, EventArgs e)
        {
            usuario = (UsuarioAutenticado)Session["UsuarioAutenticado"];

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
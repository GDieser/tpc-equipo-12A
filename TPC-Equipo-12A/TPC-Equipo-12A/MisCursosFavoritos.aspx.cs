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
    public partial class MisCursosFavoritos : System.Web.UI.Page
    {
        UsuarioAutenticado usuario = null;
        protected void Page_Load(object sender, EventArgs e)
        {

            usuario = (UsuarioAutenticado)Session["UsuarioAutenticado"];

            if (usuario == null)
            {
                Session.Add("error", "Hey, no deberías andar por acá 🤨. Acceso no permitido");
                Response.Redirect("Error.aspx");
            }

            if (!IsPostBack)
            {
                CursoServicio servicio = new CursoServicio();

                rptCursos.DataSource = servicio.ListarFavoritos(usuario.IdUsuario);
                rptCursos.DataBind();
            }

        }
    }
}
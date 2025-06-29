using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Servicio;
using Dominio;

namespace TPC_Equipo_12A
{
    public partial class MisCursos : System.Web.UI.Page
    {
        UsuarioAutenticado usuario;
        protected void Page_Load(object sender, EventArgs e)
        {
            usuario = (UsuarioAutenticado)Session["UsuarioAutenticado"];
            CursoServicio servicio = new CursoServicio();
            List<CursoDTO> lista = new List<CursoDTO>();

            if (usuario == null)
            {
                Session.Add("error", "Hey, no deberías andar por acá 🤨. Acceso no permitido");
                Response.Redirect("Error.aspx");
            }

            if(!IsPostBack)
            {
                if(usuario.Rol == Dominio.Rol.Administrador)
                {
                    lista = servicio.ObtenerCursosCompletosDeUsuario(usuario);

                    rptMisCursos.DataSource = lista;
                    rptMisCursos.DataBind();
                }
            }


        }
    }
}
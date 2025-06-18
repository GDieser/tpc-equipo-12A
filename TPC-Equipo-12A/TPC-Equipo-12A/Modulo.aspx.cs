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

                    litTituloModulo.Text = modulo.Titulo;
                    litIntroModulo.Text = modulo.Introduccion;
                    //imgBannerModulo.ImageUrl = modulo.Imagen;

                    rptLecciones.DataSource = modulo.Lecciones;
                    rptLecciones.DataBind();
                }
            }
        }


    }
}
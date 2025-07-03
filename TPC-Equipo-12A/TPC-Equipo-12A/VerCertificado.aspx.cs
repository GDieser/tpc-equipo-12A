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
    public partial class VerCertificado : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                UsuarioAutenticado usuario = Session["UsuarioAutenticado"] as UsuarioAutenticado;
                if (usuario == null)
                {
                    Session["error"] = "Debe iniciar sesión para ver el certificado.";
                    Response.Redirect("Error.aspx");
                    return;
                }
            }
        }
    }
}
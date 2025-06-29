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
    public partial class ForoDetalle : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            UsuarioAutenticado usuario;
            usuario = (UsuarioAutenticado)Session["UsuarioAutenticado"];

            if (usuario == null)
            {
                Session.Add("error", "Hey, no deberías andar por acá 🤨. Acceso no permitido");
                Response.Redirect("Error.aspx");
            }

            if (!IsPostBack)
            {
                int idDebate = Convert.ToInt32(Request.QueryString["id"]);



                DebateServicio servicio = new DebateServicio();
                var debate = servicio.GetDebatePorId(idDebate);

                if (debate != null)
                {
                    litTitulo.Text = Server.HtmlEncode(debate.Titulo);
                    litNombreCompleto.Text = Server.HtmlEncode($"{debate.Nombre} {debate.Apellido}");
                    litNombreUsuario.Text = Server.HtmlEncode(debate.NombreUsuario);
                    litFecha.Text = debate.FechaCreacion.ToString("dd/MM/yyyy");
                    litContenido.Text = debate.Contenido;
                    imgPerfil.ImageUrl = debate.UrlImagen ?? "";
                }
                else
                {
                    Response.Redirect("Error.aspx");
                }
            }
        }

        protected void btnVolver_Click(object sender, EventArgs e)
        {
            Response.Redirect("");
        }
    }
}
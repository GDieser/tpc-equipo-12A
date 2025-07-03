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
    public partial class CertificadoRender : System.Web.UI.Page
    {
        private UsuarioAutenticado Usuario
        {
            get { return Session["UsuarioAutenticado"] as UsuarioAutenticado; }
            set { Session["UsuarioAutenticado"] = value; }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string idCertificado;

                if ((Request.QueryString["idCertificado"] == null) || Usuario == null)
                {
                    Session["error"] = "Parámetros inválidos para generar el certificado.";
                    Response.Redirect("Error.aspx");
                    return;
                }
                idCertificado = Request.QueryString["idCertificado"].ToString();

                CertificadoServicio certificadoServicio = new CertificadoServicio();
                CertificadoDTO certificado = certificadoServicio.ObtenerCertificadoPorId(idCertificado);

                litNombreAlumno.Text = Usuario.Nombre + " " + Usuario.Apellido;
                litNombreCurso.Text = certificado.NombreCurso;
                litFecha.Text = certificado.FechaEmision.ToString("dd/MM/yyyy");
                litHoras.Text = certificado.Duracion.ToString(); 
                litIdCurso.Text = certificado.IdCertificado;
            }
        }
    }
}
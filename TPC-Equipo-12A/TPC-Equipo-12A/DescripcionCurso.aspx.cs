using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Servicio;

namespace TPC_Equipo_12A
{
    public partial class DescripcionCurso : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string idParam = Request.QueryString["id"];
                if (!string.IsNullOrEmpty(idParam) && int.TryParse(idParam, out int idCurso))
                {
                    CursoServicio servicio = new CursoServicio();
                    Dominio.Curso curso = servicio.GetCursoPorId(idCurso);

                    lblTitulo.Text = curso.Titulo;
                    lblDescripcion.Text = curso.Descripcion;
                    imgCurso.ImageUrl = string.IsNullOrEmpty(curso.ImagenUrl) ? "imagenes/default.jpg" : curso.ImagenUrl;
                }
                else
                {
                    Response.Redirect("ListaCurso.aspx");
                }
            }

        }
    }
}
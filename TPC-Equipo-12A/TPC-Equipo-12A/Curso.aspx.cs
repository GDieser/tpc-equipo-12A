using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Servicio;

namespace TPC_Equipo_12A
{
    public partial class Curso : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null && int.TryParse(Request.QueryString["id"], out int idCurso))
                {
                    cargarCurso(idCurso);
                }
                else
                {
                    lblTitulo.Text = "Curso no encontrado.";
                }
            }
        }
        private void cargarCurso(int idCurso)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setConsulta("SELECT Titulo, Descripcion, ImagenUrl FROM Cursos WHERE Id = @id");
                datos.setParametro("@id", idCurso);
                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    lblTitulo.Text = datos.Lector["Titulo"].ToString();
                    lblDescripcion.Text = datos.Lector["Descripcion"].ToString();
                    imgCurso.ImageUrl = datos.Lector["ImagenUrl"].ToString();
                }
                else
                {
                    lblTitulo.Text = "Curso no encontrado.";
                }
            }
            catch (Exception ex)
            {
                lblTitulo.Text = "Error al cargar el curso.";
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
}
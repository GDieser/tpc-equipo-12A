using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Servicio;

namespace TPC_Equipo_12A
{
    public partial class AgregarCurso : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                imgCurso.ImageUrl = "https://wiratthungsong.com/wts/assets/img/default.png";
            }
        }
        protected void txtImagenUrl_TextChanged(object sender, EventArgs e)
        {
            imgCurso.ImageUrl = txtImagenUrl.Text;
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setConsulta("INSERT INTO Cursos (Titulo, Resumen, Descripcion, ImagenUrl) VALUES (@titulo, @resumen, @descripcion, @imagen)");
                datos.setParametro("@titulo", txtTitulo.Text);
                datos.setParametro("@resumen", txtResumen.Text);
                datos.setParametro("@descripcion", txtDescripcion.Text);
                datos.setParametro("@imagen", txtImagenUrl.Text);

                datos.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }

            Response.Redirect("Cursos.aspx");
        }
    
    }
}
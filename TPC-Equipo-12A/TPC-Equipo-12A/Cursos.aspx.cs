using System;
using System.Web.UI.WebControls;
using Servicio;

namespace TPC_Equipo_12A
{
    public partial class Cursos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                cargarCursos();
        }

        private void cargarCursos()
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setConsulta("SELECT Id, Titulo, Resumen, ImagenUrl FROM Cursos");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    int id = (int)datos.Lector["Id"];
                    string titulo = datos.Lector["Titulo"].ToString();
                    string descripcion = datos.Lector["Resumen"].ToString();
                    string imagen = datos.Lector["ImagenUrl"].ToString();

                    Literal divCurso = new Literal();
                    divCurso.Text = $@"
                    <div class='curso-card' data-id='{id}'>
                        <img src='{imagen}' alt='{titulo}' class='curso-img' />
                        <div class='curso-contenido'>
                            <h5>{titulo}</h5>
                            <p>{descripcion}</p>
                        </div>
                        <div class='curso-acciones'>
                            <a href='Curso.aspx?id={id}' class='btn btn-primary'>Ver más</a>
                            <button class='btn btn-info'>Comprar</button>
                        </div>
                    </div>";

                    phCursos.Controls.Add(divCurso);
                }
            }
            catch (Exception ex)
            {
                phCursos.Controls.Add(new Literal { Text = $"<p class='text-danger'>Error al cargar los cursos: {ex.Message}</p>" });
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
}

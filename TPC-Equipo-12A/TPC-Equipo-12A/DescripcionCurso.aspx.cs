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
                    imgCurso.ImageUrl = string.IsNullOrEmpty(curso.ImagenPortada?.Url)
         ? "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/480px-No_image_available.svg.png"
         : curso.ImagenPortada.Url;

                }
                else
                {
                    Response.Redirect("ListaCurso.aspx");
                }


                //Necesito para una funcionalidad en aula
                UsuarioAutenticado usuario = Session["UsuarioAutenticado"] as UsuarioAutenticado;

                if (usuario != null)
                {
                    phBotonFavorito.Visible = true;

                    bool esFavorito = ValidarCursoFavorito();
                    btnFavorito.Text = esFavorito ? "★ En Favoritos (Eliminar)" : "➕ Agregar a Favoritos";
                    btnFavorito.CssClass = esFavorito ? "btn btn-danger" : "btn btn-warning";
                }



            }

        }

        //Necesito para una funcionalidad en aula
        protected bool ValidarCursoFavorito()
        {
            int idCurso = Convert.ToInt32(Request.QueryString["id"]);
            UsuarioAutenticado usuario = null;

            usuario = (UsuarioAutenticado)Session["UsuarioAutenticado"];

            try
            {
                CursoServicio servicio = new CursoServicio();
                CursoFavorito curso = null;

                curso = servicio.getCursoFavorito(usuario.IdUsuario, idCurso);

                Session["CursoFavorito"] = curso;

                if (curso != null && curso.IdCurso == idCurso && curso.Activo)
                {
                    return true;
                }

                return false;
            }
            catch (Exception ex)
            {

                throw ex;
            }

        }

        //Necesito para una funcionalidad en aula
        protected void btnFavorito_Click(object sender, EventArgs e)
        {
            UsuarioAutenticado usuario = (UsuarioAutenticado)Session["UsuarioAutenticado"];
            int idCurso = Convert.ToInt32(Request.QueryString["id"]);

            CursoServicio servicio = new CursoServicio();

            if (ValidarCursoFavorito())
            {
                servicio.CambiarEstadoCursoFavorito(usuario.IdUsuario, idCurso, 0);
            }
            else
            {
                CursoFavorito curso = (CursoFavorito)Session["CursoFavorito"];

                if (curso != null)
                {
                    servicio.CambiarEstadoCursoFavorito(usuario.IdUsuario, idCurso, 1);
                }
                else
                {
                    servicio.AgregarCursoFavorito(usuario.IdUsuario, idCurso);
                }
            }

            Response.Redirect(Request.RawUrl);
        }
    }
}
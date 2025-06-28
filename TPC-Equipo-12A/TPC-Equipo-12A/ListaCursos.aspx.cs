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
    public partial class ListaCurso : System.Web.UI.Page
    {
        public List<Dominio.Curso> ListaCursos;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CategoriaServicio ser = new CategoriaServicio();
                List<Categoria> lista = ser.ListarActivas();

                ddlFiltroCategoria.DataSource = lista;
                ddlFiltroCategoria.DataValueField = "IdCategoria";
                ddlFiltroCategoria.DataTextField = "Nombre";
                ddlFiltroCategoria.DataBind();

                ddlFiltroCategoria.Items.Insert(0, new ListItem("Todas las categorías", "0"));


                ddlFiltrar.Items.Insert(0, new ListItem("Más Recientes", "0"));
                ddlFiltrar.Items.Insert(1, new ListItem("Más Antiguos", "1"));
                ddlFiltrar.Items.Insert(2, new ListItem("Precio más bajo", "2"));
                ddlFiltrar.Items.Insert(3, new ListItem("Precio más alto", "3"));

                int rol = 1;

                if (Session["UsuarioAutenticado"] != null)
                {
                    UsuarioAutenticado usuario = (UsuarioAutenticado)Session["UsuarioAutenticado"];
                    rol = Convert.ToInt16(usuario.Rol);
                }

                CursoServicio servicio = new CursoServicio();
                List<Dominio.Curso> cursos = servicio.Listar(rol);


                rptCursos.DataSource = cursos;
                rptCursos.DataBind();
            }
        }

        protected void btnFiltrar_Click(object sender, EventArgs e)
        {
            int rol = 1;

            if (Session["UsuarioAutenticado"] != null)
            {
                UsuarioAutenticado usuario = (UsuarioAutenticado)Session["UsuarioAutenticado"];
                rol = Convert.ToInt16(usuario.Rol);
            }

            CursoServicio servicio = new CursoServicio();
            List<Dominio.Curso> cursos = servicio.Listar(rol);

            List<Dominio.Curso> listaFiltrada = new List<Dominio.Curso>();


            if (ddlFiltroCategoria.SelectedValue == "0")
            {

                rptCursos.DataSource = cursos;
                rptCursos.DataBind();
            }
            else
            {

                foreach (var publi in cursos)
                {
                    if (publi.Categoria.IdCategoria == Convert.ToInt32(ddlFiltroCategoria.SelectedValue))
                    {
                        listaFiltrada.Add(publi);
                    }
                }

                rptCursos.DataSource = listaFiltrada;
                rptCursos.DataBind();
            }
        }

        protected void btnFiltrarCursos_Click(object sender, EventArgs e)
        {
            int rol = 1;

            if (Session["UsuarioAutenticado"] != null)
            {
                UsuarioAutenticado usuario = (UsuarioAutenticado)Session["UsuarioAutenticado"];
                rol = Convert.ToInt16(usuario.Rol);
            }
            CursoServicio servicio = new CursoServicio();
            List<Dominio.Curso> cursos = servicio.Listar(rol);

            List<Dominio.Curso> listaFiltrada = new List<Dominio.Curso>();


            switch (ddlFiltrar.SelectedValue)
            {
                case "0":
                    listaFiltrada = cursos;
                    break;
                case "1":
                    listaFiltrada = cursos.OrderBy(c => c.FechaPublicacion).ToList();
                    break;
                case "2":
                    listaFiltrada = cursos.OrderBy(c => c.Precio).ToList();
                    break;
                case "3":
                    listaFiltrada = cursos.OrderByDescending(c => c.Precio).ToList();
                    break;

            }

            rptCursos.DataSource = listaFiltrada;
            rptCursos.DataBind();

        }
    }
}

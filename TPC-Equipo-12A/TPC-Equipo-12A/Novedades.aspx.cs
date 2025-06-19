using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dominio;
using Servicio;

namespace TPC_Equipo_12A
{
    public partial class Novedades : System.Web.UI.Page
    {
        public List<Publicacion> ListaPublicaciones;

        protected void Page_Load(object sender, EventArgs e)
        {
            NovedadesServicio servicio = new NovedadesServicio();
            UsuarioAutenticado usuarioAutenticado = new UsuarioAutenticado();

            

            if (Session["UsuarioAutenticado"] != null)
            {
                usuarioAutenticado = (UsuarioAutenticado)Session["UsuarioAutenticado"];

                if (usuarioAutenticado.Rol == 0)
                {
                    btnAgregar.Visible = true;
                    
                }
                else
                {
                    btnAgregar.Visible = false;
                }
            }
            else
            {
                btnAgregar.Visible = false;
            }


            if (!IsPostBack)
            {
                CategoriaServicio ser = new CategoriaServicio();
                List<Categoria> lista = ser.listar();

                ddlFiltro.DataSource = lista;
                ddlFiltro.DataValueField = "IdCategoria";
                ddlFiltro.DataTextField = "Nombre";
                ddlFiltro.DataBind();
                ddlFiltro.Items.Insert(0, new ListItem("Todo", "0"));

                CargarNovedades();
            }

        }

        private void CargarNovedades()
        {
            NovedadesServicio servicio = new NovedadesServicio();
            ListaPublicaciones = servicio.listar();
            List<Publicacion> listaFiltrada = new List<Publicacion>();

            foreach (var publi in ListaPublicaciones)
            {
                if (publi.Estado == EstadoPublicacion.Publicado)
                {
                    listaFiltrada.Add(publi);
                }
            }

            PagedDataSource paged = new PagedDataSource();


            paged.DataSource = listaFiltrada;
            paged.PageSize = 10;
            paged.AllowPaging = true;
            paged.CurrentPageIndex = PageNumber;

            rptNovedades.DataSource = paged;
            rptNovedades.DataBind();

            btnAnterior.Enabled = !paged.IsFirstPage;
            btnSiguiente.Enabled = !paged.IsLastPage;
        }

        private int PageNumber
        {
            get { return ViewState["PageNumber"] != null ? (int)ViewState["PageNumber"] : 0; }
            set { ViewState["PageNumber"] = value; }
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            Session.Remove("NovedadSeleccionada");
            Response.Redirect("FormularioPublicacion.aspx", false);
        }

        protected void btnFiltrar_Click(object sender, EventArgs e)
        {
            NovedadesServicio servicio = new NovedadesServicio();
            ListaPublicaciones = servicio.listar();
            List<Publicacion> listaFiltrada = new List<Publicacion>();


            if (ddlFiltro.SelectedValue == "0")
            {
                foreach (var publi in ListaPublicaciones)
                {
                    if (publi.Estado == EstadoPublicacion.Publicado)
                    {
                        listaFiltrada.Add(publi);
                    }
                }

                rptNovedades.DataSource = listaFiltrada;
                rptNovedades.DataBind();
            }
            else
            {
                List<Categoria> aux = new List<Categoria>();

                foreach (var publi in ListaPublicaciones)
                {
                    if (publi.Estado == EstadoPublicacion.Publicado && publi.Categoria.IdCategoria == Convert.ToInt32(ddlFiltro.SelectedValue))
                    {
                        listaFiltrada.Add(publi);
                    }
                }

                rptNovedades.DataSource = listaFiltrada;
                rptNovedades.DataBind();

            }
        }

        protected void btnAnterior_Click(object sender, EventArgs e)
        {
            PageNumber--;
            CargarNovedades();
        }

        protected void btnSiguiente_Click(object sender, EventArgs e)
        {
            PageNumber++;
            CargarNovedades();
        }


    }
}
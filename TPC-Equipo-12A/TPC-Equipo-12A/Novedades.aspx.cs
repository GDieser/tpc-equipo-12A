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
    public partial class Novedades : System.Web.UI.Page
    {
        public List<Publicacion> ListaPublicaciones;

        protected void Page_Load(object sender, EventArgs e)
        {
            NovedadesServicio servicio = new NovedadesServicio();
            UsuarioAutenticado usuarioAutenticado = new UsuarioAutenticado();

            if(Session["UsuarioAutenticado"] != null)
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
                ListaPublicaciones = servicio.listar();
                List<Publicacion> listaFiltrada = new List<Publicacion>();

                foreach (var publi in ListaPublicaciones)
                {
                    if(publi.Estado == EstadoPublicacion.Publicado)
                    {
                        listaFiltrada.Add(publi);
                    }
                }

                rptNovedades.DataSource = listaFiltrada;
                rptNovedades.DataBind();
            }

        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            Response.Redirect("FormularioPublicacion", false);
        }

    }
}
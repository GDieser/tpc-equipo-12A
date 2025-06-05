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
            ListaPublicaciones = servicio.listar();

            rptNovedades.DataSource = ListaPublicaciones;
            rptNovedades.DataBind();

        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;

namespace TPC_Equipo_12A
{
    public partial class Aula1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string vistaActual;
            int idActual;

            // Siempre obtenemos vista e id del ViewState si existen
            vistaActual = ViewState["Vista"] as string;
            idActual = ViewState["Id"] != null ? (int)ViewState["Id"] : 0;

            // Si es la primera carga, tomamos los valores de la query y los guardamos
            if (!IsPostBack)
            {
                vistaActual = Request.QueryString["v"];
                idActual = int.TryParse(Request.QueryString["id"], out int val) ? val : 0;

                ViewState["Vista"] = vistaActual;
                ViewState["Id"] = idActual;
            }

            // 🔥 SIEMPRE cargamos el control, incluso en postback
            if (!string.IsNullOrEmpty(vistaActual))
                CargarControl(vistaActual, idActual);
        }



        private void CargarControl(string vista = null, int id = 0)
        {
            if (vista == null)
                vista = Request.QueryString["v"];
            id = id == 0 && int.TryParse(Request.QueryString["id"], out int val) ? val : id;


            switch (vista)
            {
                case "curso":
                    var cursoControl = (UserControl.Curso)LoadControl("~/UserControl/Curso.ascx");
                    cursoControl.VistaCambiada += Control_VistaCambiada;
                    phContenido.Controls.Clear();
                    phContenido.Controls.Add(cursoControl);
                    break;
                case "modulo":
                    var moduloControl = (UserControl.Modulo)LoadControl("~/UserControl/Modulo.ascx");
                    moduloControl.VistaCambiada += Control_VistaCambiada;
                    moduloControl.IdModulo = id;
                    phContenido.Controls.Clear();
                    phContenido.Controls.Add(moduloControl);
                    break;
                case "leccion":
                    var leccionControl = (UserControl.Leccion)LoadControl("~/UserControl/Leccion.ascx");
                    leccionControl.VistaCambiada += Control_VistaCambiada;
                    leccionControl.IdLeccion = id;
                    phContenido.Controls.Clear();
                    phContenido.Controls.Add(leccionControl);
                    break;
            }
            updAula.Update();
        }

        public void Control_VistaCambiada(object sender, ControlEventArgs e)
        {
            CargarControl(e.Vista, e.Id);
        }
    }
}
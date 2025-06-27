using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dominio;
using Servicio;

namespace TPC_Equipo_12A
{
    public partial class Pagar : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Carrito carrito = Session["Carrito"] as Carrito;
                if (carrito != null)
                {
                    rptCursos.DataSource = carrito.CarritoCursos;
                    rptCursos.DataBind();

                    decimal total = carrito.CarritoCursos.Sum(c => c.Precio);
                    litTotal.Text = total.ToString("N2");
                }
            }
        }

        protected void btnPagar_Click(object sender, EventArgs e)
        {
            Carrito carrito = Session["Carrito"] as Carrito;
            if (carrito == null || carrito.CarritoCursos.Count == 0)
            {
                Response.Redirect("Default.aspx");
                return;
            }

            // Aca traigo los cursos por ID de CarritoCursos
            CursoServicio servicio = new CursoServicio();
            List<Dominio.Curso> cursos = new List<Dominio.Curso>();

            foreach (var curso in carrito.CarritoCursos)
            {
                cursos.Add(servicio.GetCursoPorId(curso.IdCurso));
            }
            // ---------------------------------------------

            string accessToken = ConfigurationManager.AppSettings["MPAccessToken"];

            var items = new List<object>();

            foreach (Dominio.Curso item in cursos)
            {
                items.Add(new
                {
                    title = item.Titulo,
                    quantity = 1,
                    currency_id = "ARS",
                    unit_price = item.Precio
                });
            }
            string dominioURL = ConfigurationManager.AppSettings["Dominio"];
            var preferencia = new
            {
                items = items,
                back_urls = new
                {
                    success = $"{dominioURL}Exito.aspx",
                    failure = $"{dominioURL}Error.aspx",
                    pending = $"{dominioURL}Pendiente.aspx"
                },
                auto_return = "approved"
            };

            string json = new JavaScriptSerializer().Serialize(preferencia);

            WebRequest request = (HttpWebRequest)WebRequest.Create("https://api.mercadopago.com/checkout/preferences?access_token=" + accessToken);
            request.Method = "POST";
            request.ContentType = "application/json";

            using (var writer = new StreamWriter(request.GetRequestStream()))
                writer.Write(json);
            try
            {


                var response = (HttpWebResponse)request.GetResponse();
                using (var reader = new StreamReader(response.GetResponseStream()))
                {
                    string result = reader.ReadToEnd();
                    var jsonResponse = new JavaScriptSerializer().Deserialize<Dictionary<string, object>>(result);
                    string initPoint = jsonResponse["init_point"].ToString();

                    Response.Redirect(initPoint);
                }
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web.Script.Serialization;
using System.Threading.Tasks;

namespace Servicio
{
    public class MercadoPagoServicio
    {
        private string tokenAcceso;
        private string dominioUrl;

        public MercadoPagoServicio(string tokenAcceso, string dominioUrl)
        {
            this.tokenAcceso = tokenAcceso;
            this.dominioUrl = dominioUrl;
        }

        public (string InitPoint, string IdOperacion) CrearPreferenciaPago(List<object> items, string externalReference)
        {
            var preferencia = new
            {
                items = items,
                external_reference = externalReference,
                back_urls = new
                {
                    success = $"{dominioUrl}ExitoPago.aspx",
                    failure = $"{dominioUrl}ErrorPago.aspx",
                    pending = $"{dominioUrl}PendientePago.aspx"
                },
                notification_url = $"https://059b-45-226-29-172.ngrok-free.app/NotificacionMP.aspx",
                auto_return = "approved"
            };

            var serializador = new System.Web.Script.Serialization.JavaScriptSerializer();
            string json = serializador.Serialize(preferencia);

            WebRequest request = WebRequest.Create($"https://api.mercadopago.com/checkout/preferences?access_token={tokenAcceso}");
            request.Method = "POST";
            request.ContentType = "application/json";

            using (var writer = new StreamWriter(request.GetRequestStream()))
            {
                writer.Write(json);
            }

            var response = (HttpWebResponse)request.GetResponse();

            using (var reader = new StreamReader(response.GetResponseStream()))
            {
                string result = reader.ReadToEnd();

                var jsonResponse = serializador.DeserializeObject(result) as Dictionary<string, object>;

                if (jsonResponse == null || !jsonResponse.ContainsKey("init_point") || !jsonResponse.ContainsKey("id"))
                    throw new System.Exception("La respuesta de Mercado Pago no contiene los datos esperados.");

                string initPoint = jsonResponse["init_point"].ToString();
                if (!initPoint.Contains("sandbox"))
                {
                    initPoint = initPoint.Replace("www.mercadopago.com", "sandbox.mercadopago.com");
                }
                string idOperacion = jsonResponse["id"].ToString();

                return (initPoint, idOperacion);
            }
        }
    }
}

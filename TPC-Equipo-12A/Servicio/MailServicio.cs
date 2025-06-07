using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using Dominio;

namespace Servicio
{
    public class ServicioMail
    {

        private readonly string remitente = ConfigurationManager.AppSettings["SMTP_Remitente"];
        private readonly string host = ConfigurationManager.AppSettings["SMTP_Host"];
        private readonly int puerto = int.Parse(ConfigurationManager.AppSettings["SMTP_Puerto"]);
        private readonly string usuario = ConfigurationManager.AppSettings["SMTP_Usuario"];
        private readonly string contrasena = ConfigurationManager.AppSettings["SMTP_Contrasena"];


        public bool EnviarCorreo(string cuerpo, string destinatario, string asunto)
        {

            var mensaje = new MailMessage();
            mensaje.From = new MailAddress(remitente);
            mensaje.To.Add(destinatario);
            mensaje.Subject = asunto;
            mensaje.Body = cuerpo;
            mensaje.IsBodyHtml = true;

            var cliente = new SmtpClient(host, puerto)
            {
                Credentials = new NetworkCredential(usuario, contrasena),
                EnableSsl = true
            };

            try
            {
                cliente.Send(mensaje);
                return true;
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error al enviar: " + ex.Message);
                return false;
            }
        }

        public void EnviarCorreoBienvenida(Usuario usuario)
        {
            string dominio = ConfigurationManager.AppSettings["Dominio"];
            string enlaceValidacion = $"{dominio}/GenerarContrasenia.aspx?email={usuario.Email}&token={usuario.TokenValidacion}";

            string cuerpo = $@"
            <html>
            <head>
                <style>
                    body {{
                        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                        background-color: #f2f4f6;
                        padding: 40px;
                    }}
                    .container {{
                        max-width: 600px;
                        margin: auto;
                        background-color: #ffffff;
                        padding: 30px;
                        border-radius: 10px;
                        box-shadow: 0 4px 8px rgba(0,0,0,0.1);
                    }}
                    h1 {{
                        color: #343a40;
                    }}
                    p {{
                        color: #555;
                        line-height: 1.6;
                    }}
                    .btn {{
                        display: inline-block;
                        background-color: #007bff;
                        color: white;
                        padding: 12px 24px;
                        margin-top: 20px;
                        text-decoration: none;
                        font-weight: bold;
                        border-radius: 6px;
                        transition: background-color 0.3s ease;
                    }}
                    .btn:hover {{
                        background-color: #0056b3;
                    }}
                    .footer {{
                        margin-top: 40px;
                        font-size: 12px;
                        color: #999;
                        text-align: center;
                    }}
                </style>
            </head>
            <body>
                <div class='container'>
                    <h1>¡Bienvenido/a, {usuario.Nombre} {usuario.Apellido}!</h1>
                    <p>Gracias por unirte a <strong>MisCursos.com</strong>, la plataforma donde potenciarás tu aprendizaje en línea.</p>
                    <p>Tu nombre de usuario registrado es: <strong>{usuario.NombreUsuario}</strong></p>
                    <p>Para activar tu cuenta y comenzar a disfrutar de todos nuestros cursos, simplemente hacé clic en el siguiente botón:</p>
                    <p><a href='{enlaceValidacion}' class='btn'>Activar mi cuenta</a></p>
                    <p>Si no solicitaste este registro, podés ignorar este mensaje.</p>
                    <br />
                    <p>¡Esperamos verte pronto aprendiendo con nosotros!</p>
                    <p>Saludos cordiales,<br /><strong>El equipo de MisCursos.com</strong></p>
                    <div class='footer'>
                        &copy; {DateTime.Now.Year} MisCursos.com · Todos los derechos reservados.
                    </div>
                </div>
            </body>
            </html>";

            string asunto = $"¡Bienvenid@ {usuario.Nombre}! Generá tu contraseña en MisCursos.com y comenzá a aprender";

            EnviarCorreo(cuerpo, usuario.Email, asunto);
        }
    }
}

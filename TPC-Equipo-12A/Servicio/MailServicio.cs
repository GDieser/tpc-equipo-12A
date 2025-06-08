using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using Dominio;
using System.Diagnostics;

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
            if (string.IsNullOrWhiteSpace(cuerpo) || string.IsNullOrWhiteSpace(destinatario))
                return false;

            var mensaje = new MailMessage
            {
                From = new MailAddress(remitente),
                Subject = asunto,
                Body = cuerpo,
                IsBodyHtml = true
            };
            mensaje.To.Add(destinatario);

            using (var cliente = new SmtpClient(host, puerto))
            {
                cliente.Credentials = new NetworkCredential(usuario, contrasena);
                cliente.EnableSsl = true;

                try
                {
                    cliente.Send(mensaje);
                    return true;
                }
                catch (Exception ex)
                {
                    Trace.TraceError("Error al enviar correo: " + ex.Message);
                    return false;
                }
            }
        }    

        public void EnviarCorreoBienvenida(Usuario usuario)
        {
            string dominio = ConfigurationManager.AppSettings["Dominio"];
            string enlace = $"{dominio}/GenerarContrasenia.aspx?email={usuario.Email}&token={usuario.TokenValidacion}";

            string cuerpo = GenerarCuerpoHtml(
                $"¡Bienvenido/a, {usuario.Nombre} {usuario.Apellido}!",
                "Gracias por unirte a <strong>MisCursos.com</strong>, la plataforma donde potenciarás tu aprendizaje en línea.",
                "Activar mi cuenta",
                enlace,
                usuario
            );

            string asunto = $"¡Bienvenid@ {usuario.Nombre}! Activá tu cuenta en MisCursos.com";
            EnviarCorreo(cuerpo, usuario.Email, asunto);
        }

        public void RecuperarContrasenia(Usuario usuario)
        {
            string dominio = ConfigurationManager.AppSettings["Dominio"];
            string enlace = $"{dominio}/GenerarContrasenia.aspx?email={usuario.Email}&token={usuario.TokenValidacion}";

            string cuerpo = GenerarCuerpoHtml(
                $"¡Hola {usuario.Nombre} {usuario.Apellido}!",
                "Solicitaste restablecer tu contraseña. Para continuar, hacé clic en el botón de abajo.",
                "Restablecer Contraseña",
                enlace,
                usuario
            );

            string asunto = $"Restablecé tu contraseña en MisCursos.com";
            EnviarCorreo(cuerpo, usuario.Email, asunto);
        }

        private string GenerarCuerpoHtml(string titulo, string mensajePersonalizado, string botonTexto, string enlace, Usuario usuario)
        {
            return $@"
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
                    h1 {{ color: #343a40; }}
                    p {{ color: #555; line-height: 1.6; }}
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
                    .btn:hover {{ background-color: #0056b3; }}
                    .footer {{
                        margin-top: 40px;
                        font-size: 12px;
                        color: #999;
                        text-align: center;
                    }}
                    @media (max-width: 600px) {{
                        body {{ padding: 10px; }}
                        .container {{ width: 90%; padding: 15px; }}
                        h1 {{ font-size: 20px; }}
                        p {{ font-size: 14px; }}
                        .btn {{ padding: 10px 18px; font-size: 14px; }}
                    }}
                </style>
            </head>
            <body>
                <div class='container'>
                    <h1>{titulo}</h1>
                    <p>{mensajePersonalizado}</p>
                    <p>Tu nombre de usuario registrado es: <strong>{usuario.NombreUsuario}</strong></p>
                    <p><a href='{enlace}' class='btn'>{botonTexto}</a></p>
                    <p>Si no solicitaste esta acción, podés ignorar este mensaje.</p>
                    <br />
                    <p>Saludos cordiales,<br /><strong>El equipo de MisCursos.com</strong></p>
                    <div class='footer'>
                        &copy; {DateTime.Now.Year} MisCursos.com · Todos los derechos reservados.
                    </div>
                </div>
            </body>
            </html>";
        }
    }
}

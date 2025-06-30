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
    public partial class BuscarResultado : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string palabra = Request.QueryString["q"];

                if (string.IsNullOrWhiteSpace(palabra))
                {
                    lblMensaje.Text = "No se ingresó ninguna palabra para buscar.";
                    lblMensaje.Visible = true;
                    return;
                }

                int rolUsuario = (int)Rol.Estudiante;

                if (Session["UsuarioAutenticado"] != null)
                {
                    var usuario = (UsuarioAutenticado)Session["UsuarioAutenticado"];
                    rolUsuario = (int)usuario.Rol;
                }

                CursoServicio cursoServicio = new CursoServicio();
                NovedadesServicio publicacionServicio = new NovedadesServicio();

                var cursos = cursoServicio.BuscarPorTitulo(palabra, rolUsuario);
                var publicaciones = publicacionServicio.BuscarPorTitulo(palabra, rolUsuario);


                if (cursos.Count == 0 && publicaciones.Count == 0)
                {
                    lblMensaje.Text = $"No se encontraron resultados para '{palabra}'.";
                    lblMensaje.Visible = true;
                    return;
                }

                if (cursos.Count > 0)
                {
                    panelCursos.Visible = true;
                    rptCursos.DataSource = cursos.Select(c => new
                    {
                        Id = c.IdCurso,
                        Titulo = c.Titulo,
                        Resumen = c.Resumen,
                        Precio = c.Precio,
                        ImagenUrl = !string.IsNullOrWhiteSpace(c.ImagenPortada?.Url)
                            ? c.ImagenPortada.Url
                            : "~/imagenes/default.jpg"
                    }).ToList();

                    rptCursos.DataBind();
                }

                if (publicaciones.Count > 0)
                {
                    publicaciones = publicaciones
                    .GroupBy(p => p.IdPublicacion)
                     .Select(g =>
                     {
                         var pub = g.First();
                         pub.Imagenes = pub.Imagenes?.Take(1).ToList();
                         return pub;
                     })
                    .ToList();

                    panelPublicaciones.Visible = true;
                    rptPublicaciones.DataSource = publicaciones.Select(p => new
                    {
                        Id = p.IdPublicacion,
                        Titulo = p.Titulo,
                        Resumen = p.Resumen,
                        ImagenUrl = string.IsNullOrEmpty(p.UrlImagen) ? "~/imagenes/default.jpg" : p.UrlImagen
                    }).ToList();

                    rptPublicaciones.DataBind();
                }

            }
        }

    }

}
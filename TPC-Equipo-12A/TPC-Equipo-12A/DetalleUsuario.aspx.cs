using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;
using AngleSharp.Dom;
using Dominio;
using Servicio;

namespace TPC_Equipo_12A
{
    public partial class DetalleUsuario : System.Web.UI.Page
    {
        public int IdUsuario;
        protected Usuario usuario = null;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!Seguridad.esAdmin(Session["UsuarioAutenticado"]))
            {
                Session.Add("error", "Hey, no deberías andar por acá 🤨. Acceso no permitido");
                Response.Redirect("Error.aspx");
            }

            UsuarioServicio usuarioServicio = new UsuarioServicio();
            IdUsuario = int.Parse(Request.QueryString["id"]);
            usuario = usuarioServicio.BuscarPorId(IdUsuario);

            if (!IsPostBack)
            {

                imgFotoPerfil.ImageUrl = usuario.FotoPerfil?.Url ?? "~/img/default-user.png";
                lblNombreCompleto.Text = $"{usuario.Nombre} {usuario.Apellido}";
                lblNombreUsuario.Text = usuario.NombreUsuario;
                lblFechaRegistro.Text = usuario.FechaRegistro?.ToString("dd/MM/yyyy");
                lblEmail.Text = usuario.Email;

                if (usuario.Habilitado)
                {
                    lblHabilitado.Text = "Habilitado";
                    lblHabilitado.CssClass += " bg-success text-white";
                }
                else
                {
                    lblHabilitado.Text = "Deshabilitado";
                    lblHabilitado.CssClass += " bg-danger text-white";
                }

                CargarGrillas();

            }




        }

        public void CargarGrillas()
        {
            NotificacionesServicio noSer = new NotificacionesServicio();
            CompraServicio compraServicio = new CompraServicio();
            ComentarioServicio comentarioServicio = new ComentarioServicio();
            CursoServicio servicio = new CursoServicio();

            try
            {
                List<CursoDTO> lista = new List<CursoDTO>();

                lista = servicio.ObtenerCursosCompletosDeUsuario(IdUsuario, false);

                gvDatosCursos.DataSource = lista;
                gvDatosCursos.DataBind();


                List<Compra> compras = compraServicio.getComprasPorIdUsuario(IdUsuario, false);
                gvComprasUsuario.DataSource = compras;
                gvComprasUsuario.DataBind();


                List<ComentarioDTO> listaCom = new List<ComentarioDTO>();
                listaCom = comentarioServicio.ListarComentariosDeUsuario(IdUsuario);

                gvComentarios.DataSource = listaCom;
                gvComentarios.DataBind();


                List<ReporteDTO> reporteDTOs = new List<ReporteDTO>();
                reporteDTOs = noSer.ListarReportesDeUsuario(IdUsuario);

                gvReportes.DataSource = reporteDTOs;
                gvReportes.DataBind();
            }
            catch (Exception ex)
            {

                Response.Redirect("Error.aspx", false);
            }
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Servicio;
using Dominio;
using System.Collections;

namespace TPC_Equipo_12A
{
    public partial class ListaNotificaciones : System.Web.UI.Page
    {
        protected UsuarioAutenticado usuario;
        protected void Page_Load(object sender, EventArgs e)
        {
            usuario = (UsuarioAutenticado)Session["UsuarioAutenticado"];

            if (!Seguridad.esAdmin(Session["UsuarioAutenticado"]))
            {
                Session.Add("error", "Hey, no deberías andar por acá 🤨. Acceso no permitido");
                Response.Redirect("Error.aspx");
            }

            if (!IsPostBack)
            {
                CargarNotificaciones(false);
            }
        }

        private void CargarNotificaciones(bool soloNuevas)
        {
            lblTitulo.Text = "Comentarios:";
            NotificacionesServicio servicio = new NotificacionesServicio();
            int idAdmin = usuario.IdUsuario;

            List<Notificacion> lista = servicio.ListarComentarios(idAdmin, soloNuevas);

            gvNotificaciones.DataSource = lista;
            gvNotificaciones.DataBind();

            gvNotificaciones.Columns[4].Visible = false;
            gvNotificaciones.Columns[5].Visible = false;

            gvNotificaciones.Visible = true;
        }

        private void CargarReportes(bool soloNoVistos)
        {
            lblTitulo.Text = "Reportes:";
            NotificacionesServicio servicio = new NotificacionesServicio();
            int idAdmin = usuario.IdUsuario;

            List<Notificacion> lista = servicio.ListarReportes(idAdmin, soloNoVistos);

            gvNotificaciones.DataSource = lista;

            gvNotificaciones.Columns[4].Visible = true;
            gvNotificaciones.Columns[5].Visible = true;
            gvNotificaciones.DataBind();
            gvNotificaciones.Visible = true;
        }
        protected void btnVerTodas_Click(object sender, EventArgs e)
        {
            CargarNotificaciones(false);
        }

        protected void btnVerNuevas_Click(object sender, EventArgs e)
        {
            CargarNotificaciones(true);
        }

        protected void chkVisto_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox chk = (CheckBox)sender;
            GridViewRow fila = (GridViewRow)chk.NamingContainer;
            HiddenField hf = (HiddenField)fila.FindControl("hfIdNotificacion");

            int idNotif = int.Parse(hf.Value);
            NotificacionesServicio ser = new NotificacionesServicio();
            ser.MarcarComoVista(idNotif);

            CargarNotificaciones(false);
        }

        protected void gvNotificaciones_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ver")
            {
                string[] valores = e.CommandArgument.ToString().Split('|');

                int idNotificacion = int.Parse(valores[0]);
                int idOrigen = int.Parse(valores[1]);
                string tipo = (valores[2]).ToString();

                // marcar como vista, veremos
                NotificacionesServicio ser = new NotificacionesServicio();
                ser.MarcarComoVista(idNotificacion);

                // redirigir a detalle, bueno aca ahora dberia ir a foro tmb

                if(tipo == "novedades")
                    Response.Redirect("DetalleNovedad.aspx?IdNovedad=" + idOrigen);
                else
                    Response.Redirect("ForoDetalle.aspx?id=" + idOrigen);
            }
        }

        protected void btnTodosReportes_Click(object sender, EventArgs e)
        {
            CargarReportes(false);
        }

        protected void btnReportenuevos_Click(object sender, EventArgs e)
        {
            CargarReportes(true);
        }

        protected void btnOcultarLeidos_Click(object sender, EventArgs e)
        {
            NotificacionesServicio servicio = new NotificacionesServicio();
            servicio.OcurltarLeidos();

            CargarNotificaciones(false);
        }

        protected void gvNotificaciones_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvNotificaciones.PageIndex = e.NewPageIndex;
            CargarNotificaciones(false);
        }
    }
}
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
    public partial class ListaFaqs : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Seguridad.esAdmin(Session["UsuarioAutenticado"]))
            {
                Session.Add("error", "Hey, no deberías andar por acá 🤨. Acceso no permitido");
                Response.Redirect("Error.aspx");
            }

            if (!IsPostBack)
            {
                FaqServicio servicio = new FaqServicio();

                dgvFaqs.DataSource = servicio.Listar();
                dgvFaqs.DataBind();
            }
        }

        protected void dgvFaqs_SelectedIndexChanged(object sender, EventArgs e)
        {
            int idFaq = Convert.ToInt32(dgvFaqs.SelectedDataKey.Value);

            FaqServicio servicio = new FaqServicio();
            PreguntasFrecuentes faq = servicio.GetFaq(idFaq);

            if (faq != null)
            {

                txtPregunta.Text = faq.Pregunta;
                txtRespuesta.Text = faq.Respuesta;
                ddlActivo.SelectedValue = faq.Activo ? "1" : "0";

                btnAgregarFaq.Text = "Actualizar";
                Session["IdFaqEditar"] = idFaq;

                ScriptManager.RegisterStartupScript(this, GetType(), "abrirModal",
                "abrirModal();", true);
            }
        }

        protected void dgvFaqs_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            dgvFaqs.PageIndex = e.NewPageIndex;
            dgvFaqs.DataBind();
        }

        protected void btnAgregarFaq_Click(object sender, EventArgs e)
        {
            FaqServicio servicio = new FaqServicio();

            try
            {
                string pregunta = txtPregunta.Text;
                string respuesta = txtRespuesta.Text;
                int activo = Convert.ToInt32(ddlActivo.SelectedValue);

                if (Session["IdFaqEditar"] != null)
                {
                    int idFaq = (int)Session["IdFaqEditar"];
                    servicio.ModificarFaq(idFaq, pregunta, respuesta, activo);
                }
                else
                {
                    servicio.AgregarFaq(pregunta, respuesta, activo);
                }

                ScriptManager.RegisterStartupScript(this, GetType(), "cerrarModal",
                    "$('#exampleModal').modal('hide');", true);

                dgvFaqs.DataSource = servicio.Listar();
                dgvFaqs.DataBind();

                LimpiarFormulario();

            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        private void LimpiarFormulario()
        {
            txtPregunta.Text = "";
            txtRespuesta.Text = "";
            ddlActivo.SelectedValue = "1";
            btnAgregarFaq.Text = "Aceptar";
            Session["IdFaqEditar"] = null;
        }
    }
}
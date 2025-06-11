using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Servicio;
using Dominio;

namespace TPC_Equipo_12A
{
    public partial class Perfil : System.Web.UI.Page
    {
        protected int idQueryParam;
        protected void Page_Load(object sender, EventArgs e)
        {
            UsuarioAutenticado usuarioAutenticado = Session["UsuarioAutenticado"] as UsuarioAutenticado;


            if (usuarioAutenticado == null || string.IsNullOrEmpty(Request.QueryString["id"]))
            {
                Session["error"] = "Debe iniciar sesion o indicar un ID para poder acceder al perfil.";
                Response.Redirect("Error.aspx");
                return;
            }
            idQueryParam = int.Parse(Request.QueryString["id"]);
            if (!(usuarioAutenticado.Rol == Rol.Administrador || usuarioAutenticado.IdUsuario == idQueryParam))
            {
                Session["error"] = "Usted no es el dueño del perfil al que quiere acceder.";
                Response.Redirect("Error.aspx");
                return;
            }
            else
            {
                if (!IsPostBack)
                {
                    btnInhabilitar.Visible = false;

                    lblError.Text = "";
                    lblExito.Text = "";
                    UsuarioServicio usuarioServicio = new UsuarioServicio();
                    Usuario usuario = usuarioServicio.ObtenerPerfil(idQueryParam);
                    if (usuarioAutenticado.Rol == Rol.Administrador)
                    {
                        btnInhabilitar.Visible = true;
                        cambiarBoton(usuario);
                    }
                    Session["usuario"] = usuario;
                    txtNombre.Text = usuario.Nombre;
                    txtApellido.Text = usuario.Apellido;
                    txtFechaNacimiento.Text = usuario.FechaNacimiento.Value.ToString("yyyy-MM-dd");
                    txtCelular.Text = usuario.Celular;
                    litEmail.Text = usuario.Email.ToString();
                    litPerfilTitulo.Text = $"{usuario.NombreUsuario}";
                    litFechaRegistro.Text = $"{usuario.Rol.ToString()} desde el {usuario.FechaRegistro?.ToString("dd/MM/yyyy") ?? "-"}";
                    txtUrlFoto.Text = usuario.FotoPerfil.Url ?? "https://static-00.iconduck.com/assets.00/profile-user-icon-512x512-nm62qfu0.png";
                    imgFotoPerfil.ImageUrl = txtUrlFoto.Text;

                }
            }
        }

        protected void txtUrlFoto_TextChanged(object sender, EventArgs e)
        {
            imgFotoPerfil.ImageUrl = txtUrlFoto.Text == "" ? "https://static-00.iconduck.com/assets.00/profile-user-icon-512x512-nm62qfu0.png" : txtUrlFoto.Text;
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (Session["usuario"] == null)
            {
                lblError.Text = "La sesion ha expirado. Por favor, inicia sesion nuevamente.";
                return;
            }

            Usuario usuario = (Usuario)Session["usuario"];

            if (string.IsNullOrWhiteSpace(txtNombre.Text) || string.IsNullOrWhiteSpace(txtApellido.Text))
            {
                lblError.Text = "El nombre y apellido no pueden estar vacios.";
                return;
            }

            if (!System.Text.RegularExpressions.Regex.IsMatch(txtNombre.Text, @"^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$") ||
                !System.Text.RegularExpressions.Regex.IsMatch(txtApellido.Text, @"^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$"))
            {
                lblError.Text = "El nombre y apellido solo pueden contener letras y espacios.";
                return;
            }

            Uri uriResult;
            bool esUrlValida = Uri.TryCreate(txtUrlFoto.Text, UriKind.Absolute, out uriResult) &&
                               (uriResult.Scheme == Uri.UriSchemeHttp || uriResult.Scheme == Uri.UriSchemeHttps);

            if (!esUrlValida)
            {
                lblError.Text = "La URL de la imagen no es valida.";
                return;
            }

            DateTime fechaNacimiento;
            bool fechaIsValida = DateTime.TryParse(txtFechaNacimiento.Text, out fechaNacimiento);
            if (!fechaIsValida || DateTime.Now < fechaNacimiento)
            {
                lblError.Text = "La fecha de nacimiento no es valida.";
                return;
            }

            if (Request.QueryString["id"] == null || !int.TryParse(Request.QueryString["id"], out int idQueryParam))
            {
                lblError.Text = "No se pudo determinar el perfil a editar.";
                return;
            }

            try
            {
                UsuarioServicio usuarioServicio = new UsuarioServicio();
                usuario.Nombre = txtNombre.Text;
                usuario.Apellido = txtApellido.Text;
                usuario.Celular = txtCelular.Text;
                usuario.FechaNacimiento = fechaNacimiento;

                if (usuario.FotoPerfil == null || usuario.FotoPerfil.Url != txtUrlFoto.Text)
                {
                    ImagenServicio imagenServicio = new ImagenServicio();
                    usuario.FotoPerfil = new Imagen { Url = txtUrlFoto.Text };
                    usuario.FotoPerfil.IdImagen = imagenServicio.agregarImagen(usuario.FotoPerfil);
                }

                usuarioServicio.ActualizarUsuario(usuario);

                if (Session["UsuarioAutenticado"] is UsuarioAutenticado usuarioAutenticado &&
                    usuarioAutenticado.IdUsuario == idQueryParam &&
                    usuario.FotoPerfil?.Url != usuarioAutenticado.FotoPerfil?.Url)
                {
                    usuarioAutenticado.FotoPerfil = usuario.FotoPerfil;
                    Session["UsuarioAutenticado"] = usuarioAutenticado;
                }
                ScriptManager.RegisterStartupScript(this, GetType(), "sweetalert", 
                    @"Swal.fire({
                        title: '¡Guardado!',
                        text: 'El perfil fue actualizado correctamente.',
                        icon: 'success',
                        confirmButtonText: 'OK'
                    });
                ", true);
            }
            catch
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "sweetalert",
                    @"Swal.fire({
                        title: '¡Error!',
                        text: 'Ocurrio un error durante la actualizacion.',
                        icon: 'error',
                        confirmButtonText: 'OK'
                    });
                ", true);
            }
        }

        protected void btnInhabilitar_Click(object sender, EventArgs e)
        {
            Usuario usuario = (Usuario)Session["usuario"];
            UsuarioServicio usuarioServicio = new UsuarioServicio();
            if (usuario.Rol == 0)
                return;
            try
            {
                usuario.Habilitado = !usuario.Habilitado;
                cambiarBoton(usuario);

                usuarioServicio.ActualizarUsuario(usuario);
                Session["usuario"] = usuario;
                ScriptManager.RegisterStartupScript(this, GetType(), "sweetalert",
                    @"Swal.fire({
                        title: '¡Guardado!',
                        text: 'El perfil fue actualizado correctamente.',
                        icon: 'success',
                        confirmButtonText: 'OK'
                    });
                ", true);

            }
            catch (Exception)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "sweetalert",
                    @"Swal.fire({
                        title: '¡Error!',
                        text: 'Ocurrio un error durante la actualizacion.',
                        icon: 'error',
                        confirmButtonText: 'OK'
                    });
                ", true);
            }

        }

        public void cambiarBoton(Usuario usuario)
        {
            if (usuario.Habilitado)
            {
                btnInhabilitar.Text = "Inhabilitar Usuario";
                btnInhabilitar.CssClass = "btn btn-danger w-100 mb-3";
                btnInhabilitar.Attributes.Add("onclick", "return confirm('⚠️ Atención: ¿Realmente deseas inhabilitar a este usuario?');");
            }
            else
            {
                btnInhabilitar.Text = "Habilitar Usuario";
                btnInhabilitar.CssClass = "btn btn-success w-100 mb-3";
                btnInhabilitar.Attributes.Add("onclick", "return confirm('⚠️ Atención: ¿Realmente deseas habilitar a este usuario?');");
            }

        }
    }
}

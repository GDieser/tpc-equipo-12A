using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dominio;

namespace Servicio
{
    public class UsuarioServicio
    {
        public Usuario BuscarPorEmailNombreUsuario(string email, string nombreUsuario)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setConsulta("SELECT * FROM Usuario WHERE Email = @Email OR NombreUsuario = @nombreUsuario");
                datos.limpiarParametros();
                datos.setParametro("@Email", email);
                datos.setParametro("@NombreUsuario", nombreUsuario);
                datos.ejecutarLectura();
                if (!datos.Lector.Read())
                {
                    return null;
                }
                Usuario usuario = new Usuario();
                usuario.IdUsuario = (int)datos.Lector["IdUsuario"];
                usuario.Nombre = (string)datos.Lector["Nombre"];
                usuario.Apellido = (string)datos.Lector["Apellido"];
                usuario.Email = (string)datos.Lector["Email"];
                usuario.Rol = (Rol)datos.Lector["IdRol"];
                usuario.Celular = datos.Lector["Celular"] != DBNull.Value ? (string)datos.Lector["Celular"] : "";
                usuario.NombreUsuario = (string)datos.Lector["NombreUsuario"];
                usuario.Habilitado = (bool)datos.Lector["Habilitado"];
                usuario.TokenValidacion = datos.Lector["TokenValidacion"] != DBNull.Value ? (string)datos.Lector["TokenValidacion"] : null;
                usuario.EmailValidado = datos.Lector["EmailValidado"] != DBNull.Value ? (bool)datos.Lector["EmailValidado"] : false;
                usuario.FechaRegistro = datos.Lector["FechaRegistro"] != DBNull.Value ? (DateTime)datos.Lector["FechaRegistro"] : DateTime.MinValue;
                usuario.RecuperoContrasenia = datos.Lector["RecuperoContrasenia"] != DBNull.Value ? (bool)datos.Lector["RecuperoContrasenia"] : false;

                return usuario;
            }
            catch (Exception)
            {
                return null;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public Usuario BuscarPorId(int id)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setProcedimiento("sp_ObtenerUsuarioPorId");

                datos.limpiarParametros();
                datos.setParametro("@IdUsuario", id);
                datos.ejecutarLectura();
                if (!datos.Lector.Read())
                {
                    return null;
                }
                Usuario usuario = new Usuario();
                usuario.IdUsuario = (int)datos.Lector["IdUsuario"];
                usuario.Nombre = (string)datos.Lector["Nombre"];
                usuario.Apellido = (string)datos.Lector["Apellido"];
                usuario.Email = (string)datos.Lector["Email"];
                usuario.Celular = datos.Lector["Celular"] != DBNull.Value ? (string)datos.Lector["Celular"] : "";
                usuario.Rol = (Rol)datos.Lector["IdRol"];
                usuario.Habilitado = (bool)datos.Lector["Habilitado"];
                usuario.NombreUsuario = (string)datos.Lector["NombreUsuario"];
                usuario.FechaRegistro = datos.Lector["FechaRegistro"] != DBNull.Value ? (DateTime)datos.Lector["FechaRegistro"] : DateTime.MinValue;
                usuario.FechaNacimiento = datos.Lector["FechaNacimiento"] != DBNull.Value ? (DateTime)datos.Lector["FechaNacimiento"] : DateTime.MinValue;

                if (datos.Lector["IdImagen"] != DBNull.Value)
                {
                    usuario.FotoPerfil = new Imagen
                    {
                        IdImagen = (int)datos.Lector["IdImagen"],
                        Url = datos.Lector["UrlImagen"].ToString(),
                        Nombre = datos.Lector["nombreImagen"].ToString()
                    };
                }
                else
                {
                    usuario.FotoPerfil = new Imagen
                    {
                        IdImagen = 0,
                        Nombre = "default-perfil.webp",
                        Url = "~/images/perfil/default-perfil.webp"
                    };
                }
                return usuario;
            }
            catch (Exception)
            {
                throw new Exception("Error al cargar el usuario");
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void RegistrarUsuario(Usuario usuario)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setProcedimiento(@"sp_InsertarUsuario");

                datos.limpiarParametros();
                datos.setParametro("@Nombre", usuario.Nombre);
                datos.setParametro("@Apellido", usuario.Apellido);
                datos.setParametro("@Email", usuario.Email);
                datos.setParametro("@NombreUsuario", usuario.NombreUsuario);
                datos.setParametro("@IdRol", (int)usuario.Rol);
                datos.setParametro("@Habilitado", usuario.Habilitado);
                datos.setParametro("@TokenValidacion", usuario.TokenValidacion);
                datos.setParametro("@EmailValidado", usuario.EmailValidado);
                datos.setParametro("@FechaRegistro", usuario.FechaRegistro);
                datos.setParametro("@RecuperoContrasenia", usuario.RecuperoContrasenia);

                datos.ejecutarAccion();
                ServicioMail servicioMail = new ServicioMail();
                try
                {
                    servicioMail.EnviarCorreoBienvenida(usuario);
                }
                catch (Exception ex)
                {
                    Console.WriteLine("Error al enviar correo: " + ex.ToString());
                }

            }
            catch (Exception ex)
            {
                throw new Exception("Error al registrar el usuario", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void GuardarContrasenia(Usuario usuario)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setProcedimiento(@"sp_GuardarContrasenia");

                datos.limpiarParametros();
                datos.setParametro("@TokenValidacion", usuario.TokenValidacion ?? (object)DBNull.Value);
                datos.setParametro("@EmailValidado", usuario.EmailValidado);
                datos.setParametro("@Pass", usuario.Pass);
                datos.setParametro("@RecuperoContrasenia", usuario.RecuperoContrasenia);
                datos.setParametro("@IdUsuario", usuario.IdUsuario);
                datos.setParametro("@NombreUsuario", usuario.NombreUsuario);
                datos.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw new Exception("Error al actualizar la contraseña", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void ActualizarUsuario(Usuario usuario)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setProcedimiento(@"sp_ActualizarUsuario");

                datos.limpiarParametros();
                datos.setParametro("@IdUsuario", usuario.IdUsuario);
                datos.setParametro("@Nombre", usuario.Nombre);
                datos.setParametro("@Apellido", usuario.Apellido);
                datos.setParametro("@Email", usuario.Email);
                datos.setParametro("@Celular", usuario.Celular ?? (object)DBNull.Value);
                datos.setParametro("@NombreUsuario", usuario.NombreUsuario);
                datos.setParametro("@FechaNacimiento", usuario.FechaNacimiento ?? (object)DBNull.Value);
                datos.setParametro("@IdRol", (int)usuario.Rol);
                datos.setParametro("@FotoPerfil", usuario.FotoPerfil != null ? (object)usuario.FotoPerfil.IdImagen : DBNull.Value);
                datos.setParametro("@Habilitado", usuario.Habilitado);
                datos.setParametro("@FechaRegistro", usuario.FechaRegistro);
                datos.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw new Exception("Error al actualizar el usuario", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void RecuperarContrasenia(Usuario usuario)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setProcedimiento(@"sp_RecuperarContrasenia");


                datos.limpiarParametros();
                datos.setParametro("@IdUsuario", usuario.IdUsuario);
                datos.setParametro("@NombreUsuario", usuario.NombreUsuario);
                datos.setParametro("@TokenValidacion", usuario.TokenValidacion);
                datos.setParametro("@RecuperoContrasenia", usuario.RecuperoContrasenia);
                datos.ejecutarAccion();
                ServicioMail servicioMail = new ServicioMail();
                try
                {
                    servicioMail.RecuperarContrasenia(usuario);
                }
                catch (Exception ex)
                {
                    Console.WriteLine("Error al enviar correo: " + ex.ToString());
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al actualizar el usuario", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }

        }

        public Usuario ObtenerPerfil(int id)
        {
            Usuario usuario = BuscarPorId(id);
            return usuario;
        }

        public List<Usuario> ListarUsuarios()
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setProcedimiento(@"sp_ListarUsuarios"); 

                datos.limpiarParametros();
                datos.ejecutarLectura();

                List<Usuario> usuarios = new List<Usuario>();

                while (datos.Lector.Read())
                {
                    Usuario usuario = new Usuario();
                    usuario.IdUsuario = (int)datos.Lector["IdUsuario"];
                    usuario.Nombre = (string)datos.Lector["Nombre"];
                    usuario.Apellido = (string)datos.Lector["Apellido"];
                    usuario.Email = (string)datos.Lector["Email"];
                    usuario.Celular = datos.Lector["Celular"] != DBNull.Value ? (string)datos.Lector["Celular"] : "";
                    usuario.Rol = (Rol)datos.Lector["IdRol"];
                    usuario.Habilitado = (bool)datos.Lector["Habilitado"];
                    usuario.NombreUsuario = (string)datos.Lector["NombreUsuario"];
                    usuario.FechaRegistro = datos.Lector["FechaRegistro"] != DBNull.Value ? (DateTime)datos.Lector["FechaRegistro"] : DateTime.MinValue;
                    usuario.FechaNacimiento = datos.Lector["FechaNacimiento"] != DBNull.Value ? (DateTime)datos.Lector["FechaNacimiento"] : DateTime.MinValue;
                    usuario.CursosAdquiridos = (int)datos.Lector["CursosComprados"];
                    if (datos.Lector["IdImagen"] != DBNull.Value)
                    {
                        usuario.FotoPerfil = new Imagen
                        {
                            IdImagen = (int)datos.Lector["IdImagen"],
                            Url = datos.Lector["UrlImagen"].ToString(),
                            Nombre = datos.Lector["nombreImagen"].ToString()
                        };
                    }
                    else
                    {
                        usuario.FotoPerfil = new Imagen
                        {
                            IdImagen = 0,
                            Nombre = "default-perfil.webp",
                            Url = "~/images/perfil/default-perfil.webp"
                        };
                    }
                    usuarios.Add(usuario);
                }
                return usuarios;
            }
            catch (Exception ex)
            {
                throw new Exception("Error al listar los usuarios", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
}
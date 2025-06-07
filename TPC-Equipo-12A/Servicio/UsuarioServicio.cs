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
                usuario.IdUsuarioMoodle = datos.Lector["IdUsuarioMoodle"] != DBNull.Value ? (int)datos.Lector["IdUsuarioMoodle"] : 0;
                usuario.Nombre = (string)datos.Lector["Nombre"];
                usuario.Apellido = (string)datos.Lector["Apellido"];
                usuario.Email = (string)datos.Lector["Email"];
                usuario.Rol = (Rol)datos.Lector["IdRol"];
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

        public void RegistrarUsuario(Usuario usuario)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setConsulta(@"
            INSERT INTO Usuario (
                Nombre,
                Apellido,
                Email,
                NombreUsuario,
                IdRol,
                Habilitado,
                TokenValidacion,
                EmailValidado,
                FechaRegistro,
                RecuperoContrasenia
            )
            VALUES (
                @Nombre,
                @Apellido,
                @Email,
                @NombreUsuario,
                @IdRol,
                @Habilitado,
                @TokenValidacion,
                @EmailValidado,
                @FechaRegistro,
                @RecuperoContrasenia
            )
        ");

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
                datos.setConsulta(@"
            UPDATE Usuario
            SET 
                TokenValidacion = @TokenValidacion,
                EmailValidado = @EmailValidado,
                Pass = @Pass,
                RecuperoContrasenia = @RecuperoContrasenia
            WHERE IdUsuario = @IdUsuario AND NombreUsuario = @NombreUsuario"
                );
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
                datos.setConsulta(@"
            UPDATE Usuario
            SET 
                Nombre = @Nombre,
                Apellido = @Apellido,
                Email = @Email,
                NombreUsuario = @NombreUsuario,
                IdRol = @IdRol,
                Habilitado = @Habilitado,
                FechaRegistro = @FechaRegistro,
            WHERE IdUsuario = @IdUsuario"
                );
                datos.limpiarParametros();
                datos.setParametro("@IdUsuario", usuario.IdUsuario);
                datos.setParametro("@Nombre", usuario.Nombre);
                datos.setParametro("@Apellido", usuario.Apellido);
                datos.setParametro("@Email", usuario.Email);
                datos.setParametro("@NombreUsuario", usuario.NombreUsuario);
                datos.setParametro("@IdRol", (int)usuario.Rol);
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
    }
}

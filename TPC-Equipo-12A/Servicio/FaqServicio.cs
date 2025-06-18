using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dominio;

namespace Servicio
{
    public class FaqServicio
    {
        public List<PreguntasFrecuentes> Listar()
        {

            AccesoDatos datos = new AccesoDatos();
            List<PreguntasFrecuentes> lista = new List<PreguntasFrecuentes> ();

            try
            {
                datos.setConsulta("SELECT IdFaq, Pregunta, Respuesta, Activo FROM PreguntasFrecuentes");
                datos.ejecutarLectura();

                while(datos.Lector.Read())
                {
                    PreguntasFrecuentes aux = new PreguntasFrecuentes ();

                    aux.IdFaq = (int)datos.Lector["IdFaq"];
                    aux.Pregunta = (string)datos.Lector["Pregunta"];
                    aux.Respuesta = (string)datos.Lector["Respuesta"];
                    aux.Activo = (bool)datos.Lector["Activo"];

                    lista.Add(aux);

                }
                return lista;
            }
            catch (Exception ex)
            {

                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public List<PreguntasFrecuentes> ListarActivos()
        {

            AccesoDatos datos = new AccesoDatos();
            List<PreguntasFrecuentes> lista = new List<PreguntasFrecuentes>();

            try
            {
                datos.setConsulta("SELECT IdFaq, Pregunta, Respuesta, Activo FROM PreguntasFrecuentes WHERE Activo = 1");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    PreguntasFrecuentes aux = new PreguntasFrecuentes();

                    aux.IdFaq = (int)datos.Lector["IdFaq"];
                    aux.Pregunta = (string)datos.Lector["Pregunta"];
                    aux.Respuesta = (string)datos.Lector["Respuesta"];
                    aux.Activo = (bool)datos.Lector["Activo"];

                    lista.Add(aux);

                }


                return lista;
            }
            catch (Exception ex)
            {

                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }


        }

        public PreguntasFrecuentes GetFaq(int id)
        {
            AccesoDatos datos = new AccesoDatos();
            PreguntasFrecuentes aux = new PreguntasFrecuentes();

            try
            {
                datos.setConsulta("SELECT IdFaq, Pregunta, Respuesta, Activo FROM PreguntasFrecuentes WHERE IdFaq = @id");
                datos.setParametro("@id", id);
                datos.ejecutarLectura();

                datos.Lector.Read(); //No te olvides de leer.... D:
                aux.IdFaq = (int)datos.Lector["IdFaq"];
                aux.Pregunta = (string)datos.Lector["Pregunta"];
                aux.Respuesta = (string)datos.Lector["Respuesta"];
                aux.Activo = (bool)datos.Lector["Activo"];


                return aux;
            }
            catch (Exception ex)
            {

                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }

        }


        public void ModificarFaq(int idFaq, string pregunta, string respuesta, int activo)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setConsulta("UPDATE PreguntasFrecuentes set Pregunta = @pregunta , Respuesta = @respuesta, Activo = @activo  Where IdFaq = @idFaq");

                datos.setParametro("@idFaq", idFaq);
                datos.setParametro("@pregunta", pregunta);
                datos.setParametro("@respuesta", respuesta);
                datos.setParametro("@activo", activo);

                datos.ejecutarAccion();


            }
            catch (Exception ex)
            {

                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }

        }

        public void AgregarFaq(string pregunta, string respuesta, int activo = 1)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setConsulta("INSERT INTO PreguntasFrecuentes(Pregunta, Respuesta, Activo) VALUES (@pregunta, @respuesta, @activo)");

                datos.setParametro("@pregunta", pregunta);
                datos.setParametro("@respuesta", respuesta);
                datos.setParametro("@activo", activo);

                datos.ejecutarAccion();


            }
            catch (Exception ex)
            {

                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
}

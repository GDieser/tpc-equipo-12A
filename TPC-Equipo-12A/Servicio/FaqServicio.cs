using System;
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
                datos.setConsulta("SELECT IdFaq, Pregunta, Respuesta FROM PreguntasFrecuentes");
                datos.ejecutarLectura();

                while(datos.Lector.Read())
                {
                    PreguntasFrecuentes aux = new PreguntasFrecuentes ();

                    aux.IdFaq = (int)datos.Lector["IdFaq"];
                    aux.Pregunta = (string)datos.Lector["Pregunta"];
                    aux.Respuesta = (string)datos.Lector["Respuesta"];

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
    }
}

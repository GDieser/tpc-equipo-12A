using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dominio;

namespace Servicio
{
    public class CertificadoServicio
    {
        public CertificadoDTO ObtenerCertificadoPorId(string idCertificado)
        {
            AccesoDatos datos = new AccesoDatos();
            CertificadoDTO certificado = new CertificadoDTO();
            try
            {
                datos.setParametro("@idCertificado", idCertificado);
                datos.setConsulta(@"
                    SELECT cer.IdUsuario, cer.IdCertificado, cer.IdCurso, cer.FechaEmision, 
                           c.Titulo, c.Duracion
                    FROM Certificado cer
                    INNER JOIN Curso c ON c.IdCurso = cer.IdCurso
                    WHERE cer.IdCertificado = @idCertificado     
                ");
                datos.ejecutarLectura();
                
                if (datos.Lector.Read())
                {
                    certificado.IdCertificado = datos.Lector["IdCertificado"].ToString();
                    certificado.IdCurso = (int)datos.Lector["IdCurso"];
                    certificado.IdUsuario = (int)datos.Lector["IdUsuario"];
                    certificado.NombreCurso = datos.Lector["Titulo"].ToString();
                    certificado.FechaEmision = DateTime.Parse(datos.Lector["FechaEmision"].ToString());
                    certificado.Duracion = (int)datos.Lector["Duracion"];
                }
                return certificado;
            }
            catch (Exception ex)
            {
                throw new Exception("No se pudo obtener el certificado", ex);
            }
        }

        public List<CertificadoDTO> ObtenerCertificadosPorUsuario(int idUsuario)
        {

            AccesoDatos datos = new AccesoDatos();
            List<CertificadoDTO> certificados = new List<CertificadoDTO>();
            try
            {
                datos.limpiarParametros();
                datos.setParametro("@idUsuario", idUsuario);
                datos.setConsulta(@"
                    SELECT cer.IdUsuario, cer.IdCertificado, cer.IdCurso, cer.FechaEmision, 
                           c.Titulo, i.UrlImagen
                    FROM Certificado cer
                    INNER JOIN Curso c ON c.IdCurso = cer.IdCurso
                    INNER JOIN ImagenCurso ic ON ic.IdCurso = cer.IdCurso
                    INNER JOIN Imagen i ON i.IdImagen = ic.IdImagen
                    WHERE cer.IdUsuario = @idUsuario 
                ");
                datos.ejecutarLectura();
                while (datos.Lector.Read())
                {
                    certificados.Add(new CertificadoDTO
                    {
                        IdCertificado = datos.Lector["IdCertificado"].ToString(),
                        IdCurso = (int)datos.Lector["IdCurso"],
                        IdUsuario = (int)datos.Lector["IdUsuario"],
                        NombreCurso = datos.Lector["Titulo"].ToString(),
                        FechaEmision = DateTime.Parse(datos.Lector["FechaEmision"].ToString()),
                        UrlImagen = datos.Lector["UrlImagen"].ToString()
                    });
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener los certificados", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
            return certificados;
        }

        public void RegistrarCertificado(int idCurso, int idUsuario)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.limpiarParametros();
                datos.setParametro("@idCurso", idCurso);
                datos.setParametro("@idUsuario", idUsuario);
                datos.setParametro("@fechaEmision", DateTime.Now);
                datos.setParametro("@idCertificado", Guid.NewGuid().ToString());
                datos.setConsulta(@"
                    IF EXISTS (SELECT 1 FROM Curso WHERE IdCurso = @idCurso AND Certificado = 1)
                    BEGIN
                        INSERT INTO Certificado (IdCertificado, IdCurso, IdUsuario, FechaEmision) 
                        VALUES (@idCertificado, @idCurso, @idUsuario, @fechaEmision)
                    END
                ");
                datos.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw new Exception("Error al cargar el certificado", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }

        }
    }
}

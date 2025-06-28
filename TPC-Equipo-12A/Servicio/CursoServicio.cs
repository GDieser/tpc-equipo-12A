using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using Dominio;

namespace Servicio
{
    public class CursoServicio
    {
        AccesoDatos datos = new AccesoDatos();
        public List<Curso> Listar(int rolUsuario)
        {
            AccesoDatos datos = new AccesoDatos();
            List<Curso> cursos = new List<Curso>();

            try
            {

                datos.setProcedimiento("sp_ListarCursosPorRol");
                datos.setParametro("@RolUsuario", rolUsuario);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Curso curso = new Curso
                    {
                        IdCurso = (int)datos.Lector["IdCurso"],
                        Titulo = (string)datos.Lector["Titulo"],
                        Resumen = (string)datos.Lector["Resumen"],
                        Descripcion = (string)datos.Lector["Descripcion"],
                        Precio = (decimal)datos.Lector["Precio"],
                        FechaPublicacion = (DateTime)datos.Lector["FechaPublicacion"],
                        Estado = (EstadoPublicacion)datos.Lector["Estado"],
                        Categoria = new Categoria
                        {
                            IdCategoria = (int)datos.Lector["IdCategoria"],
                            Nombre = !(bool)datos.Lector["ActivoCategoria"] ? "Sin Categoría" : (string)datos.Lector["NombreCategoria"],
                            Activo = (bool)datos.Lector["ActivoCategoria"]
                        },


                        ImagenPortada = datos.Lector["IdImagen"] != DBNull.Value
                                        ? new Imagen
                                        {
                                            IdImagen = (int)datos.Lector["IdImagen"],
                                            Url = datos.Lector["Url"].ToString(),
                                            Nombre = datos.Lector["NombreImagen"].ToString(),
                                            Tipo = datos.Lector["Tipo"] == DBNull.Value ? 0 : (int)datos.Lector["Tipo"]
                                        }
                                        : new Imagen
                                        {
                                            IdImagen = 0,
                                            Url = "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/480px-No_image_available.svg.png",
                                            Nombre = "default",
                                            Tipo = 0
                                        }
                    };

                    cursos.Add(curso);
                }

                return cursos;
            }
            catch
            {
                throw;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public Curso GetCursoPorId(int id)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setProcedimiento("sp_ObtenerCursoPorID");

                datos.setParametro("@id", id);
                datos.ejecutarLectura();

                if (!datos.Lector.Read())
                    return null;

                return new Curso
                {
                    IdCurso = (int)datos.Lector["IdCurso"],
                    Titulo = datos.Lector["Titulo"].ToString(),
                    Resumen = datos.Lector["Resumen"].ToString(),
                    Descripcion = datos.Lector["Descripcion"].ToString(),
                    Precio = (decimal)datos.Lector["Precio"],
                    Duracion = (int)datos.Lector["Duracion"],
                    Certificado = (bool)datos.Lector["Certificado"],
                    FechaCreacion = (DateTime)datos.Lector["FechaCreacion"],
                    FechaPublicacion = (DateTime)datos.Lector["FechaPublicacion"],
                    Estado = (EstadoPublicacion)(int)datos.Lector["Estado"],
                    Categoria = new Categoria
                    {
                        IdCategoria = (int)datos.Lector["IdCategoria"],
                        Nombre = datos.Lector["NombreCategoria"].ToString()
                    },
                    ImagenPortada = datos.Lector["IdImagen"] == DBNull.Value
                        ? new Imagen
                        {
                            IdImagen = 0,
                            Url = "https://www.aprender21.com/images/colaboradores/sql.jpeg",
                            Nombre = "default",
                            Tipo = 0
                        }
                        : new Imagen
                        {
                            IdImagen = (int)datos.Lector["IdImagen"],
                            Url = datos.Lector["UrlImagen"].ToString(),
                            Nombre = datos.Lector["Nombre"].ToString(),
                            Tipo = (int)datos.Lector["IdTipoImagen"]
                        }
                };
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public int GuardarCurso(Curso nuevo)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                // inserta la imagen a la db y extare su Id
                datos.setProcedimiento("sp_InsertarImagen");

                datos.setParametro("@url", nuevo.ImagenPortada?.Url ?? "/imagenes/default.jpg");
                datos.setParametro("@nombre", nuevo.ImagenPortada?.Nombre ?? "Imagen curso");
                datos.setParametro("@tipo", nuevo.ImagenPortada?.Tipo ?? 1);

                datos.ejecutarLectura();
                int idImagen = 0;
                if (datos.Lector.Read())
                    idImagen = Convert.ToInt32(datos.Lector[0]);

                datos.cerrarConexion();

                datos.limpiarParametros();

                datos.setProcedimiento(@"sp_InsertarCurso");

                datos.setParametro("@idcat", nuevo.Categoria.IdCategoria);
                datos.setParametro("@estado", nuevo.Estado);
                datos.setParametro("@titulo", nuevo.Titulo);
                datos.setParametro("@descripcion", nuevo.Descripcion);
                datos.setParametro("@resumen", nuevo.Resumen);
                datos.setParametro("@precio", nuevo.Precio);
                datos.setParametro("@fechaPub", nuevo.FechaPublicacion);
                datos.setParametro("@fechaCrea", nuevo.FechaCreacion);
                datos.setParametro("@duracion", nuevo.Duracion);
                datos.setParametro("@certificado", nuevo.Certificado);

                datos.ejecutarLectura();

                if (datos.Lector.Read())
                    nuevo.IdCurso = Convert.ToInt32(datos.Lector[0]);

                datos.cerrarConexion();
                datos.limpiarParametros();

                datos.setConsulta("INSERT INTO ImagenCurso (IdImagen, IdCurso) VALUES (@idimg, @idcurso)");
                datos.setParametro("@idimg", idImagen);
                datos.setParametro("@idcurso", nuevo.IdCurso);

                datos.ejecutarAccion();
                return nuevo.IdCurso;
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

        public void ModificarCurso(Curso curso)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setProcedimiento(@"sp_ModificarCurso");

                datos.setParametro("@titulo", curso.Titulo);
                datos.setParametro("@resumen", curso.Resumen);
                datos.setParametro("@descripcion", curso.Descripcion);
                datos.setParametro("@precio", curso.Precio);
                datos.setParametro("@duracion", curso.Duracion);
                datos.setParametro("@certificado", curso.Certificado);
                datos.setParametro("@fechaPublicacion", curso.FechaPublicacion);
                datos.setParametro("@estado", (int)curso.Estado);
                datos.setParametro("@idCategoria", curso.Categoria.IdCategoria);
                datos.setParametro("@id", curso.IdCurso);

                datos.ejecutarAccion();
                datos.cerrarConexion();

                datos = new AccesoDatos();

                if (curso.ImagenPortada.IdImagen > 0)
                {
                    datos.setConsulta(@"UPDATE Imagen
                                SET UrlImagen = @url,
                                    Nombre = @nombre,
                                    IdTipoImagen = @tipo
                                WHERE IdImagen = @idImagen");

                    datos.setParametro("@url", curso.ImagenPortada.Url);
                    datos.setParametro("@nombre", curso.ImagenPortada.Nombre);
                    datos.setParametro("@tipo", curso.ImagenPortada.Tipo);
                    datos.setParametro("@idImagen", curso.ImagenPortada.IdImagen);

                    datos.ejecutarAccion();
                }
                else
                {
                    datos.setConsulta(@"INSERT INTO Imagen (UrlImagen, Nombre, IdTipoImagen)
                                VALUES (@url, @nombre, @tipo);
                                SELECT SCOPE_IDENTITY();");

                    datos.setParametro("@url", curso.ImagenPortada.Url);
                    datos.setParametro("@nombre", curso.ImagenPortada.Nombre);
                    datos.setParametro("@tipo", curso.ImagenPortada.Tipo);

                    datos.ejecutarLectura();
                    if (datos.Lector.Read())
                    {
                        int nuevoId = Convert.ToInt32(datos.Lector[0]);
                        datos.cerrarConexion();
                        datos = new AccesoDatos();

                        datos.setConsulta(@"INSERT INTO ImagenCurso (IdCurso, IdImagen)
                                    VALUES (@idCurso, @idImagen)");

                        datos.setParametro("@idCurso", curso.IdCurso);
                        datos.setParametro("@idImagen", nuevoId);
                        datos.ejecutarAccion();
                    }
                }
            }
            finally
            {
                datos.cerrarConexion();
            }
        }



        /*  public Curso ObtenerCursoPorId(int id)

          {
              AccesoDatos accesoDatos = new AccesoDatos();
              try
              {
                  accesoDatos.setConsulta(@"
                  SELECT 
                      c.IdCurso, 
                      c.Titulo, 
                      c.Descripcion, 
                      c.Precio, 
                      c.FechaCreacion, 
                      c.FechaPublicacion, 
                      c.Estado, 
                      c.Duracion, 
                      c.Certificado,
                      i.UrlImagen AS ImagenPortadaUrl
                  FROM Curso c
                  INNER JOIN Imagen i ON c.ImagenPortada = i.IdImagen
                  WHERE c.IdCurso = @idCurso
                  ");
                  accesoDatos.limpiarParametros();
                  accesoDatos.setParametro("@idCurso", id);
                  accesoDatos.ejecutarLectura();
                  if (accesoDatos.Lector.Read())
                  {
                      Curso curso = new Curso
                      {
                          IdCurso = (int)accesoDatos.Lector["IdCurso"],
                          Titulo = accesoDatos.Lector["Titulo"].ToString(),
                          Descripcion = accesoDatos.Lector["Descripcion"].ToString(),
                          Precio = (decimal)accesoDatos.Lector["Precio"],
                          FechaCreacion = (DateTime)accesoDatos.Lector["FechaCreacion"],
                          FechaPublicacion = (DateTime)accesoDatos.Lector["FechaPublicacion"],
                          Estado = (EstadoPublicacion)Enum.Parse(typeof(EstadoPublicacion), accesoDatos.Lector["EstadoPublicacion"].ToString()),
                          Duracion = (int)accesoDatos.Lector["Duracion"],
                          Certificado = (bool)accesoDatos.Lector["Certificado"],
                          ImagenPortada = new Imagen { Url = accesoDatos.Lector["ImagenPortadaUrl"].ToString() }
                      };
                      return curso;
                  }
                  else
                  {
                      return null;
                  }
              }
              catch (Exception ex)
              {
                  throw new Exception("No se pudo obtener el curso por ID", ex);
              }
              finally
              {
                  accesoDatos.cerrarConexion();
              }
          }*/

        public bool EsUsuarioHabilitado(int idUsuario, int idCurso)
        {
            AccesoDatos accesoDatos = new AccesoDatos();
            try
            {
                accesoDatos.setConsulta(@"
                 SELECT 1
                 FROM Compra c
                 INNER JOIN DetalleCompra dc ON c.IdCompra = dc.IdCompra
                 WHERE c.IdUsuario = @IdUsuario AND dc.IdCurso = @IdCurso;
                 ");
                accesoDatos.limpiarParametros();
                accesoDatos.setParametro("@IdUsuario", idUsuario);
                accesoDatos.setParametro("@IdCurso", idCurso);
                accesoDatos.ejecutarLectura();
                if (accesoDatos.Lector.Read())
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al verificar si el usuario esta habilitado", ex);
            }
            finally
            {
                accesoDatos.cerrarConexion();
            }
        }

        public Curso ObtenerCursoPorId(int id, int idUsuario)
        {
            AccesoDatos accesoDatos = new AccesoDatos();
            try
            {
                accesoDatos.setConsulta(@"
            SELECT 
                c.IdCurso, 
                c.Titulo, 
                c.Descripcion, 
                c.Resumen,
                c.IdCategoria,
                cat.Nombre,
                c.FechaPublicacion,
                c.Estado,
                ic.IdImagen,
                i.UrlImagen AS ImagenPortadaUrl,
                i.Nombre AS NombreImagen,
                i.IdTipoImagen
            FROM Curso c
            INNER JOIN Categoria cat ON cat.IdCategoria = c.IdCategoria
            LEFT JOIN ImagenCurso ic ON ic.IdCurso = c.IdCurso
            LEFT JOIN Imagen i ON i.IdImagen = ic.IdImagen
            WHERE c.IdCurso = @idCurso
        ");

                accesoDatos.limpiarParametros();
                accesoDatos.setParametro("@idCurso", id);
                accesoDatos.ejecutarLectura();

                if (accesoDatos.Lector.Read())
                {
                    var curso = new Curso
                    {
                        IdCurso = (int)accesoDatos.Lector["IdCurso"],
                        Titulo = accesoDatos.Lector["Titulo"].ToString(),
                        Descripcion = accesoDatos.Lector["Descripcion"].ToString(),
                        Resumen = accesoDatos.Lector["Resumen"].ToString(),

                        Categoria = new Categoria
                        {
                            IdCategoria = (int)accesoDatos.Lector["IdCategoria"],
                            Nombre = accesoDatos.Lector["Nombre"].ToString()
                        },
                        FechaPublicacion = (DateTime)(accesoDatos.Lector["FechaPublicacion"] != DBNull.Value
                            ? (DateTime)accesoDatos.Lector["FechaPublicacion"]
                            : (DateTime?)null),
                        Estado = (EstadoPublicacion)(int)accesoDatos.Lector["Estado"],
                        ImagenPortada = new Imagen
                        {
                            Url = accesoDatos.Lector["ImagenPortadaUrl"] != DBNull.Value ? accesoDatos.Lector["ImagenPortadaUrl"].ToString() : "https://www.aprender21.com/images/colaboradores/sql.jpeg",
                            Nombre = accesoDatos.Lector["NombreImagen"] != DBNull.Value ? accesoDatos.Lector["NombreImagen"].ToString() : "default",
                            IdImagen = accesoDatos.Lector["IdImagen"] != DBNull.Value ? (int)accesoDatos.Lector["IdImagen"] : 0,
                            Tipo = accesoDatos.Lector["IdTipoImagen"] != DBNull.Value ? (int)accesoDatos.Lector["IdTipoImagen"] : 0
                        }

                    };

                    accesoDatos.cerrarConexion();
                    ModuloServicio moduloServicio = new ModuloServicio();
                    curso.Modulos = moduloServicio.ObtenerModulosPorIdCurso(curso.IdCurso, idUsuario);

                    return curso;
                }

                return null;
            }
            catch (Exception ex)
            {
                throw new Exception("No se pudo cargar el curso", ex);
            }
            finally
            {
                accesoDatos.cerrarConexion();
            }
        }

        public void AgregarCursoFavorito(int idUsuario, int idCurso)
        {

            try
            {
                DateTime fecha = DateTime.Now;

                datos.setConsulta("INSERT INTO CursoFavorito (IdUsuario, IdCurso, Agregado) VALUES (@idUsuario, @idCurso, @fecha)");
                datos.setParametro("@idUsuario", idUsuario);
                datos.setParametro("@idCurso", idCurso);
                datos.setParametro("@fecha", fecha);

                datos.ejecutarLectura();

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

        public CursoFavorito getCursoFavorito(int idUsuario, int idCurso)
        {
            CursoFavorito curso = new CursoFavorito();
            try
            {

                datos.setConsulta("SELECT IdUsuario, IdCurso, Agregado, Activo FROM CursoFavorito WHERE IdUsuario = @idUsuario AND IdCurso = @idCurso");
                datos.setParametro("@idUsuario", idUsuario);
                datos.setParametro("@idCurso", idCurso);

                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    curso.IdCurso = (int)datos.Lector["IdCurso"];
                    curso.IdUsuario = (int)datos.Lector["IdUsuario"];
                    curso.Agregado = (DateTime)datos.Lector["Agregado"];
                    curso.Activo = (bool)datos.Lector["Activo"];
                }
                else
                {
                    return null;
                }

                return curso;

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

        public void CambiarEstadoCursoFavorito(int IdUsuario, int idCurso, int estado)
        {
            try
            {
                datos.setConsulta("UPDATE CursoFavorito SET Activo = @estado WHERE IdCurso = @idCurso AND IdUsuario = @IdUsuario");

                datos.setParametro("@estado", estado);
                datos.setParametro("@idCurso", idCurso);
                datos.setParametro("@IdUsuario", IdUsuario);

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

        public List<Curso> ListarFavoritos(int idUsuario)
        {
            AccesoDatos datos = new AccesoDatos();
            List<Curso> cursos = new List<Curso>();

            try
            {
                datos.setProcedimiento("sp_ListarCursosFavoritos");

                datos.setParametro("@idUsuario", idUsuario);

                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Curso curso = new Curso();

                    curso.IdCurso = (int)datos.Lector["IdCurso"];
                    curso.Titulo = (string)datos.Lector["Titulo"];
                    curso.Resumen = (string)datos.Lector["Resumen"];

                    curso.ImagenPortada = new Imagen();

                    curso.ImagenPortada.Url = (string)datos.Lector["Url"];

                    cursos.Add(curso);
                }

                return cursos;
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

        public Carrito getCursoCarrito(int idUsuario, int idCurso)
        {
            Carrito carrito = new Carrito();
            CarritoCurso curso = new CarritoCurso();
            try
            {

                datos.setConsulta("SELECT C.IdCarrito, C.IdUsuario, C.FechaCreacion, C.UltimaModificacion, C.EstadoCarrito, CC.IdCurso, CC.PrecioUnitario FROM Carrito C INNER JOIN CarritoCurso CC ON C.IdCarrito = CC.IdCarrito WHERE C.EstadoCarrito = 0 AND C.IdUsuario = @idUsuario AND CC.IdCurso = @idCurso");
                datos.setParametro("@idUsuario", idUsuario);
                datos.setParametro("@idCurso", idCurso);

                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    carrito.IdCarrito = (int)datos.Lector["IdCarrito"];
                    carrito.IdUsuario = (int)datos.Lector["IdUsuario"];
                    carrito.FechaCreacion = (DateTime)datos.Lector["FechaCreacion"];

                    curso.IdCarrito = carrito.IdCarrito;
                    curso.IdCurso = (int)datos.Lector["IdCurso"];
                    curso.Precio = (decimal)datos.Lector["PrecioUnitario"];

                    carrito.CarritoCursos.Add(curso);

                    carrito.UltimaModificacion = (DateTime)datos.Lector["UltimaModificacion"];
                    carrito.Estado = (EstadoCarrito)datos.Lector["EstadoCarrito"];
                }
                else
                {
                    return null;
                }

                return carrito;

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

        // Metodo que devuelve el carrito (con el detalle) mediante el idUsuario
        public Carrito ListarCursoCarrito(int idUsuario)
        {
            //List<Carrito> carritos = new List<Carrito>();
            Carrito carrito = new Carrito();
            CarritoCurso curso = new CarritoCurso();
            try
            {

                datos.setConsulta("SELECT IdCarrito, IdUsuario, FechaCreacion, UltimaModificacion, EstadoCarrito FROM Carrito WHERE IdUsuario = @idUsuario AND EstadoCarrito = 0");
                datos.setParametro("@idUsuario", idUsuario);

                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    carrito.IdCarrito = (int)datos.Lector["IdCarrito"];
                    carrito.IdUsuario = (int)datos.Lector["IdUsuario"];
                    carrito.FechaCreacion = (DateTime)datos.Lector["FechaCreacion"];
                    carrito.UltimaModificacion = (DateTime)datos.Lector["UltimaModificacion"];
                    carrito.Estado = (EstadoCarrito)datos.Lector["EstadoCarrito"];

                }
                datos.cerrarConexion();

                int idCarrito = carrito.IdCarrito;

                datos.setConsulta("SELECT cc.IdCarrito, cc.IdCurso, cc.PrecioUnitario, c.Titulo as Nombre FROM CarritoCurso cc INNER JOIN Curso c ON c.IdCurso = cc.IdCurso WHERE IdCarrito = @idCarrito");
                datos.setParametro("@idCarrito", idCarrito);

                datos.ejecutarLectura();

                carrito.CarritoCursos = new List<CarritoCurso>();

                while (datos.Lector.Read())
                {
                    CarritoCurso cursoaux = new CarritoCurso();

                    cursoaux.IdCarrito = idCarrito;
                    cursoaux.IdCurso = (int)datos.Lector["IdCurso"];
                    cursoaux.Nombre = datos.Lector["Nombre"].ToString();
                    cursoaux.Precio = (decimal)datos.Lector["PrecioUnitario"];

                    carrito.CarritoCursos.Add(cursoaux);
                }


                return carrito;

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

        // Metodo que devuelve el carrito (con el detalle) mediante el idCarrito
        public Carrito getCarritoPorIdCarrito(int idCarrito)
        {
            Carrito carrito = new Carrito();
            CarritoCurso curso = new CarritoCurso();
            try
            {
                datos.setConsulta(@"SELECT IdCarrito, IdUsuario, FechaCreacion, UltimaModificacion, EstadoCarrito 
                                    FROM Carrito 
                                    WHERE IdCarrito = @idCarrito AND EstadoCarrito = 0");
                datos.setParametro("@idCarrito", idCarrito);

                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    carrito.IdCarrito = (int)datos.Lector["IdCarrito"];
                    carrito.IdUsuario = (int)datos.Lector["IdUsuario"];
                    carrito.FechaCreacion = (DateTime)datos.Lector["FechaCreacion"];
                    carrito.UltimaModificacion = (DateTime)datos.Lector["UltimaModificacion"];
                    carrito.Estado = (EstadoCarrito)datos.Lector["EstadoCarrito"];

                }
                datos.cerrarConexion();

                datos.setConsulta("SELECT IdCarrito, IdCurso, PrecioUnitario FROM CarritoCurso WHERE IdCarrito = @idCarrito");
                datos.setParametro("@idCarrito", idCarrito);

                datos.ejecutarLectura();

                carrito.CarritoCursos = new List<CarritoCurso>();

                while (datos.Lector.Read())
                {
                    CarritoCurso cursoaux = new CarritoCurso();

                    cursoaux.IdCarrito = idCarrito;
                    cursoaux.IdCurso = (int)datos.Lector["IdCurso"];
                    cursoaux.Precio = (decimal)datos.Lector["PrecioUnitario"];

                    carrito.CarritoCursos.Add(cursoaux);
                }

                return carrito;

            }
            catch (Exception ex)
            {

                throw new Exception("Error al cargar el carrito desde la BD",ex);
            }
            finally
            {
                datos.cerrarConexion();
            }

        }


        public void CrearCarrito(int idUsuario, int idCurso, decimal monto)
        {
            int idCarrito = 0;

            try
            {
                datos.setConsulta("INSERT INTO Carrito(IdUsuario, FechaCreacion, UltimaModificacion) VALUES(@idUsuario, GETDATE(), GETDATE()) SELECT SCOPE_IDENTITY();;");
                datos.setParametro("@idUsuario", idUsuario);

                datos.ejecutarLectura();
                if (datos.Lector.Read())
                    idCarrito = Convert.ToInt32(datos.Lector[0]);

                datos.cerrarConexion();

                datos.setConsulta("INSERT INTO CarritoCurso VALUES (@idCarrito , @idCurso, @monto)");
                datos.setParametro("@idCarrito", idCarrito);
                datos.setParametro("@idCurso", idCurso);
                datos.setParametro("@monto", monto);

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

        public void AgregrarCursoCarrito(int idCarrito, int idCurso, decimal monto)
        {
            try
            {

                datos.setConsulta("INSERT INTO CarritoCurso VALUES (@idCarrito , @idCurso, @monto)");
                datos.setParametro("@idCarrito", idCarrito);
                datos.setParametro("@idCurso", idCurso);
                datos.setParametro("@monto", monto);

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

        public void EliminarCursoCarrito(int idCurso)
        {
            try
            {
                datos.setConsulta("DELETE FROM CarritoCurso WHERE IdCurso = @idCurso;");
                datos.setParametro("@idCurso", idCurso);

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

        public List<CursoDTO> ObtenerCursosCompletosDeUsuario(UsuarioAutenticado usuario)
        {
            int id = usuario.IdUsuario;
            bool isAdmin = usuario.Rol == Rol.Administrador;

            AccesoDatos accesoCursos = new AccesoDatos();
            try
            {
                string consulta;
                if (isAdmin)
                {
                    consulta = @"
                SELECT 
                    c.IdCurso,
                    c.Titulo
                FROM Curso c
            ";
                }
                else
                {
                    consulta = @"
                SELECT 
                    c.IdCurso,
                    c.Titulo
                FROM Curso c
                INNER JOIN DetalleCompra dc ON c.IdCurso = dc.IdCurso 
                INNER JOIN Compra co ON dc.IdCompra = co.IdCompra
                WHERE co.IdUsuario = @idUsuario AND c.Estado = 1
            ";
                }

                accesoCursos.setConsulta(consulta);
                accesoCursos.limpiarParametros();

                if (!isAdmin)
                {
                    accesoCursos.setParametro("@idUsuario", id);
                }

                accesoCursos.ejecutarLectura();

                List<CursoDTO> cursos = new List<CursoDTO>();
                ModuloServicio moduloServicio = new ModuloServicio();

                while (accesoCursos.Lector.Read())
                {
                    CursoDTO curso = new CursoDTO
                    {
                        IdCurso = (int)accesoCursos.Lector["IdCurso"],
                        NombreCurso = accesoCursos.Lector["Titulo"].ToString(),
                        UrlCurso = $"Curso.aspx?id={(int)accesoCursos.Lector["IdCurso"]}"
                    };
                    curso.Modulos = moduloServicio.ObtenerModulosDTOPorIdCurso(curso.IdCurso);
                    cursos.Add(curso);
                }
                return cursos;
            }
            catch (Exception ex)
            {
                throw new Exception("Error al cargar los cursos:", ex);
            }
            finally
            {
                accesoCursos.cerrarConexion();
            }
        }

        public static bool EstaCompletoCurso(Curso curso)
        {
            if (curso.Modulos == null || curso.Modulos.Count == 0)
                return false;

            return curso.Modulos.All(m => m.Lecciones != null && m.Lecciones.All(l => l.Completado));
        }


        public void AsignarIdOperacionCarrito(Carrito carrito)
        {
            AccesoDatos accesoDatos = new AccesoDatos();
            try
            {
                accesoDatos.limpiarParametros();
                accesoDatos.setConsulta("UPDATE Carrito SET IDOperacion = @idOperacion WHERE IdCarrito = @idCarrito");
                accesoDatos.setParametro("@idOperacion", carrito.IDOperacion);
                accesoDatos.setParametro("@idCarrito", carrito.IdCarrito);
                accesoDatos.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw new Exception("Error al actualizar la compra:", ex);
            }
            finally
            {
                accesoDatos.cerrarConexion();
            }
        }

        public Carrito getCarritoPorIdOperacion(string iDOperacion)
        {
            Carrito carrito = new Carrito();
            try
            {
                datos.setConsulta(@"SELECT IdCarrito, IdUsuario, FechaCreacion, UltimaModificacion, EstadoCarrito 
                                    FROM Carrito 
                                    WHERE IDOperacion = @idOperacion AND EstadoCarrito = 0");
                datos.setParametro("@idOperacion", iDOperacion);
                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    carrito.IdCarrito = (int)datos.Lector["IdCarrito"];
                    carrito.IdUsuario = (int)datos.Lector["IdUsuario"];
                    carrito.FechaCreacion = (DateTime)datos.Lector["FechaCreacion"];
                    carrito.UltimaModificacion = (DateTime)datos.Lector["UltimaModificacion"];
                    carrito.Estado = (EstadoCarrito)datos.Lector["EstadoCarrito"];

                }
                else
                {
                    return null;
                }

                datos.cerrarConexion();

                datos.limpiarParametros();
                datos.setConsulta("SELECT IdCarrito, IdCurso, PrecioUnitario FROM CarritoCurso WHERE IdCarrito = @idCarrito");
                datos.setParametro("@idCarrito", carrito.IdCarrito);
                datos.ejecutarLectura();

                carrito.CarritoCursos = new List<CarritoCurso>();

                while (datos.Lector.Read())
                {
                    carrito.CarritoCursos.Add(new CarritoCurso
                    {
                        IdCarrito = carrito.IdCarrito,
                        IdCurso = (int)datos.Lector["IdCurso"],
                        Precio = (decimal)datos.Lector["PrecioUnitario"]
                    });
                }

                return carrito;

            }
            catch (Exception ex)
            {

                throw new Exception("Error al cargar el carrito desde la BD", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
}

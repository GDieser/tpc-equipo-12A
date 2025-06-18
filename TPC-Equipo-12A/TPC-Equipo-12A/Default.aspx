<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="TPC_Equipo_12A.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .carousel-bg {
            height: 90vh;
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
        }

        .carousel-caption {
            background: rgba(0, 0, 0, 0.5);
            padding: 2rem;
            border-radius: 1rem;
        }
    </style>
    <style>
        .card-img-top {
            height: 250px;
            object-fit: cover;
        }
    </style>

    <style>
        .division {
            border: none;
            border-top: 1px solid #80808058;
            margin: 3rem 0;
        }
    </style>

    <script>
        function onSubmit(token) {
            document.getElementById("demo-form").submit();
        }
    </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <section class="m-0 p-0">
        <div id="carouselHome" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-inner">

                <div class="carousel-item active">
                    <div class="d-block w-100 carousel-bg" style="background-image: url('Images/bg3.jpg');">
                        <div class="carousel-caption d-none d-md-block text-start pe-5">
                            <h1 class="display-4 text-light fw-bold">Bienvenido a <span class="text-info">MisCursos.com</span></h1>
                            <p class="lead text-white">Formación online de calidad para llevar tu conocimiento al siguiente nivel.</p>
                            <a href="ListaCursos.aspx" class="btn btn-success btn-lg mt-3">Mirá nuestros cursos</a>
                        </div>
                    </div>
                </div>

                <div class="carousel-item">
                    <div class="d-block w-100 carousel-bg" style="background-image: url('Images/bg2.jpg');">
                        <div class="carousel-caption d-none d-md-block text-start pe-5">
                            <h1 class="display-4 text-light fw-bold">Aprendé desde casa</h1>
                            <p class="lead text-white">A tu ritmo, con los mejores instructores y material actualizados.</p>
                            <a href="ListaCursos.aspx" class="btn btn-success btn-lg mt-3">Explorar</a>
                        </div>
                    </div>
                </div>

            </div>

            <button class="carousel-control-prev" type="button" data-bs-target="#carouselHome" data-bs-slide="prev">
                <span class="carousel-control-prev-icon"></span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselHome" data-bs-slide="next">
                <span class="carousel-control-next-icon"></span>
            </button>
        </div>
    </section>

    <div class="container">

        <!-- Seccion iconos -->
        <section class="division">
            <br />
            <div>
                <h2 class="text-center">¿Por qué elegir MisCursos.com?</h2>
                <br />
                <div class="row row-cols-1 row-cols-md-4 g-4 text-center">
                    <div class="col">
                        <div class="card bg-black" style="width: 18rem;">
                            <div class="card-body text-white">
                                <img src='<%= ResolveUrl("~/Icons/Icono5.png") %>' alt="Alternate Text" />
                                <h6 class="card-subtitle mb-2 text-body-secondary-white">Profesionales</h6>
                                <p class="card-text">Los mejores instructores especializados en su rubro.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="card bg-black" style="width: 18rem;">
                            <div class="card-body text-white">
                                <img src='<%= ResolveUrl("~/Icons/Icono6.png") %>' alt="Alternate Text" />
                                <h6 class="card-subtitle mb-2 text-body-secondary-white">Actualizados</h6>
                                <p class="card-text">Estamos constantemente actualizando nuestro contenido.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="card bg-black" style="width: 18rem;">
                            <div class="card-body text-white">
                                <img src='<%= ResolveUrl("~/Icons/Icono7.png") %>' alt="Alternate Text" />
                                <h6 class="card-subtitle mb-2 text-body-secondary-white">Skills</h6>
                                <p class="card-text">El contenido te brindara las herramientas para el desarrollo de habilidades.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="card bg-black" style="width: 18rem;">
                            <div class="card-body text-white">
                                <img src='<%= ResolveUrl("~/Icons/Icono8.png") %>' alt="Alternate Text" />
                                <h6 class="card-subtitle mb-2 text-body-secondary-white">Free</h6>
                                <p class="card-text">Contamos además con contenido de calidad gratuito.</p>
                            </div>
                        </div>
                    </div>
                </div>
                <br />
                <h2 class="text-center">¿Qué ofrecemos?</h2>
                <br />
                <div class="row row-cols-1 row-cols-md-4 g-4 text-center">
                    <div class="col">
                        <div class="card bg-black" style="width: 18rem;">
                            <div class="card-body text-white">
                                <img src='<%= ResolveUrl("~/Icons/Icono1.png") %>' alt="Alternate Text" />
                                <h6 class="card-subtitle mb-2 text-body-secondary-white">Cursos</h6>
                                <p class="card-text">La mejor capacitación otorgado por profesionales en el rubro.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="card bg-black" style="width: 18rem;">
                            <div class="card-body text-white">
                                <img src='<%= ResolveUrl("~/Icons/Icono2.png") %>' alt="Alternate Text" />
                                <h6 class="card-subtitle mb-2 text-body-secondary-white">Blogs</h6>
                                <p class="card-text">Blogs con novedades y promociones.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="card bg-black" style="width: 18rem;">
                            <div class="card-body text-white">
                                <img src='<%= ResolveUrl("~/Icons/Icono3.png") %>' alt="Alternate Text" />
                                <h6 class="card-subtitle mb-2 text-body-secondary-white">Certificados</h6>
                                <p class="card-text">Otorgamos certificados para poder presentar en tus redes.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="card bg-black" style="width: 18rem;">
                            <div class="card-body text-white">
                                <img src='<%= ResolveUrl("~/Icons/Icono4.png") %>' alt="Alternate Text" />
                                <h6 class="card-subtitle mb-2 text-body-secondary-white">Soporte</h6>
                                <p class="card-text">Contas con soporte constante de nuestra parte.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Top cursos, o algo asi -->
        <section class="division text-center">
            <br />
            <div>
                <h2>¡Ultimos cursos agregados!</h2>
                <br />
                <div>

                    <div class="row row-cols-1 row-cols-md-3 g-4">
                        <asp:Repeater ID="rptCursos" runat="server">
                            <ItemTemplate>


                                <div class="col">
                                    <div class="card h-100 bg-dark text-light border-secondary shadow-sm rounded-4 d-flex flex-column">

                                        <img src='<%# Eval("ImagenPortada.Url") %>' class="card-img-top img-fluid object-fit-cover rounded-top" style="height: 220px;" alt="Imagen del curso" />

                                        <div class="card-body text-center flex-grow-1">
                                            <h4 class="card-title fw-semibold mb-1"><%# Eval("Titulo") %></h4>
                                        </div>
                                        <div class="card-body text-center flex-grow-1">
                                            <p class="card-text text-white"><%# Eval("Resumen") %></p>
                                        </div>

                                        <div class="card-footer bg-transparent text-center border-0 mt-auto">
                                            <a href='DescripcionCurso.aspx?id=<%# Eval("IdCurso") %>'
                                                class="btn btn-outline-info btn-sm rounded-pill">Ver más
                                            </a>
                                        </div>
                                    </div>
                                </div>

                            </ItemTemplate>
                        </asp:Repeater>

                    </div>

                </div>
            </div>
        </section>

        <!-- FAQs -->
        <section class="division text-center">
            <br />
            <div>
                <div class="row">
                    <h2>Preguntas frecuentes</h2>
                </div>
                <br />

                <asp:Repeater ID="rpdFaqs" runat="server">
                    <ItemTemplate>
                        <div class="accordion accordion-flush" id='accordionFlushExample_<%# Eval("IdFaq") %>'>
                            <div class="accordion-item bg-dark">
                                <h2 class="accordion-header">
                                    <button class="btn btn-dark accordion-button collapsed bg-dark text-white" type="button" data-bs-toggle="collapse" data-bs-target='#flush-collapse_<%# Eval("IdFaq") %>' aria-expanded="false" aria-controls='flush-collapse_<%# Eval("IdFaq") %>'>
                                        ▾ <%# Eval("Pregunta") %>
                                    </button>
                                </h2>
                                <div id='flush-collapse_<%# Eval("IdFaq") %>' class="accordion-collapse collapse" data-bs-parent='#accordionFlushExample_<%# Eval("IdFaq") %>'>
                                    <div class="accordion-body text-white">
                                        <%# Eval("Respuesta") %>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </ItemTemplate>
                </asp:Repeater>
                <br />
                <%if (usuario != null && usuario.Rol == Dominio.Rol.Administrador)
                    {  %>

                <!-- Modal sirve para vent flotantes... -->

                <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#exampleModal">
                    Agregar FAQ
                </button>
                <a href="ListaFaqs.aspx" class="btn btn-warning">Administrar</a>


                <div class="modal fade bg-dark p-2 text-dark bg-opacity-50" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content bg-dark p-2 text-white">
                            <div class="modal-header">

                                <h1 class="modal-title fs-5" id="exampleModalLabel">Agregar nueva FAQ</h1>

                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">

                                <div class="mb-3">
                                    <label for="txtPregunta" class="form-label fw-bold">Pregunta:</label>
                                    <asp:TextBox ID="txtPregunta" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control" />
                                    <asp:RequiredFieldValidator ID="rfvPregunta" runat="server"
                                        ControlToValidate="txtPregunta"
                                        ErrorMessage="La pregunta es obligatoria."
                                        Display="Dynamic" ForeColor="Red" CssClass="small" />
                                </div>

                                <div class="mb-3">
                                    <label for="txtRespuesta" class="form-label fw-bold">Respuesta:</label>
                                    <asp:TextBox ID="txtRespuesta" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control" />
                                    <asp:RequiredFieldValidator ID="rfvRespuesta" runat="server"
                                        ControlToValidate="txtPregunta"
                                        ErrorMessage="La respuesta es obligatoria."
                                        Display="Dynamic" ForeColor="Red" CssClass="small" />
                                </div>
                            </div>
                            <div class="modal-footer">
                                <asp:Button Text="Aceptar" CssClass="btn btn-success mt-4" ID="btnAgregarFaq" OnClick="btnAgregarFaq_Click" runat="server" />

                            </div>
                        </div>
                    </div>
                </div>

                <%} %>
            </div>
        </section>

        <asp:Label Text="" ID="lblError" runat="server" />
        <!-- contacto, podriamos poner para que mande mail -->
        <section class="division">

            <br />
            <h2 class="text-center">Redes y contacto</h2>
            <br />

            <div class="row row-cols-1 row-cols ">

                <div class="text-center">
                    <a href="http://instagram.com/">
                        <img style="margin-right: 20px;" src='<%= ResolveUrl("~/Icons/insta.png") %>' alt="Instagram" /></a>
                    <a href="http://twitter.com">
                        <img style="margin-right: 20px;" src='<%= ResolveUrl("~/Icons/twitter.png") %>' alt="Twitter" /></a>
                    <a href="http://github.com">
                        <img style="margin-right: 20px;" src='<%= ResolveUrl("~/Icons/git.png") %>' alt="GitHub" /></a>
                    <a href="http://google.com">
                        <img style="margin-right: 20px;" src='<%= ResolveUrl("~/Icons/mail.png") %>' alt="Mail" /></a>
                    <a href="http://linkedin.com">
                        <img style="margin-right: 20px;" src='<%= ResolveUrl("~/Icons/lind.png") %>' alt="Linkedin" /></a>
                </div>

            </div>

        </section>
    </div>
</asp:Content>

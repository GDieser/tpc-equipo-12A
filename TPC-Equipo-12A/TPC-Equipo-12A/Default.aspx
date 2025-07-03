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

        .object-fit-cover {
            object-fit: cover;
        }

        @media (max-width: 576px) {
            .carousel-caption {
                bottom: 10% !important;
            }

                .carousel-caption h1 {
                    font-size: 1.8rem !important;
                }

                .carousel-caption p {
                    font-size: 0.9rem !important;
                    margin-bottom: 0.5rem;
                }
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
                    <div class="position-relative d-block w-100" style="height: 100vh; min-height: 500px; max-height: 860px; overflow: hidden;">

                        <video autoplay muted loop playsinline class="position-absolute top-0 start-0 object-fit-cover w-100 h-100">
                            <source src="Images/IntroVid1.mp4" type="video/mp4" />
                            Tu navegador no soporta video HTML5.
                        </video>

                        <div class="carousel-caption d-none d-md-block text-start pe-5">
                            <h1 class="display-4 text-light fw-semibold">Bienvenido a <span class="text-info">MisCursos.com</span>
                            </h1>
                            <p class="fs-5 text-white-50 mb-4">
                                Formación online de calidad para llevar tu conocimiento al siguiente nivel.
                            </p>
                            <a href="ListaCursos.aspx" class="btn btn-outline-info btn-lg px-4 shadow-sm">Explorar Cursos
                            </a>
                        </div>

                        <div class="carousel-caption d-md-none text-center px-3" style="bottom: 16%;">
                            <h2 class="text-light fw-semibold mb-2">Bienvenido a <span class="text-info">MisCursos.com</span>
                            </h2>
                            <p class="text-white-50 small mb-3">
                                Formación online de calidad para llevar tu conocimiento al siguiente nivel.
                            </p>
                            <a href="ListaCursos.aspx" class="btn btn-outline-info btn-sm px-3">Ver Cursos
                            </a>
                        </div>

                        <div class="position-absolute top-0 start-0 w-100 h-100 bg-dark" style="opacity: 0.1; pointer-events: none;"></div>
                    </div>
                </div>

                <div class="carousel-item">
                    <div class="d-block w-100 carousel-bg" style="background-image: url('Images/bg4.png'); background-size: cover; background-position: center;">
                        <div class="carousel-caption d-none d-md-block text-start pe-5" >
                            <h1 class="display-4 text-light fw-semibold">Aprendé desde casa</h1>
                            <p class="fs-5 text-white-50 mb-4">A tu ritmo, con los mejores instructores y material actualizado.</p>
                            <a href="ListaCursos.aspx" class="btn btn-outline-info btn-lg px-4 shadow-sm">Explorar</a>
                        </div>

                        <div class="carousel-caption d-md-none text-center px-3" style="bottom: 16%;">
                            <h2 class="text-light fw-semibold mb-2">Aprendé desde casa</h2>
                            <p class="text-white-50 small mb-3">A tu ritmo, con los mejores instructores y material actualizado.</p>
                            <a href="ListaCursos.aspx" class="btn btn-outline-light btn-sm px-3">Explorar</a>
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
                <h3 class="fw-bold text-info text-center mb-4">¿Por qué elegir MisCursos.com?</h3>
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
                <h3 class="fw-bold text-info text-center mb-4">¿Qué ofrecemos?</h3>
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
                <h3 class="fw-bold text-info mb-4">¡Últimos cursos agregados!</h3>
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
                                            <a href='DescripcionCurso.aspx?id=<%# Eval("IdCurso") %>' class="btn btn-outline-info btn-sm rounded-3">Ver más </a>

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
                    <h3 class="fw-bold text-info mb-4"><i class="bi bi-patch-question"></i>Preguntas frecuentes</h3>
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
                <a href="ListaFaqs.aspx" class="btn btn-warning">Administrar</a>
                <%} %>
            </div>
        </section>

        <asp:Label Text="" ID="lblError" runat="server" />
        <!-- contacto, podriamos poner para que mande mail -->

        <section class="text-white py-5">
            <div class="container text-center">
                <h2 class="fw-bold text-info mb-4"><i class="bi bi-envelope-check"></i>¡Contactanos!</h2>
                <h4 class="mb-3">¿Tenés dudas, sugerencias o querés saber más? Estamos para ayudarte.</h4>

                <h6 class="mb-4">Podés encontrarnos en nuestras redes sociales:</h6>
                <br />
                <div class="row justify-content-center text-center">
                    <div class="col-6 col-sm-2 mb-4">
                        <a href="http://instagram.com/" target="_blank" class="text-white text-decoration-none">
                            <img src='<%= ResolveUrl("~/Icons/insta.png") %>' alt="Instagram" class="img-fluid mb-2" style="height: 40px;" />
                            <div class="small">Instagram</div>
                        </a>
                    </div>
                    <div class="col-6 col-sm-2 mb-4">
                        <a href="http://twitter.com" target="_blank" class="text-white text-decoration-none">
                            <img src='<%= ResolveUrl("~/Icons/twitter.png") %>' alt="Twitter" class="img-fluid mb-2" style="height: 40px;" />
                            <div class="small">Twitter</div>
                        </a>
                    </div>
                    <div class="col-6 col-sm-2 mb-4">
                        <a href="http://github.com" target="_blank" class="text-white text-decoration-none">
                            <img src='<%= ResolveUrl("~/Icons/git.png") %>' alt="GitHub" class="img-fluid mb-2" style="height: 40px;" />
                            <div class="small">GitHub</div>
                        </a>
                    </div>
                    <div class="col-6 col-sm-2 mb-4">
                        <a href="mailto:soporte@miscursos.com" target="_blank" class="text-white text-decoration-none">
                            <img src='<%= ResolveUrl("~/Icons/mail.png") %>' alt="Mail" class="img-fluid mb-2" style="height: 40px;" />
                            <div class="small">Email</div>
                        </a>
                    </div>
                    <div class="col-6 col-sm-2 mb-4">
                        <a href="http://linkedin.com" target="_blank" class="text-white text-decoration-none">
                            <img src='<%= ResolveUrl("~/Icons/lind.png") %>' alt="Linkedin" class="img-fluid mb-2" style="height: 40px;" />
                            <div class="small">LinkedIn</div>
                        </a>
                    </div>
                </div>

                <p class="mt-4 small text-secondary">Respondemos en menos de 24 hs. ¡Gracias por ser parte de nuestra comunidad! 🙌</p>
                <br />
                <p class="mt-4 small">
                    ¿Aun no sos parte de MisCursos.com?  
                    <a href="https://localhost:44341/Registro.aspx" class="text-info fw-bold text-decoration-none">¡Registrate, es gratis!</a>
                </p>

            </div>

        </section>
    </div>
</asp:Content>

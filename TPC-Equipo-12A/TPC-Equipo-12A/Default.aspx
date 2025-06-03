<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="TPC_Equipo_12A.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .carousel-inner img {
            height: 500px;
            object-fit: cover;
        }
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div id="carouselExampleInterval" class="carousel slide" data-bs-ride="carousel">

            <div class="carousel-inner">
                <div class="carousel-item active" data-bs-interval="10000">
                    <img src="https://www.aprender21.com/images/colaboradores/sql.jpeg" class="d-block w-100" alt="...">
                    <div class="card carousel-caption d-none d-md-block bg-dark bg-opacity-75 border-secondary">
                        <h5>Curso SQL</h5>
                        <p>Aprende todo lo necesario del mundo de las base de datos.</p>
                        <a href="Cursos.aspx" class="btn btn-primary">Ver más</a>
                    </div>
                </div>

                <div class="carousel-item" data-bs-interval="2000">
                    <img src="https://facialix.com/wp-content/uploads/2023/03/git-github-cero-facialix.jpg" class="d-block w-100" alt="...">
                    <div class="card carousel-caption d-none d-md-block bg-dark bg-opacity-75 border-secondary">
                        <h5>Git y GitHub</h5>
                        <p>Lo ultimo en las herramientas de versionado.</p>
                        <a href="Cursos.aspx" class="btn btn-primary">Ver más</a>
                    </div>
                </div>

                <div class="carousel-item">
                    <img src="https://cdn.openwebinars.net/media/fbads-unity.png" class="d-block w-100" alt="...">
                    <div class="card carousel-caption d-none d-md-block bg-dark bg-opacity-75 border-secondary">
                        <h5 class="card-title">Unity 2D</h5>
                        <p class="card-text">Un introduccion al mundo del diseño y programación de videojuegos.</p>
                        <a href="Cursos.aspx" class="btn btn-primary">Ver más</a>
                    </div>
                </div>

            </div>

            <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleInterval" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleInterval" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
            <br />
        </div>
    <div class="container" >
        <h5>Bienvenidos a </h5>
        <h1 class="mb-3">MisCursos.com</h1>
        <p></p>
        <a href="Cursos.aspx" type="button" class="btn btn-info">Mirá nuestros cursos</a>
    </div>
    <br />
    <div>
        <h3>Sobre Nosotros</h3>
    </div>
    <br />
    <div>
        <h3>Top Cursos mejor valorados</h3>
    </div>
    <br />
    <div>
        <h3>Contactanos</h3>
    </div>
</asp:Content>

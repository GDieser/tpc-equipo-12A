<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Cursos.aspx.cs" Inherits="TPC_Equipo_12A.Cursos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
  .curso-card {
    width: 75%;
    height: 250px;
    background-color: #212529; /* bg-dark */
    border: 1px solid #0d6efd; /* border-primary */
    color: white;
    border-radius: .5rem;
    display: flex;
    margin: 1rem auto;
  }

  .curso-img {
    width: 25%;
    border-right: 1px solid #0d6efd;
    height: 100%;
    object-fit: cover;
    border-top-left-radius: .5rem;
    border-bottom-left-radius: .5rem;
  }

  .curso-contenido {
    width: 50%;
    padding: 1.5rem;
    display: flex;
    flex-direction: column;
    justify-content: center;
  }

  .curso-acciones {
    width: 25%;
    border-left: 1px solid #0d6efd;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    padding-left: 1rem;
    padding-right: 1rem;
  }

  .curso-acciones button {
    margin-bottom: 2rem;
  }

  .curso-acciones button:last-child {
    margin-bottom: 0;
  }
</style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

  <!-- CURSO 1 -->
  <div class="curso-card">
    <img src="https://www.aprender21.com/images/colaboradores/sql.jpeg" alt="Curso SQL" class="curso-img">
    <div class="curso-contenido">
      <h5>Curso SQL</h5>
      <p>Aprende todo lo necesario del mundo de las base de datos.</p>
    </div>
    <div class="curso-acciones">
      <a href="Curso.aspx" class="btn btn-primary">Ver más</a>
      <button class="btn btn-info">Comprar</button>
    </div>
  </div>

  <!-- CURSO 2 -->
  <div class="curso-card">
    <img src="https://facialix.com/wp-content/uploads/2023/03/git-github-cero-facialix.jpg" alt="Git y GitHub" class="curso-img">
    <div class="curso-contenido">
      <h5>Git y GitHub</h5>
      <p>Lo último en las herramientas de versionado.</p>
    </div>
    <div class="curso-acciones">
      <a href="Curso.aspx" class="btn btn-primary">Ver más</a>
      <button class="btn btn-info">Comprar</button>
    </div>
  </div>

  <!-- CURSO 3 -->
  <div class="curso-card">
    <img src="https://cdn.openwebinars.net/media/fbads-unity.png" alt="Unity 2D" class="curso-img">
    <div class="curso-contenido">
      <h5>Unity 2D</h5>
      <p>Una introducción al mundo del diseño y programación de videojuegos.</p>
    </div>
    <div class="curso-acciones">
      <a href="Curso.aspx" class="btn btn-primary">Ver más</a>
      <button class="btn btn-info">Comprar</button>
    </div>
  </div>

  <!-- CURSO 4 -->
  <div class="curso-card">
    <img src="https://www.madariaga.gob.ar/fotos/madariaga/noticias/cursos2.png?A" alt="Fundamentos" class="curso-img">
    <div class="curso-contenido">
      <h5>Fundamento de la Programación</h5>
      <p>Aprendé los fundamentos de la programación desde cero.</p>
    </div>
    <div class="curso-acciones">
      <a href="Curso.aspx" class="btn btn-primary">Ver más</a>
      <button class="btn btn-info">Comprar</button>
    </div>
  </div>

  <!-- CURSO 5 -->
  <div class="curso-card">
    <img src="https://www.madariaga.gob.ar/fotos/madariaga/noticias/cursos2.png?A" alt="Curso 5" class="curso-img">
    <div class="curso-contenido">
      <h5>Curso 5</h5>
      <p>5</p>
    </div>
    <div class="curso-acciones">
      <a href="Curso.aspx" class="btn btn-primary">Ver más</a>
      <button class="btn btn-info">Comprar</button>
    </div>
  </div>

  <!-- CURSO 6 -->
  <div class="curso-card">
    <img src="https://www.madariaga.gob.ar/fotos/madariaga/noticias/cursos2.png?A" alt="Curso 6" class="curso-img">
    <div class="curso-contenido">
      <h5>Curso 6</h5>
      <p>6</p>
    </div>
    <div class="curso-acciones">
      <a href="Curso.aspx" class="btn btn-primary">Ver más</a>
      <button class="btn btn-info">Comprar</button>
    </div>
  </div>

</asp:Content>

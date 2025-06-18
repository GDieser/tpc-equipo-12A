<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Novedades.aspx.cs" Inherits="TPC_Equipo_12A.Novedades" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container">

        <div class="text-white ">
            <hr class="text-secondary" />
            <h1 class="display-4 fw-bold text-info mb-4">📰 Novedades en MisCursos.com</h1>

            <p class="lead">
                ¡Bienvenid@ a nuestro espacio de novedades! Acá vas a encontrar:
            </p>
            <ul class="list-unstyled fs-5">
                <li>📢 Noticias y actualizaciones del sitio</li>
                <li>🎓 Información sobre nuevos cursos y lanzamientos</li>
                <li>🚀 Novedades del mundo tech y herramientas útiles</li>
                <li>📚 Contenido gratuito y complementario</li>
            </ul>

            <p class="mt-4">
                Queremos brindarte contenido que potencie tu desarrollo personal y profesional. 
                Esta sección está pensada para vos: para informarte, inspirarte y acompañarte en tu camino de aprendizaje continuo.
            </p>

            <p class="fst-italic">
                ¿Tenés alguna idea, sugerencia o tema que te gustaría que tratemos? ¡Dejanos tu comentario o escribinos! El equipo de <strong>MisCursos.com</strong> está para vos 💬✨
            </p>

            <asp:Button Text="Agregar nueva publicación" ID="btnAgregar" OnClick="btnAgregar_Click" CssClass="btn btn-outline-info btn-lg mt-4" runat="server" />
        </div>

        <hr />

        <div class="dropdown mb-3 mt-4 text-end">

            <asp:DropDownList ID="ddlFiltro" CssClass="btn btn-secondary dropdown-toggle" Width="150px" runat="server">
            </asp:DropDownList>

            <asp:Button Text="Filtrar" CssClass="btn btn-info" ID="btnFiltrar" OnClick="btnFiltrar_Click" runat="server" />

        </div>

        <div class="row row-cols-1 row-cols-md-4 g-4 text-center">

            <asp:Repeater ID="rptNovedades" runat="server">
                <ItemTemplate>

                    <div class="col">
                        <div class="card bg-black" style="width: 20rem;">
                            <div class="card-body text-white">

                                <div class="card-header text-center">
                                    <img width="250px" height="150px" src='<%# Eval("UrlImagen") %>' alt="Alternate Text" />
                                </div>
                                <br />
                                <h6 class="card-subtitle mb-2 text-body-secondary-white"><%# Eval("Titulo") %></h6>

                                <p class="card-text"><%# Eval("Resumen") %></p>

                                <a href="DetalleNovedad.aspx?IdNovedad=<%# Eval("IdPublicacion") %>" class="btn btn-outline-info">Ver más.</a>

                            </div>
                        </div>
                    </div>

                </ItemTemplate>
            </asp:Repeater>

        </div>
    </div>

</asp:Content>

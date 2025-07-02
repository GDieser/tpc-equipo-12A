<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Novedades.aspx.cs" Inherits="TPC_Equipo_12A.Novedades" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        .card-hover:hover {
            transform: scale(1.02);
            transition: transform 0.2s ease-in-out;
            cursor: pointer;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <hr class="text-secondary" />
    <div class="container">
        <div class="text-white ">

            <div class="mb-5">
                <h1 class="display-4 fw-bold text-info mb-4">📰 Novedades en MisCursos.com</h1>

                <p class="lead text-white-50">
                    ¡Bienvenid@ a nuestro espacio de novedades! Acá vas a encontrar:
                </p>
            </div>
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

            <p class="fst-italic text-white-50">
                ¿Tenés alguna idea, sugerencia o tema que te gustaría que tratemos? ¡Dejanos tu comentario o escribinos! El equipo de <strong>MisCursos.com</strong> está para vos 💬✨
            </p>

            <asp:Button Text="Agregar nueva publicación" ID="btnAgregar" OnClick="btnAgregar_Click" CssClass="btn btn-outline-info btn-lg mt-4" runat="server" />
        </div>

        <hr />

        <div class="row align-items-center mb-3">


            <div class="col-md-6 d-flex align-items-center">
                <asp:Button ID="btnHorizontal" runat="server" Text="▤" OnClick="btnHorizontal_Click" CssClass="btn btn-outline-light btn-lg me-2" />
                <asp:Button ID="btnCard" runat="server" Text="⊞" OnClick="btnCard_Click" CssClass="btn btn-outline-light btn-lg" />
            </div>


            <div class="col-md-6 text-end">
                <div class="d-inline-flex align-items-center gap-2">
                    <asp:DropDownList ID="ddlFiltrar" CssClass="btn btn-secondary dropdown-toggle" runat="server" />
                    <asp:Button Text="Filtrar" CssClass="btn btn-info" OnClick="btnFiltrarNovedades_Click" ID="btnFiltrarNovedades" runat="server" />

                    <asp:DropDownList ID="ddlFiltro" runat="server" CssClass="btn btn-secondary dropdown-toggle" Width="150px"></asp:DropDownList>
                    <asp:Button Text="Filtrar" CssClass="btn btn-info btn-md" ID="btnFiltrar" OnClick="btnFiltrar_Click" runat="server" />
                </div>
            </div>

        </div>

        <asp:UpdatePanel ID="pnNovedades" runat="server">
            <ContentTemplate>

                <%if (tipoNovedades)
                    {  %>
                <div class="row row-cols-1">
                    <asp:Repeater ID="rptNovedades" runat="server">
                        <ItemTemplate>
                            <a href='DetalleNovedad.aspx?IdNovedad=<%# Eval("IdPublicacion") %>' class="text-decoration-none text-reset">
                                <div class="shadow-sm bg-black-tertiary rounded">
                                    <div class="card mb-4 bg-dark border border-secondary card-hover">
                                        <div class="row g-0">
                                            <div class="col-md-4">
                                                <img src='<%# Eval("UrlImagen") %>' class="img-fluid rounded-end-5" alt="Alternate Text" />
                                            </div>

                                            <div class="col-md-8">
                                                <div class="card-body text-white">
                                                    <h4 class="card-title"><%# Eval("Titulo") %></h4>
                                                    <hr />
                                                    <p class="card-text"><%# Eval("Resumen") %></p>
                                                    <p class="card-text"><small class="text-body-secondary">Publicado el: <%# Eval("FechaPublicacion") %></small></p>
                                                    <span class="stretched-link"></span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
                <%} %>

                <%if (!tipoNovedades)
                    {  %>
                <div class="row row-cols-1 row-cols-md-4 g-4 text-center">
                    <asp:Repeater ID="rptNovedadesCards" runat="server">
                        <ItemTemplate>

                            <div class="col">
                                <div class="card bg-dark card-hover " style="width: 19rem;">


                                    <div class="card shadow-sm d-inline-block">
                                        <img width="250px" height="150px" style="object-fit: cover;" class="card-img-top text-center" src='<%# Eval("UrlImagen") %>' alt="Alternate Text" />
                                    </div>

                                    <div class="card-body text-white">
                                        <h6 class="card-subtitle mb-2 text-body-secondary-white"><%# Eval("Titulo") %></h6>

                                        <p class="card-text" style="font-size: 0.9rem; max-height: 3.6em; overflow: hidden; text-overflow: ellipsis; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical;"><%# Eval("Resumen") %></p>

                                        <a href="DetalleNovedad.aspx?IdNovedad=<%# Eval("IdPublicacion") %>" class="btn btn-outline-info">Ver más.</a>
                                    </div>
                                </div>
                            </div>

                        </ItemTemplate>
                    </asp:Repeater>
                </div>

                <%} %>
            </ContentTemplate>
        </asp:UpdatePanel>

        <br />

        <div class="d-flex">
            <asp:Button ID="btnAnterior" runat="server" Text="Anterior" OnClick="btnAnterior_Click" CssClass="btn btn-outline-light btn-sm me-2" />
            <asp:Button ID="btnSiguiente" runat="server" Text="Siguiente" OnClick="btnSiguiente_Click" CssClass="btn btn-outline-light btn-sm" />
        </div>

    </div>

    <hr class="text-secondary" />
</asp:Content>

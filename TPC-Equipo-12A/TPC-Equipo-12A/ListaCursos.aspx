<%@ Page Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="ListaCursos.aspx.cs" Inherits="TPC_Equipo_12A.ListaCurso" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-4">

        <div class="mb-5">
            <h1 class="display-4 fw-bold text-info"><i class="bi bi-mortarboard"></i> Nuestros cursos</h1>
            <p class="lead text-white-50">
                Descubrí los últimos cursos disponibles, lanzamientos próximos y todo lo nuevo que tenemos para potenciar tu formación.
            </p>
        </div>

        <div class="row mb-4 align-items-center">
            <div class="col-md-12">
                <h3 class="text-white">¿Qué hay de nuevo?</h3>
                <ul class="list-unstyled fs-5 text-white mt-3">
                    <li><i class="bi bi-chevron-double-right"></i> Nuevos cursos agregados recientemente</li>
                    <li><i class="bi bi-chevron-double-right"></i> Actualizaciones en el contenido de cursos actuales</li>
                    <li><i class="bbi bi-chevron-double-right"></i> Recomendaciones personalizadas y cursos destacados</li>
                </ul>

                <p class="mt-4 text-white">
                    Estamos comprometidos a brindarte una experiencia educativa en constante evolución. Ya seas principiante o avanzado, siempre hay algo nuevo para aprender.
                </p>

                <p class="fst-italic text-white-50">
                    Seguí explorando, sumate a los cursos que más te gusten y no te pierdas ninguna novedad. ¡Tu formación es nuestra prioridad! 💻🚀
                </p>
            </div>
        </div>

        <hr />
        <div class="d-flex justify-content-between">
            <div>
                <asp:DropDownList ID="ddlFiltrar" CssClass="btn btn-secondary dropdown-toggle" runat="server" />
                <asp:Button Text="Filtrar" CssClass="btn btn-info" OnClick="btnFiltrarCursos_Click" ID="btnFiltrarCursos" runat="server" />
            </div>
            <div>
                <asp:DropDownList ID="ddlFiltroCategoria" runat="server" CssClass="btn btn-secondary dropdown-toggle" />
                <asp:Button Text="Filtrar" CssClass="btn btn-info" ID="btnFiltrar" OnClick="btnFiltrar_Click" runat="server" />
            </div>
        </div>
        <br />
        <div class="row row-cols-2 row-cols-sm-3 row-cols-md-4 row-cols-xl-4 g-3">
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

                            <div class="card-footer bg-transparent text-center border-0 mt-auto d-flex justify-content-center align-items-center">
                                <%# 
                                 Convert.ToDecimal(Eval("Precio")) == 0 
                                     ? "<span class='badge bg-success text-white me-2 fs-6'>GRATIS!</span>" 
                                     : $"<span class='badge bg-warning text-dark me-2 fs-6'>$ {Eval("Precio")} (ARS)</span>" 
                                %>
                                <a href='DescripcionCurso.aspx?id=<%# Eval("IdCurso") %>'
                                    class="btn btn-outline-info btn-sm rounded-3">Ver más
                                </a>
                            </div>
                        </div>
                    </div>

                </ItemTemplate>
            </asp:Repeater>
        </div>

    </div>
</asp:Content>

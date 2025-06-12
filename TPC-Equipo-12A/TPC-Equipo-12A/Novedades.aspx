<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Novedades.aspx.cs" Inherits="TPC_Equipo_12A.Novedades" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div>
        <hr />
        <h1>Bienvenido a Novedades MisCursos.com</h1>
        <br />
        <p>
            En esta sección vas a encontrar artículos, promociones, proximos lanzamientos.<br />
            Contenido gratuito que no es part de los cursos pero te podrán ser muy útiles para seguir aprendiendo o formandote.
        </p>
        <br />
        <p>Estamos atentos a cualquier sugerencia que nos hagas! El quipo de MisCursos.com</p>
        <asp:Button Text="Agregar nueva publicación" ID="btnAgregar" OnClick="btnAgregar_Click" CssClass="btn btn-info" runat="server" />
    </div>
    <hr />

    <div class="dropdown mb-3 mt-4 text-end" >

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

                            <a href="DetalleNovedad.aspx?IdNovedad=<%# Eval("IdPublicacion") %>" class="btn btn-info">Ver más.</a>

                        </div>
                    </div>
                </div>

            </ItemTemplate>
        </asp:Repeater>

    </div>





</asp:Content>

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
    </div>
    <hr />

    <div class="row row-cols-1 row-cols-md-4 g-4 text-center">

        <asp:Repeater ID="rptNovedades" runat="server">
            <ItemTemplate>

                <div class="col">
                    <div class="card bg-black" style="width: 18rem;">
                        <div class="card-body text-white">

                            <img width="250px" src='<%# Eval("UrlImagen") %>' alt="Alternate Text" />

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

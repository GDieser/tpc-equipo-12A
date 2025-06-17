<%@ Page Title="" Language="C#" MasterPageFile="~/Aula.Master" AutoEventWireup="true" CodeBehind="MisCursosFavoritos.aspx.cs" Inherits="TPC_Equipo_12A.MisCursosFavoritos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AulaContent" runat="server">

    <h1>Mis Cursos Favoritos</h1>

    <div class="row row-cols-1 row-cols-md-3 g-4">
        <asp:Repeater ID="rptCursos" runat="server">
            <ItemTemplate>
                <div class="col d-flex">
                    <div class="card h-100 border-primary w-100">
                        <img src='<%# Eval("ImagenPortada.Url") %>' class="card-img-top" alt="Imagen del curso">
                        <div class="card-body bg-dark text-white text-center">
                            <h5 class="card-title"><%# Eval("Titulo") %></h5>
                            <p class="card-text"><%# Eval("Resumen") %></p>
                        </div>
                        <div class="card-footer border-primary bg-dark text-center">
                            <a href='DescripcionCurso.aspx?id=<%# Eval("IdCurso") %>' class="btn btn-primary mx-auto">Ver más</a>

                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
</asp:Content>

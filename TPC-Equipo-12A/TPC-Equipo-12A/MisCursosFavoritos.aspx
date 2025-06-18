<%@ Page Title="" Language="C#" MasterPageFile="~/Aula.Master" AutoEventWireup="true" CodeBehind="MisCursosFavoritos.aspx.cs" Inherits="TPC_Equipo_12A.MisCursosFavoritos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AulaContent" runat="server">

    <h1 class="mb-4 text-light text-center">Mis Cursos Favoritos</h1>
    <hr />
    <br />

    <div class="row row-cols-2 row-cols-sm-3 row-cols-md-4 row-cols-xl-5 g-3">
        <asp:Repeater ID="rptCursos" runat="server">
            <ItemTemplate>
                <div class="col">
                    <div class="card h-100 bg-dark text-light border-secondary shadow-sm rounded-4 d-flex flex-column">
                        
                        <img src='<%# Eval("ImagenPortada.Url") %>' class="card-img-top img-fluid object-fit-cover rounded-top" style="height: 180px;" alt="Imagen del curso" />

                        <div class="card-body text-center flex-grow-1">
                            <h6 class="card-title fw-semibold mb-1"><%# Eval("Titulo") %></h6>
                        </div>
                        <div class="card-body text-center flex-grow-1">
                            <p class="card-text text-white"><%# Eval("Resumen") %></p>
                        </div>

                        <div class="card-footer bg-transparent text-center border-0 mt-auto">
                            <a href='DescripcionCurso.aspx?id=<%# Eval("IdCurso") %>' 
                               class="btn btn-outline-light btn-sm rounded-pill">
                                Ver más
                            </a>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>

</asp:Content>

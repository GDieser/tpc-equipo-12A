<%@ Page Title="Mis Cursos" Language="C#" MasterPageFile="~/Aula.master" AutoEventWireup="true" CodeBehind="MisCursos.aspx.cs" Inherits="TPC_Equipo_12A.MisCursos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AulaContent" runat="server">

    <h1>Mis Cursos inscriptos</h1>
    <hr />

    <div class="row justify-content-center">
        <div class="col-lg-8 col-md-10 col-12">
            <div class="row row-cols-1 g-3">
                <asp:Repeater ID="rptMisCursos" runat="server">
                    <ItemTemplate>
                        <a href='ForoCurso.aspx?IdCurso=<%# Eval("IdCurso") %>' class="text-decoration-none text-reset">
                            <div class="shadow-sm bg-black-tertiary rounded mb-3">
                                <div class="card bg-dark border border-secondary card-hover" style="height: 120px;">
                                    <div class="row g-0 h-100">
                                        <div class="col-md-4 h-100">
                                            <img src='<%# Eval("UrlImagen") %>' class="img-fluid h-100 w-100 object-fit-cover rounded-start" alt="Imagen del curso" />
                                        </div>

                                        <div class="col-md-8 d-flex align-items-center h-100">
                                            <div class="card-body text-white py-2">
                                                <h5 class="card-title mb-0"><%# Eval("NombreCurso") %></h5>
                                                <br />
                                                <p>% Completado</p>
                                                <span class="stretched-link"></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </a>
                        <hr />
                    </ItemTemplate>
                </asp:Repeater>

            </div>
        </div>
    </div>


</asp:Content>


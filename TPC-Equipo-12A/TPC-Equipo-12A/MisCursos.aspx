<%@ Page Title="Mis Cursos" Language="C#" MasterPageFile="~/Aula.master" AutoEventWireup="true" CodeBehind="MisCursos.aspx.cs" Inherits="TPC_Equipo_12A.MisCursos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AulaContent" runat="server">

    <div class="container py-4">

        <div class="mb-5">
            <h1 class="display-4 fw-bold text-info">🎓 Tus cursos</h1>
            <p class="lead text-white-50">
                Aqui encontraras todos los cursos en los cuales estas incripto.
            </p>
        </div>
        <hr />
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
                                <a href='Curso.aspx?id=<%# Eval("IdCurso") %>'
                                    class="btn btn-outline-info btn-sm rounded-pill">¡Ingresar!
                                </a>
                            </div>
                        </div>
                    </div>

                </ItemTemplate>
            </asp:Repeater>
        </div>
        <asp:Label ID="lblMensaje" 
            CssClass="alert alert-dark text-center" 
            runat="server" 
            Visible="false" 
            Text="" />
    </div>


</asp:Content>


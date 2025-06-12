<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Leccion.aspx.cs" Inherits="TPC_Equipo_12A.Leccion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container col-xl-8">
        <div class="container mt-4">

            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item">
                        <a href='<%= "Curso.aspx?id=" + IdCurso.ToString() %>'>Nombre del curso</a>
                    </li>
                    <li class="breadcrumb-item">
                        <a href='<%= "Modulo.aspx?id=" + IdModulo.ToString() %>'>Nombre del módulo</a>
                    </li>
                    <li class="breadcrumb-item active" aria-current="page">
                        <asp:Literal ID="litBreadcrumbLeccion" runat="server" />
                    </li>
                </ol>
            </nav>

            <hr />

            <h2 class="text-success">
                <asp:Literal ID="litTitulo" runat="server" /></h2>
            <p>
                <asp:Literal ID="litDescripcion" runat="server" />
            </p>

            <asp:Literal ID="litContenido" runat="server" />

        </div>
    </div>

</asp:Content>

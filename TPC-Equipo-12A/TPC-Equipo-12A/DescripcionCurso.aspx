<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="DescripcionCurso.aspx.cs" Inherits="TPC_Equipo_12A.DescripcionCurso" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
       <div class="container py-4 text-white">
        <asp:Panel ID="pnlCurso" runat="server" CssClass="card bg-dark bg-opacity-75 p-4 border-primary">

            <h2 class="text-primary"><asp:Label ID="lblTitulo" runat="server" /></h2>

            <div class="row my-4">
                <div class="col-md-6">
                      <asp:Image ID="imgCurso"  runat="server" CssClass="img-fluid rounded border border-primary"  Style="max-width: 100%;"  AlternateText="Imagen del curso 1" />
                </div>
                <div class="col-md-6">
                    <h5 class="text-info">Descripción del curso</h5>
                    <asp:Label ID="lblDescripcion" runat="server" CssClass="text-white-50" />
                </div>
            </div>

            <a href="ListaCursos.aspx" class="btn btn-outline-light">Volver a cursos</a>
        </asp:Panel>
    </div>
</asp:Content>

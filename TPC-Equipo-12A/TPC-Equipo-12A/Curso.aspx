<%@ Page Title="Curso" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Curso.aspx.cs" Inherits="TPC_Equipo_12A.Curso" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container my-5">
        <div class="row">
            <div class="col-md-8 offset-md-2 text-white bg-dark border border-primary p-4 rounded">
                <asp:Label ID="lblTitulo" runat="server" CssClass="h2 d-block mb-3"></asp:Label>
                <asp:Label ID="lblDescripcion" runat="server" CssClass="fs-5 d-block mb-4"></asp:Label>
                <asp:Image ID="imgCurso" runat="server" CssClass="img-fluid rounded mb-4" />
                <asp:Button ID="btnComprar" runat="server" Text="Comprar" CssClass="btn btn-info" />
            </div>
        </div>
    </div>
</asp:Content>

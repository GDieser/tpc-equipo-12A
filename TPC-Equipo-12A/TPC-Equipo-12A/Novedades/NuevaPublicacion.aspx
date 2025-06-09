<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="NuevaPublicacion.aspx.cs" Inherits="TPC_Equipo_12A.NuevaPublicacion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <h1>Nueva Publicación:</h1>

    <h4>Titulo: </h4>
    <asp:textbox runat="server" />

    <h4>Resumen: </h4>
    <asp:textbox runat="server" />

    <h4>Descripcion: </h4>
    <asp:textbox runat="server" />

    <h4>Categoria: </h4>
    <asp:DropDownList ID="DropDownList1" runat="server"></asp:DropDownList>

</asp:Content>

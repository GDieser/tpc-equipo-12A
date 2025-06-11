<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="DetalleNovedad.aspx.cs" Inherits="TPC_Equipo_12A.DetalleNovedad" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="col">
        <hr />
        <div >
            <asp:Label ID="lblTitulo" runat="server"
                Style="font-size: 40px; font-weight: bold; margin-bottom: 15px; display: block;" />
            <asp:Button Text="Modificar" CssClass="btn btn-danger" id="btnModificar" OnClick="btnModificar_Click" runat="server" />
        </div>

        <div>
            <asp:Label ID="lblFechaPublicacion" runat="server"
                Style="font-size: 14px; margin-bottom: 10px; display: block;" />
        </div>

        <div class>
            <asp:Image ID="imgBanner" runat="server"
                ImageUrl="imageurl"
                Style="width: 300px; height: auto; margin-bottom: 15px;" />
        </div>
        <hr />
        <div>
            <asp:Label ID="lblResumen" runat="server"
                Style="margin-bottom: 10px; display: block;" />
        </div>

        <div>
            <asp:Label ID="lblDescripcion" runat="server"
                Style="font-size: 18px; margin-bottom: 10px; display: block;" />
        </div>

    </div>



</asp:Content>

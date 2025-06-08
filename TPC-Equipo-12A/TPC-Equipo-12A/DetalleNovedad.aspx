<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="DetalleNovedad.aspx.cs" Inherits="TPC_Equipo_12A.DetalleNovedad" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="col text-center">

        <div>
            <asp:image imageurl="imageurl" id="imgBanner" runat="server" />
        </div>
        <div>
            <asp:label id="lblTitulo" runat="server" />
        </div>
        <div>
            <asp:label id="lblFechaPublicacion" runat="server" />
        </div>
        <div>
            <asp:label id="lblResumen" runat="server" />
        </div>
        <div>
            <asp:label id="lblDescripcion" runat="server" />
        </div>
    </div>



</asp:Content>

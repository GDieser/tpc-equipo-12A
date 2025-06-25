<%@ Page Title="" Language="C#" MasterPageFile="~/Aula.Master" AutoEventWireup="true" CodeBehind="Aula.aspx.cs" Inherits="TPC_Equipo_12A.Aula1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AulaContent" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true" />
    <asp:UpdatePanel runat="server" ID="updAula" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:PlaceHolder ID="phContenido" runat="server" />
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="ListaNotificaciones.aspx.cs" Inherits="TPC_Equipo_12A.ListaNotificaciones" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="container text-center">
        <br />
        <h1>Notificaciones del sistema</h1>
        <br />

        <div class="mb-4">

            <div class="d-flex flex-wrap align-items-center gap-2 mb-3">
                <asp:Label runat="server" Text="Comentarios:" CssClass="fw-bold me-2" />
                <asp:Button ID="btnVerTodas" runat="server" Text="Ver todos" OnClick="btnVerTodas_Click"
                    CssClass="btn btn-primary btn-sm" />
                <asp:Button ID="btnVerNuevas" runat="server" Text="Sin leer" OnClick="btnVerNuevas_Click" CssClass="btn btn-success btn-sm" />
                <asp:Button ID="btnOcultarLeidos" runat="server" Text="Ocultar leidos" CssClass="btn btn-warning btn-sm" OnClick="btnOcultarLeidos_Click" />

                <asp:Label runat="server" Text="Reportes:" CssClass="fw-bold ms-3 me-2" />
                <asp:Button ID="btnTodosReportes" runat="server" Text="Ver todos" OnClick="btnTodosReportes_Click"
                    CssClass="btn btn-primary btn-sm" />
                <asp:Button ID="btnReportenuevos" runat="server" Text="Sin leer" OnClick="btnReportenuevos_Click"
                    CssClass="btn btn-success btn-sm" />
            </div>
        </div>
        <hr />
        <asp:Label ID="lblTitulo" runat="server" CssClass="h2" />
        

        <asp:Panel ID="pnlNotificaciones" runat="server">
            <br />
            <asp:GridView ID="gvNotificaciones" Visible="false" runat="server" AutoGenerateColumns="False" OnRowCommand="gvNotificaciones_RowCommand" CssClass="table table-striped table-dark table-hover table-bordered align-middle text-center" AllowPaging="true" OnPageIndexChanging="gvNotificaciones_PageIndexChanging" PageSize="15">
                <HeaderStyle CssClass="table-warning" />
                <Columns>
                    <asp:BoundField DataField="Contenido" HeaderText="Comentario" />
                    <asp:BoundField DataField="TipoOrigen" HeaderText="Origen" />
                    <asp:BoundField DataField="TituloPublicacion" HeaderText="Publicación/Foro" />
                    <asp:BoundField DataField="NombreUsuario" HeaderText="Usuario" />
                    <asp:BoundField DataField="Fecha" HeaderText="Fecha" DataFormatString="{0:dd/MM/yyyy HH:mm}" />
                    <asp:BoundField DataField="NombreUsuarioReportador" Visible="false" HeaderText="Reportado por" />
                    <asp:BoundField DataField="MotivoReporte" Visible="false" HeaderText="Motivo" />
                    <asp:TemplateField HeaderText="Acción">
                        <ItemTemplate>
                            <asp:Button ID="btnVer" runat="server" Text="Ver" CommandName="ver" CommandArgument='<%# Eval("IdNotificacion") + "|" + Eval("IdOrigen") + "|" + Eval("TipoOrigen")%>' CssClass="btn btn-success btn-sm" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Leído">
                        <ItemTemplate>
                            <asp:CheckBox ID="chkVisto" runat="server" Checked='<%# Eval("Visto") %>' AutoPostBack="true" OnCheckedChanged="chkVisto_CheckedChanged" />
                            <asp:HiddenField ID="hfIdNotificacion" runat="server" Value='<%# Eval("IdNotificacion") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

        </asp:Panel>

    </div>


</asp:Content>

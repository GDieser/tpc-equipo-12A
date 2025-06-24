<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="ListaNotificaciones.aspx.cs" Inherits="TPC_Equipo_12A.ListaNotificaciones" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="container text-center">
        <br />
        <h1>Notificacion del sistema</h1>
        <br />

        <asp:Panel ID="pnlNotificaciones" runat="server">

            <asp:GridView ID="gvNotificaciones" runat="server" AutoGenerateColumns="False" OnRowCommand="gvNotificaciones_RowCommand" CssClass="table table-striped table-dark table-hover table-bordered align-middle text-center">
                <Columns>
                    <asp:BoundField DataField="Contenido" HeaderText="Comentario" />
                    <asp:BoundField DataField="TituloPublicacion" HeaderText="Publicación" />
                    <asp:BoundField DataField="NombreUsuario" HeaderText="Usuario" />
                    <asp:BoundField DataField="Fecha" HeaderText="Fecha" DataFormatString="{0:dd/MM/yyyy HH:mm}" />
                    <asp:TemplateField HeaderText="Acción">
                        <ItemTemplate>
                            <asp:Button ID="btnVer" runat="server" Text="Ver" CommandName="ver" CommandArgument='<%# Eval("IdNotificacion") + "|" + Eval("IdOrigen") %>' CssClass="btn btn-success btn-sm" />
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

            <asp:Button ID="btnVerTodas" runat="server" Text="Ver todas las notificaciones" OnClick="btnVerTodas_Click" CssClass="btn btn-secondary mb-2" />
            <asp:Button ID="btnVerNuevas" runat="server" Text="Ver nuevas notificaciones" OnClick="btnVerNuevas_Click" CssClass="btn btn-primary mb-2 ml-2" />

        </asp:Panel>

    </div>


</asp:Content>

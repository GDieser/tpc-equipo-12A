<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="ListaUsuarios.aspx.cs" Inherits="TPC_Equipo_12A.ListaUsuarios" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="table-responsive">
            <asp:GridView ID="dgvUsuarios" runat="server"
                CssClass="table table-striped table-dark table-hover table-bordered align-middle text-center"
                AutoGenerateColumns="false"
                DataKeyNames="IdUsuario"
                OnRowCommand="dgvUsuarios_RowCommand"
                OnRowDataBound="dgvUsuarios_RowDataBound">

                <Columns>
                    <asp:BoundField HeaderText="Nombre" DataField="Nombre" />
                    <asp:BoundField HeaderText="Apellido" DataField="Apellido" />
                    <asp:BoundField HeaderText="Email" DataField="Email" />
                    <asp:BoundField HeaderText="Usuario" DataField="NombreUsuario" />
                    <asp:TemplateField HeaderText="Cursos Comprados">
                        <ItemTemplate>
                            <%# Eval("CursosAdquiridos") %>
                        </ItemTemplate>
                    </asp:TemplateField>


                    <asp:TemplateField HeaderText="Perfil">
                        <ItemTemplate>
                            <a href='<%# "Perfil.aspx?id=" + Eval("IdUsuario") %>' title="Ver perfil" style="text-decoration: none;">👁️</a>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Estado">
                        <ItemTemplate>
                            <div style="width: 15px; height: 15px; border-radius: 50%; background-color: <%# (bool)Eval("Habilitado") ? "green" : "red" %>; display: inline-block;">
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>

                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>

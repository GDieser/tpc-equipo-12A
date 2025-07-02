<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="ListaUsuarios.aspx.cs" Inherits="TPC_Equipo_12A.ListaUsuarios" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container text-center">
        <br />
        <h1>Lisa de Usuarios</h1>
        <br />

        <div class="mb-4">
            <asp:TextBox ID="txtBuscar" runat="server" CssClass="form-control w-25 mx-auto" Placeholder="Buscar..." />
            <div class="form-check form-check-inline mt-2">
                <asp:CheckBox ID="chkHabilitados" runat="server" CssClass="form-check-input" Checked="true" />
                <label for="chkHabilitados" class="form-check-label">Habilitados</label>
            </div>
            <div class="form-check form-check-inline">
                <asp:CheckBox ID="chkDeshabilitados" runat="server" CssClass="form-check-input" Checked="true" />
                <label for="chkDeshabilitados" class="form-check-label">Deshabilitados</label>
            </div>
            <asp:Button ID="btnFiltrar" runat="server" Text="Filtrar" CssClass="btn btn-primary ms-3" OnClick="btnFiltrar_Click" />
            <asp:Button ID="btnLimpiarFiltros" runat="server" Text="Limpiar filtros" CssClass="btn btn-secondary ms-2" OnClick="btnLimpiarFiltros_Click" />
        </div>

        <div class="mb-4">
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
                                <a href='<%# "Perfil.aspx?id=" + Eval("IdUsuario") %>' title="Ver perfil" style="text-decoration: none;">✍️</a>
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
    </div>



</asp:Content>

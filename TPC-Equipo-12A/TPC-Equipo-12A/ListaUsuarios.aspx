<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="ListaUsuarios.aspx.cs" Inherits="TPC_Equipo_12A.ListaUsuarios" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container text-center">
        <br />
        <h1>Lisa de Usuarios</h1>
        <br />

        <div class="d-flex align-items-center mb-4">
            <asp:TextBox ID="txtBuscar" runat="server" CssClass="form-control me-2" Style="width: 200px;" Placeholder="Buscar..." />

            <div class="form-check form-check-inline me-3">
                <asp:CheckBox ID="chkHabilitados" runat="server" CssClass="form-check-input" Checked="true" />
                <label for="chkHabilitados" class="form-check-label">Habilitados</label>
            </div>

            <div class="form-check form-check-inline me-3">
                <asp:CheckBox ID="chkDeshabilitados" runat="server" CssClass="form-check-input" Checked="true" />
                <label for="chkDeshabilitados" class="form-check-label">Deshabilitados</label>
            </div>

            <asp:Button ID="btnFiltrar" runat="server" Text="Filtrar" CssClass="btn btn-primary me-2" OnClick="btnFiltrar_Click" />
            <asp:Button ID="btnLimpiarFiltros" runat="server" Text="Limpiar filtros" CssClass="btn btn-secondary" OnClick="btnLimpiarFiltros_Click" />
        </div>

        <div class="mb-4">
            <div class="table-responsive">

                <asp:GridView ID="dgvUsuarios" runat="server"
                    CssClass="table table-striped table-dark table-hover table-bordered align-middle text-center"
                    AutoGenerateColumns="false"
                    DataKeyNames="IdUsuario"
                    OnRowCommand="dgvUsuarios_RowCommand"
                    OnRowDataBound="dgvUsuarios_RowDataBound">
                    <HeaderStyle CssClass="table-warning" />
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

                        <asp:TemplateField HeaderText="Estado">
                            <ItemTemplate>
                                <div style="width: 15px; height: 15px; border-radius: 50%; background-color: <%# (bool)Eval("Habilitado") ? "green" : "red" %>; display: inline-block;">
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Perfil">
                            <ItemTemplate>
                                <a href='<%# "Perfil.aspx?id=" + Eval("IdUsuario") %>' title="Ver perfil" style="text-decoration: none;">✍️</a>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Ver detalles">
                            <ItemTemplate>
                                <a href='<%# "DetalleUsuario.aspx?id=" + Eval("IdUsuario") %>' class="btn btn-primary">Ver más</a>

                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>



</asp:Content>

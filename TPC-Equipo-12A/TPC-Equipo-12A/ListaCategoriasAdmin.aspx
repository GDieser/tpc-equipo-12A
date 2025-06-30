<%@ Page Title="Lista de Categorías" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="ListaCategoriasAdmin.aspx.cs" Inherits="TPC_Equipo_12A.ListaCategoriasAdmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" />

    <div class="container text-center">
        <br />
        <h1>Lista de Categorías</h1>
        <br />

        <div class="mb-5">
            <div class="table-responsive">

                <asp:GridView ID="dgvCategorias"
                    runat="server"
                    CssClass="table table-striped table-dark table-hover table-bordered align-middle text-center"
                    AutoGenerateColumns="false"
                    DataKeyNames="IdCategoria"
                    AllowPaging="true"
                    PageSize="10"
                    OnPageIndexChanging="dgvCategorias_PageIndexChanging">


                    <Columns>
                        <asp:BoundField HeaderText="ID" DataField="IdCategoria" ReadOnly="true" />
                        <asp:BoundField HeaderText="Nombre" DataField="Nombre" />
                        <asp:TemplateField HeaderText="Activo">
                            <ItemTemplate>
                                <div style='width: 15px; height: 15px; border-radius: 50%; background-color: <%# (bool)Eval("Activo") ? "green" : "red" %>; display: inline-block;'>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Modificar">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnEditarCategoria" runat="server"
                                    OnClientClick='<%# "abrirModalEditarCategoria(\"" + Eval("Nombre") + "\", " + Eval("IdCategoria") + ", " + Eval("Activo").ToString().ToLower() + "); return false;" %>'
                                    CssClass="text-warning">
                                          ✍️
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>
                </asp:GridView>

                <asp:Button ID="btnAgregarCategoria"
    runat="server"
    Text="➕ Agregar Nueva Categoría"
    CssClass="btn btn-success mt-4"
    OnClientClick="abrirModalAgregarCategoria(); return false;" />

            </div>
        </div>
    </div>
    <asp:Panel ID="panelModalEditarCategoria" runat="server">
        <div class="modal fade" id="modalEditarCategoria" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content text-start">
                    <div class="modal-header">
                        <h5 class="modal-title" id="tituloModalCategoria">Editar Categoria</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                    </div>
                    <div class="modal-body">
                        <asp:HiddenField ID="hfIdEditarCategoria" runat="server" />
                        <div class="mb-3">
                            <label class="form-label">Nombre</label>
                            <asp:TextBox ID="txtEditarNombreCategoria" runat="server" CssClass="form-control" />
                        </div>
                        <div class="form-check">
                            <asp:CheckBox ID="chkEditarActivo" runat="server" CssClass="form-check-input" />
                            <label class="form-check-label">Activo</label>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <asp:Button ID="btnGuardarEdicionCategoria" runat="server" Text="Guardar Cambios" CssClass="btn btn-primary" OnClick="btnGuardarEdicionCategoria_Click" UseSubmitBehavior="false" />
                    </div>
                </div>
            </div>
        </div>
    </asp:Panel>
    <script>
        function abrirModalEditarCategoria(nombre, id, activo) {
            document.getElementById('<%= txtEditarNombreCategoria.ClientID %>').value = nombre;
        document.getElementById('<%= hfIdEditarCategoria.ClientID %>').value = id;
        document.getElementById('<%= chkEditarActivo.ClientID %>').checked = activo;
            var modal = new bootstrap.Modal(document.getElementById('modalEditarCategoria'));
            modal.show();
        }
    </script>
    <script>
        function abrirModalAgregarCategoria() {
            document.getElementById('<%= hfIdEditarCategoria.ClientID %>').value = '';
        document.getElementById('<%= txtEditarNombreCategoria.ClientID %>').value = '';
        document.getElementById('<%= chkEditarActivo.ClientID %>').checked = true;
            document.getElementById('tituloModalCategoria').innerText = 'Agregar Categoría';

            var modal = new bootstrap.Modal(document.getElementById('modalEditarCategoria'));
            modal.show();
        }
    </script>


</asp:Content>

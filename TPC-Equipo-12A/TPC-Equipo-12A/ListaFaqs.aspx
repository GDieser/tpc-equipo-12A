<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="ListaFaqs.aspx.cs" Inherits="TPC_Equipo_12A.ListaFaqs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <script>
        function abrirModal() {
            var modal = new bootstrap.Modal(document.getElementById('exampleModal'));
            modal.show();
        }
    </script>

    <script>
        function limpiarModal() {
            document.getElementById('<%= txtPregunta.ClientID %>').value = '';
        document.getElementById('<%= txtRespuesta.ClientID %>').value = '';
        document.getElementById('<%= ddlActivo.ClientID %>').value = '1';
        document.getElementById('<%= btnAgregarFaq.ClientID %>').innerText = 'Aceptar';
        }
    </script>

    <div class="container text-center">
        <br />
        <h1>Lista de Preguntas Frecuentes</h1>
        <br />
        <asp:GridView ID="dgvFaqs" CssClass="table table-striped table-dark table-hover table-bordered align-middle text-center" DataKeyNames="IdFaq" AutoGenerateColumns="false" runat="server" AllowPaging="true" PageSize="12" OnSelectedIndexChanged="dgvFaqs_SelectedIndexChanged" OnPageIndexChanging="dgvFaqs_PageIndexChanging">

            <Columns>

                <asp:BoundField HeaderText="Id" DataField="IdFaq" />
                <asp:BoundField HeaderText="Pregunta" DataField="Pregunta" />
                <asp:BoundField HeaderText="Respuesta" DataField="Respuesta" />
                <asp:TemplateField HeaderText="Activo">
                    <ItemTemplate>
                        <%# (bool)Eval("Activo") ? "🟢" : "🔴" %>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:CommandField HeaderText="Modificar" ShowSelectButton="true" SelectText="✍️" />

            </Columns>

        </asp:GridView>

        <button type="button" class="btn btn-success" onclick="limpiarModal()" data-bs-toggle="modal" data-bs-target="#exampleModal">
            Agregar FAQ
        </button>

        <div class="modal fade bg-dark p-2 text-dark bg-opacity-50" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content bg-dark p-2 text-white">
                    <div class="modal-header">

                        <h1 class="modal-title fs-5" id="exampleModalLabel">Agregar nueva FAQ</h1>

                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">

                        <div class="mb-3">
                            <label for="txtPregunta" class="form-label fw-bold">Pregunta:</label>
                            <asp:TextBox ID="txtPregunta" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control" />
                            <asp:RequiredFieldValidator ID="rfvPregunta" runat="server"
                                ControlToValidate="txtPregunta"
                                ErrorMessage="La pregunta es obligatoria."
                                Display="Dynamic" ForeColor="Red" CssClass="small" />
                        </div>

                        <div class="mb-3">
                            <label for="txtRespuesta" class="form-label fw-bold">Respuesta:</label>
                            <asp:TextBox ID="txtRespuesta" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control" />
                            <asp:RequiredFieldValidator ID="rfvRespuesta" runat="server"
                                ControlToValidate="txtPregunta"
                                ErrorMessage="La respuesta es obligatoria."
                                Display="Dynamic" ForeColor="Red" CssClass="small" />
                        </div>

                        <div class="mb-3">
                            <asp:Label runat="server" AssociatedControlID="ddlActivo" Text="Estado" />
                            <asp:DropDownList runat="server" ID="ddlActivo" CssClass="form-select">
                                <asp:ListItem Text="Activo" Value="1" />
                                <asp:ListItem Text="Oculto" Value="0" />
                            </asp:DropDownList>
                        </div>

                    </div>
                    <div class="modal-footer">
                        <asp:Button Text="Aceptar" CssClass="btn btn-success mt-4" ID="btnAgregarFaq" OnClick="btnAgregarFaq_Click" runat="server" />

                    </div>
                </div>
            </div>
        </div>


    </div>

</asp:Content>

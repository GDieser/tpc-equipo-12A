<%@ Page Title="Crear Curso" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="CrearCurso.aspx.cs" Inherits="TPC_Equipo_12A.CrearCurso" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server" />

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" />

    <div class="container mt-4">
        <h1>
            <asp:Literal ID="litTituloFormulario" runat="server" /></h1>
        <hr />

        <div class="row">
            <div class="col-md-6">
                <div class="mb-3">
                    <label for="txtTitulo" class="form-label fw-bold">Título: <span style="color: red">*</span></label>
                    <asp:TextBox ID="txtTitulo" runat="server" CssClass="form-control" />
                </div>
            </div>

            <div class="col-md-6">
                <div class="mb-3">
                    <label for="txtPrecio" class="form-label fw-bold">Precio: <span style="color: red">*</span></label>
                    <asp:TextBox ID="txtPrecio" runat="server" CssClass="form-control" />
                </div>
            </div>

            <div class="col-12">
                <div class="mb-3">
                    <label for="txtResumen" class="form-label fw-bold">Resumen: <span style="color: red">*</span></label>
                    <asp:TextBox ID="txtResumen" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control" />
                </div>
            </div>

            <div class="col-12">
                <div class="mb-3">
                    <label for="txtDescripcion" class="form-label fw-bold">Descripción: <span style="color: red">*</span></label>
                    <textarea id="txtDescripcion" runat="server" class="form-control" rows="8"></textarea>

                    <script>
                        CKEDITOR.replace('<%= txtDescripcion.ClientID %>', {
                            height: '450px',
                            extraAllowedContent: 'iframe[width,height,src,frameborder,allow,allowfullscreen,referrerpolicy,sandbox,title];',
                            removeButtons: '',
                            toolbar: 'full',
                            removePlugins: 'iframe',
                            extraPlugins: 'iframe',
                            filebrowserBrowseUrl: '',
                            filebrowserUploadUrl: '',
                            customConfig: ''
                        });
                    </script>
                </div>
            </div>

            <div class="col-md-4">
                <div class="mb-3">
                    <label for="ddlCategoria" class="form-label fw-bold">Categoría: <span style="color: red">*</span></label>
                    <div class="input-group">
                        <asp:DropDownList ID="ddlCategoria" runat="server" CssClass="form-select" onchange="handleCategoriaChange(this)"></asp:DropDownList>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="mb-3">
                    <label for="ddlEstado" class="form-label fw-bold">Estado: <span style="color: red">*</span></label>
                    <asp:DropDownList ID="ddlEstado" runat="server" CssClass="form-select" />
                </div>
            </div>

            <div class="col-md-4">
                <div class="mb-3">
                    <label for="txtDuracion" class="form-label fw-bold">Duración (horas): <span style="color: red">*</span></label>
                    <asp:TextBox ID="txtDuracion" runat="server" CssClass="form-control" />
                </div>
            </div>

            <div class="col-12">
                <div class="mb-3 form-check">
                    <asp:CheckBox ID="chkCertificado" runat="server" CssClass="form-check-input" />
                    <label class="form-check-label fw-bold">Incluye certificado</label>
                </div>
            </div>

            <div class="col-md-6">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <div class="mb-3">
                            <label for="txtImagen" class="form-label fw-bold">URL de imagen: <span style="color: red">*</span></label>
                            <asp:TextBox ID="txtImagen" runat="server" AutoPostBack="true" OnTextChanged="txtImagen_TextChanged" CssClass="form-control" />
                        </div>
                        <div class="text-center mb-3">
                            <asp:Image ID="imgPreview" runat="server" ImageUrl="https://www.aprender21.com/images/colaboradores/sql.jpeg" CssClass="img-thumbnail" Style="max-height: 200px;" />
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>

            <asp:Panel ID="panelModalCategoria" runat="server">
                <div class="modal fade" id="modalNuevaCategoria" tabindex="-1" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Agregar categoría</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>
                            <div class="modal-body">
                                <asp:TextBox ID="txtNuevaCategoriaModal" runat="server" CssClass="form-control" />
                            </div>
                            <div class="modal-footer">
                                <asp:Button ID="btnGuardarCategoriaModal" runat="server" Text="Guardar" CssClass="btn btn-primary" OnClick="btnGuardarCategoriaModal_Click" UseSubmitBehavior="false" />
                            </div>
                        </div>
                    </div>
                </div>
            </asp:Panel>

            <script>
                function handleCategoriaChange(select) {
                    if (select.value === '-1') {
                        var modal = new bootstrap.Modal(document.getElementById('modalNuevaCategoria'));
                        modal.show();
                    }
                }
            </script>

            <div class="text-center mt-4">
                <asp:Button Text="Guardar Curso" ID="btnGuardar" OnClick="btnGuardar_Click" CssClass="btn btn-primary px-4" runat="server" />
                <a href="ListaCursos.aspx" class="btn btn-danger px-4 ms-2">Cancelar</a>
            </div>
        </div>
    </div>
    <hr />

</asp:Content>


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
                    <asp:RangeValidator ErrorMessage="Fuera de rango" Type="Double" MinimumValue="0" ControlToValidate="txtPrecio" runat="server" />
                    <asp:RegularExpressionValidator ErrorMessage="Ingrese solo números validos." ValidationExpression="^[0-9]+$" ControlToValidate="txtPrecio" runat="server" />
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
                    <asp:RangeValidator ErrorMessage="Fuera de rango" Type="Double" MinimumValue="0" ControlToValidate="txtDuracion" runat="server" />
                    <asp:RegularExpressionValidator ErrorMessage="Ingrese solo números validos." ValidationExpression="^[0-9]+$" ControlToValidate="txtDuracion" runat="server" />
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
                            <label class="form-label">Imagen destacada</label>
                            <div class="input-group">
                                <asp:TextBox ID="txtUrlImagen"
                                    runat="server"
                                    CssClass="form-control"
                                    AutoPostBack="true"
                                    OnTextChanged="txtUrlImagen_TextChanged"
                                    placeholder="Ingresa una URL o selecciona un archivo"
                                    ReadOnly="false" />
                                <button type="button" class="btn btn-outline-secondary rounded-end"
                                    onclick="document.getElementById('<%= fuImagenCurso.ClientID %>').click();">
                                    <i class="bi bi-folder"></i>
                                </button>
                                <asp:FileUpload ID="fuImagenCurso" runat="server" CssClass="d-none" />
                            </div>
                        </div>
                        <div class="mb-1 d-flex align-items-center">
                            <asp:Label Text="" ID="lblNombreArchivoCurso" runat="server" />
                            <button type="button" id="btnBorrarArchivo" class="btn btn-link btn-sm ms-2 text-danger" style="display: none;" title="Eliminar archivo">
                                <i class="bi bi-trash"></i>
                            </button>
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

                Sys.Application.add_load(function () {
                    const inputFile = document.getElementById('<%= fuImagenCurso.ClientID %>');
                    const lblNombre = document.getElementById('<%= lblNombreArchivoCurso.ClientID %>');
                    const btnBorrar = document.getElementById('btnBorrarArchivo');
                    const txtUrlImagen = document.getElementById('<%= txtUrlImagen.ClientID %>');
                    const preview = document.getElementById('<%= imgPreview.ClientID %>');

                    function actualizarEstadoBoton() {
                        if (lblNombre.innerText.trim().length > 0) {
                            btnBorrar.style.display = "inline-block";
                        } else {
                            btnBorrar.style.display = "none";
                        }
                    }

                    inputFile.addEventListener("change", function () {
                        if (inputFile.files && inputFile.files[0]) {
                            const file = inputFile.files[0];
                            lblNombre.innerText = file.name;
                            txtUrlImagen.value = file.name;

                            const reader = new FileReader();
                            reader.onload = function (e) {
                                preview.src = e.target.result;
                            };
                            reader.readAsDataURL(file);
                        } else {
                            lblNombre.innerText = "";
                            preview.src = "";
                        }
                        actualizarEstadoBoton();
                    });

                    btnBorrar.addEventListener("click", function () {
                        inputFile.value = "";
                        lblNombre.innerText = "";
                        txtUrlImagen.value = ""; 
                        preview.src = "";  
                        actualizarEstadoBoton();
                    });

                    txtUrlImagen.addEventListener("input", function () {
                        const url = txtUrlImagen.value.trim();

                        if (url.startsWith("http://") || url.startsWith("https://") || url.startsWith("~/")) {
                            preview.src = url;
                            lblNombre.innerText = ""; 
                            actualizarEstadoBoton();
                        }
                    });

                    actualizarEstadoBoton();
                });
            </script>

            <div class="text-center mt-4">
                <asp:Button Text="Guardar Curso" ID="btnGuardar" OnClick="btnGuardar_Click" CssClass="btn btn-primary px-4" runat="server" />
                <a href="ListaCursos.aspx" class="btn btn-danger px-4 ms-2">Cancelar</a>
            </div>
        </div>
    </div>
    <hr />

</asp:Content>


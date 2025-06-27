<%@ Page Title="" Language="C#" MasterPageFile="~/Aula.Master" AutoEventWireup="true" CodeBehind="Curso.aspx.cs" Inherits="TPC_Equipo_12A.Curso" %>


<asp:Content ID="Content2" ContentPlaceHolderID="AulaContent" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true" />

    <style>
        .img-banner-curso {
            width: 100%;
            height: 25vh;
            object-fit: cover;
        }

        .card-header {
            border-bottom: 1px solid rgba(255,255,255,0.1) !important;
        }
    </style>


    <div class="container p-3">

        <div class="container mt-4">

            <div class="mb-4 text-center">
                <asp:Image ID="imgBannerCurso" runat="server" CssClass="img-fluid rounded shadow img-banner-curso" />
            </div>

            <h2 class="text-primary fw-bold">
                <asp:Literal ID="litTituloCurso" runat="server" />

            </h2>
            <div class="d-flex justify-content-between align-items-center">
                <p class="text-secondary mb-0">
                    <asp:Literal ID="litIntroCurso" runat="server" />
                </p>
                <asp:Button ID="btnAgregarLeccion" runat="server" CssClass="btn btn-primary btn-sm mb-3"
                    Text="Agregar Módulo" OnClientClick="limpiarModal(); return false;" data-bs-toggle="modal"
                    data-bs-target="#modalLeccion" />
            </div>
            <hr />
            <asp:UpdatePanel runat="server" ID="updtCurso">
                <ContentTemplate>
                    <asp:Repeater ID="rptModulos" runat="server"
                        OnItemCommand="rptModulos_ItemCommand"
                        OnItemDataBound="rptModulos_ItemDataBound"
                        OnItemCreated="rptModulos_ItemCreated">
                        <ItemTemplate>
                            <div class="card mb-2 border-0" style="background-color: #211c1c; color: aliceblue;">
                                <div class="card-header d-flex justify-content-between align-items-center border-0">
                                    <div style="flex-grow: 1; cursor: pointer;"
                                        data-bs-toggle="collapse"
                                        data-bs-target='<%# "#intro" + Eval("IdModulo") %>'>
                                        <asp:Literal
                                            runat="server"
                                            ID="ltEstadoModulo" />
                                        <span class="fw-bold"><%# Eval("Titulo") %></span>

                                    </div>

                                    <div class="btn-group" runat="server" id="grupoAdmin">
                                        <asp:LinkButton
                                            ID="btnSubir"
                                            runat="server"
                                            CssClass="btn btn-link text-decoration-none m-0"
                                            CommandName="Subir"
                                            CommandArgument='<%# Eval("IdModulo") %>'
                                            ToolTip="Subir módulo">
                    <i class="bi bi-arrow-up text-white"></i>
                                        </asp:LinkButton>

                                        <asp:LinkButton
                                            ID="btnBajar"
                                            runat="server"
                                            CssClass="btn btn-link text-decoration-none m-0"
                                            CommandName="Bajar"
                                            CommandArgument='<%# Eval("IdModulo") %>'
                                            ToolTip="Bajar módulo">
                    <i class="bi bi-arrow-down text-white"></i>
                                        </asp:LinkButton>

                                        <asp:LinkButton
                                            ID="btnEditar"
                                            runat="server"
                                            CssClass="btn btn-link text-decoration-none m-0"
                                            CommandName="Editar"
                                            CommandArgument='<%# Eval("IdModulo") %>'
                                            ToolTip="Editar módulo"
                                            data-bs-toggle="modal"
                                            data-bs-target="#modalLeccion">
                    <i class="bi bi-pencil text-white"></i>
                                        </asp:LinkButton>

                                        <asp:LinkButton
                                            ID="btnEliminar"
                                            runat="server"
                                            CssClass="btn btn-link text-decoration-none m-0"
                                            CommandName="Eliminar"
                                            CommandArgument='<%# Eval("IdModulo") %>'
                                            ToolTip="Eliminar módulo"
                                            OnClientClick="return confirmarEliminacion(this);">
                    <i class="bi bi-trash text-white"></i>
                                        </asp:LinkButton>
                                    </div>
                                    <i class="bi bi-chevron-down text-white toggle-chevron"
                                        data-bs-toggle="collapse"
                                        data-bs-target='<%# "#intro" + Eval("IdModulo") %>'
                                        aria-expanded="false"
                                        aria-controls='<%# "intro" + Eval("IdModulo") %>'
                                        style="cursor: pointer;"></i>
                                </div>

                                <div id='<%# "intro" + Eval("IdModulo") %>' class="collapse card-body border-0" style="background-color: #211c1c; color: aliceblue;">
                                    <div class="d-flex justify-content-between align-items-start mb-2">
                                        <p class="mb-0 fst-italic" style="color: lightgray;">
                                            <%# Eval("Introduccion").ToString().Length > 100 
                ? Eval("Introduccion").ToString().Substring(0, 100) + "..." 
                : Eval("Introduccion").ToString() %>
                                        </p>
                                        <a href='<%# "Modulo.aspx?id=" + Eval("IdModulo") %>'
                                            class="ms-3 text-decoration-none text-info fw-bold">Ver más
                                        </a>
                                    </div>

                                    <ol class="list-group list-group-numbered">
                                        <asp:Repeater ID="rptLecciones" runat="server" DataSource='<%# Eval("Lecciones") %>'>
                                            <ItemTemplate>
                                                <li class="list-group-item bg-dark text-light border-secondary d-flex justify-content-between align-items-center">
                                                    <div class="flex-grow-1 text-start ps-2">
                                                        <i class='<%# ((bool)Eval("Completado")) ? "bi bi-check-circle-fill text-success" : "bi bi-circle text-secondary" %>'
                                                            title='<%# ((bool)Eval("Completado")) ? "Completada" : "Incompleta" %>'
                                                            style="margin-right: 8px;"></i>
                                                        <%# Eval("Titulo") %>
                                                    </div>
                                                    <a href='<%# "Leccion.aspx?id=" + Eval("IdLeccion") %>' class="btn btn-sm btn-outline-primary ms-2">
                                                        <i class="bi bi-arrow-right text-white"></i>
                                                    </a>
                                                </li>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </ol>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                    <asp:Button ID="btnGuardarCambios" runat="server" CssClass="btn btn-success btn-sm mb-3" Text="Guardar cambios" OnClick="btnGuardarCambios_Click" />

                </ContentTemplate>
            </asp:UpdatePanel>
            <asp:UpdatePanel runat="server" ID="updModal" UpdateMode="Conditional">
                <ContentTemplate>
                    <div class="modal fade" id="modalLeccion" tabindex="-1" aria-labelledby="modalLeccionLabel" aria-hidden="true">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content bg-dark text-white">
                                <div class="modal-header border-bottom border-secondary">
                                    <h5 class="modal-title" id="modalLeccionLabel">Agregar/Editar Módulo</h5>
                                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                                </div>
                                <div class="modal-body">

                                    <asp:HiddenField ID="hfIdLeccion" runat="server" />
                                    <asp:HiddenField ID="hfIdImagen" runat="server" />
                                    <div class="mb-3">
                                        <label for="txtTituloLeccion" class="form-label">Título</label>
                                        <asp:TextBox ID="txtTituloLeccion" runat="server" CssClass="form-control" />
                                    </div>
                                    <div class="mb-3">
                                        <label for="txtIntroLeccion" class="form-label">Introducción</label>
                                        <asp:TextBox ID="txtIntroLeccion" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" />
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Imagen destacada (opcional)</label>
                                        <div class="input-group">
                                            <asp:TextBox ID="txtNombreArchivoLeccion" runat="server" CssClass="form-control" ReadOnly="true" />
                                            <button type="button" class="btn btn-outline-secondary rounded-end"
                                                onclick="document.getElementById('<%= fuImagenLeccion.ClientID %>').click();">
                                                <i class="bi bi-folder"></i>
                                            </button>
                                            <asp:FileUpload ID="fuImagenLeccion" runat="server" CssClass="d-none" />
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer border-0">
                                    <asp:Button ID="btnGuardarLeccion" runat="server"
                                        CssClass="btn btn-success"
                                        Text="Guardar"
                                        OnClick="btnGuardarModulo_Click"
                                        UseSubmitBehavior="false" />
                                </div>

                            </div>
                        </div>
                    </div>
                </ContentTemplate>
                <Triggers>
                    <asp:PostBackTrigger ControlID="btnGuardarLeccion" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </div>
    <script>
        function limpiarModal() {
            document.getElementById("<%= hfIdLeccion.ClientID %>").value = "";
            document.getElementById("<%= txtTituloLeccion.ClientID %>").value = "";
            document.getElementById("<%= txtIntroLeccion.ClientID %>").value = "";
            document.getElementById("<%= txtNombreArchivoLeccion.ClientID %>").value = "";
        }

        document.addEventListener("DOMContentLoaded", function () {
            const inputFile = document.getElementById("<%= fuImagenLeccion.ClientID %>");
            const txtNombre = document.getElementById("<%= txtNombreArchivoLeccion.ClientID %>");

            console.log("Valor inicial del textbox (DOMContentLoaded):", txtNombre?.value);

            if (inputFile) {
                inputFile.addEventListener("change", function () {
                    if (inputFile.files.length > 0) {
                        txtNombre.value = inputFile.files[0].name;
                    }
                });
            }

            document.querySelectorAll('.collapse').forEach(function (collapseEl) {
                collapseEl.addEventListener('show.bs.collapse', function () {
                    const chevron = this.closest('.card').querySelector('.toggle-chevron');
                    if (chevron) {
                        chevron.classList.remove('bi-chevron-down');
                        chevron.classList.add('bi-chevron-up');
                    }
                });

                collapseEl.addEventListener('hide.bs.collapse', function () {
                    const chevron = this.closest('.card').querySelector('.toggle-chevron');
                    if (chevron) {
                        chevron.classList.remove('bi-chevron-up');
                        chevron.classList.add('bi-chevron-down');
                    }
                });
            });
        });

        Sys.Application.add_load(function () {
            document.body.classList.remove('modal-open');
            document.querySelectorAll('.modal-backdrop').forEach(b => b.remove());
            document.body.style.overflowY = 'auto';
            document.body.style.position = 'relative';
        });

        document.addEventListener('DOMContentLoaded', function () {
            const modalEl = document.getElementById('modalLeccion');
            modalEl?.addEventListener('hidden.bs.modal', function () {
                document.body.classList.remove('modal-open');
                const backdrop = document.querySelector('.modal-backdrop');
                if (backdrop) backdrop.remove();
            });
        });

        function confirmarEliminacion(btn) {
            event.preventDefault();

            const uniqueId = btn.getAttribute("data-uid"); // ← clave

            Swal.fire({
                title: '¡ATENCION ESTA ACCION ES IRREVERSIBLE!',
                text: "Esta acción eliminará el modulo definitivamente, ¿queres continuar?",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: 'Continuar',
                cancelButtonText: 'Cancelar',
                reverseButtons: true
            }).then((result) => {
                if (result.isConfirmed && uniqueId) {
                    __doPostBack(uniqueId, '');
                }
            });

            return false;
        }

    </script>

</asp:Content>

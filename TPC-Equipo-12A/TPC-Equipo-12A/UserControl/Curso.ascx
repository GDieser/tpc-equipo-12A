<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Curso.ascx.cs" Inherits="TPC_Equipo_12A.UserControl.Curso" EnableViewState="true" %>

<asp:UpdatePanel ID="updCurso" runat="server">
    <ContentTemplate>
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

                <h2 class="text-primary">
                    <asp:Literal ID="litTituloCurso" runat="server" />
                </h2>
                <div class="d-flex justify-content-between align-items-center">
                    <p class="text-secondary mb-0">
                        <asp:Literal ID="litIntroCurso" runat="server" />
                    </p>
                    <asp:Button ID="btnAgregarLeccion" runat="server" CssClass="btn btn-primary btn-sm mb-3" Text="Agregar Módulo" OnClientClick="limpiarModal(); return false;" data-bs-toggle="modal" data-bs-target="#modalLeccion" />
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
                                            <span><%# Eval("Titulo") %></span>
                                        </div>
                                        <div class="btn-group" id="grupoAdmin" runat="server">
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
                                                ToolTip="Editar módulo">
                                            <i class="bi bi-pencil text-white"></i>
                                            </asp:LinkButton>

                                            <asp:LinkButton
                                                ID="btnEliminar"
                                                runat="server"
                                                CssClass="btn btn-link text-decoration-none m-0"
                                                OnClientClick="return confirmarEliminacion(this);"
                                                CommandName="Eliminar"
                                                CommandArgument='<%# Eval("IdModulo") %>'
                                                ToolTip="Eliminar módulo">
                                            <i class="bi bi-trash text-white"></i>
                                            </asp:LinkButton>
                                        </div>
                                        <asp:LinkButton
                                            ID="btnVerModulo"
                                            runat="server"
                                            CommandName="VerModulo"
                                            CommandArgument='<%# Eval("IdModulo") %>'
                                            CssClass='<%# Convert.ToInt32(Eval("IdModulo")) > 0 ? "btn btn-primary btn-sm" : "btn btn-secondary btn-sm disabled" %>'
                                            OnClientClick="event.stopPropagation();">
                                        <i class="bi bi-box-arrow-in-right me-1"></i>Ir al módulo
                                        </asp:LinkButton>
                                    </div>
                                    <div id='<%# "intro" + Eval("IdModulo") %>'
                                        class="collapse card-body border-0"
                                        style="background-color: #211c1c; color: aliceblue;">
                                        <%# Eval("Introduccion") %>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                        <asp:Button ID="btnGuardarCambios" runat="server" CssClass="btn btn-success btn-sm mb-3" Text="Guardar cambios" OnClick="btnGuardarCambios_Click" />

                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnGuardarLeccion" EventName="Click" />
                    </Triggers>
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
                                            <label for="txtImagenLeccion" class="form-label">URL Imagen (opcional)</label>
                                            <asp:TextBox ID="txtImagenLeccion" runat="server" CssClass="form-control" />
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
                </asp:UpdatePanel>
            </div>
        </div>
        <script>
            function limpiarModal() {
                document.getElementById("<%= hfIdLeccion.ClientID %>").value = "";
                document.getElementById("<%= txtTituloLeccion.ClientID %>").value = "";
                document.getElementById("<%= txtIntroLeccion.ClientID %>").value = "";
                document.getElementById("<%= txtImagenLeccion.ClientID %>").value = "";
            }

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
    </ContentTemplate>
</asp:UpdatePanel>

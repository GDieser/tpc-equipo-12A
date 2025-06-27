<%@ Page Title="" Language="C#" MasterPageFile="~/Aula.Master" AutoEventWireup="true" CodeBehind="Modulo.aspx.cs" Inherits="TPC_Equipo_12A.Modulo" %>

<asp:Content ID="Content2" ContentPlaceHolderID="AulaContent" runat="server">
    <asp:ScriptManager runat="server" EnablePartialRendering="true" />

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
            <asp:UpdatePanel ID="updLecciones" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
                <ContentTemplate>
                    <div class="mb-4 text-center">
                        <asp:Image ID="imgModulo" runat="server" CssClass="img-fluid rounded shadow img-banner-curso" />
                    </div>

                    <h2 class="text-primary fw-bold">
                        <asp:Literal ID="litTitulo" runat="server" />
                    </h2>
                    <div class="d-flex justify-content-between align-items-center">
                        <p class="text-secondary mb-0 fst-italic">
                            <asp:Literal ID="litIntro" runat="server" />
                        </p>
                        <asp:Button ID="btnAgregarLeccion"
                            runat="server"
                            CssClass="btn btn-primary btn-sm mb-3"
                            Text="Agregar Leccion"
                            OnClientClick="limpiarModal(); return false;"
                            UseSubmitBehavior="false"
                            data-bs-toggle="modal"
                            data-bs-target="#modalLeccion" />
                    </div>
                    <hr />

                    <asp:Repeater ID="rptLecciones"
                        runat="server"
                        OnItemDataBound="rptLecciones_ItemDataBound"
                        OnItemCommand="rptLecciones_ItemCommand"
                        OnItemCreated="rptLecciones_ItemCreated">
                        <ItemTemplate>
                            <div class="card mb-2 border-0" style="background-color: #211c1c; color: aliceblue;">
                                <div class="card-header d-flex justify-content-between align-items-center border-0">
                                    <div class="fw-bold" style="flex-grow: 1; cursor: pointer;"
                                        data-bs-toggle="collapse"
                                        data-bs-target='<%# "#intro" + Eval("IdLeccion") %>'>
                                        <span><%# Eval("Titulo") %></span>
                                    </div>
                                    <div class="btn-group text-white">
                                        <asp:LinkButton
                                            ID="btnSubir"
                                            runat="server"
                                            CssClass="btn btn-link text-decoration-none m-0"
                                            CommandName="Subir"
                                            CommandArgument='<%# Eval("IdLeccion") %>'
                                            ToolTip="Subir leccion">
                                        <i class="bi bi-arrow-up text-white"></i>
                                        </asp:LinkButton>

                                        <asp:LinkButton
                                            ID="btnBajar"
                                            runat="server"
                                            CssClass="btn btn-link text-decoration-none m-0"
                                            CommandName="Bajar"
                                            CommandArgument='<%# Eval("IdLeccion") %>'
                                            ToolTip="Bajar leccion">
                                        <i class="bi bi-arrow-down text-white"></i>
                                        </asp:LinkButton>

                                        <asp:LinkButton
                                            ID="btnEditar"
                                            runat="server"
                                            CssClass="btn btn-link text-decoration-none m-0"
                                            CommandName="Editar"
                                            CommandArgument='<%# Eval("IdLeccion") %>'
                                            ToolTip="Editar leccion">
                                        <i class="bi bi-pencil text-white"></i>
                                        </asp:LinkButton>

                                        <asp:LinkButton
                                            ID="btnEliminar"
                                            runat="server"
                                            CssClass="btn btn-link text-decoration-none m-0"
                                            OnClientClick="return confirmarEliminacion(this);"
                                            CommandName="Eliminar"
                                            CommandArgument='<%# Eval("IdLeccion") %>'
                                            ToolTip="Eliminar leccion">
                                        <i class="bi bi-trash text-white"></i>
                                        </asp:LinkButton>

                                    </div>


                                </div>
                                <div id='<%# "intro" + Eval("IdLeccion") %>'
                                    class="collapse card-body border-0"
                                    style="background-color: #211c1c; color: lightgray;">
                                    <div class="d-flex justify-content-between align-items-start">
                                        <p class="mb-0 fst-italic" style="color: lightgray;">
                                            <%# Eval("Introduccion").ToString().Length > 100 
                                            ? Eval("Introduccion").ToString().Substring(0, 100) + "..." 
                                            : Eval("Introduccion").ToString() %>
                                        </p>
                                        <a href='<%# Eval("IdLeccion").ToString() != "0" ? "Leccion.aspx?id=" + Eval("IdLeccion") : "#" %>'
                                            class='<%# (Convert.ToInt32(Eval("IdLeccion")) > 0 ? "btn btn-primary btn-sm" : "btn btn-secondary btn-sm disabled") %>'
                                            onclick="event.stopPropagation();">¡Ingresar! 
                                            <i class="bi bi-arrow-right text-white"></i>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                    <asp:Button ID="btnGuardarCambios"
                        runat="server"
                        CssClass="btn btn-success btn-sm mb-3"
                        Text="Guardar cambios"
                        OnClick="btnGuardarCambios_Click" />
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="rptLecciones" EventName="ItemCommand" />
                </Triggers>
            </asp:UpdatePanel>

            <asp:UpdatePanel runat="server" ID="updtModal" UpdateMode="Conditional">
                <ContentTemplate>
                    <div class="modal fade" id="modalLeccion" tabindex="-1" aria-labelledby="modalLeccionLabel" aria-hidden="true">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content bg-dark text-white">
                                <div class="modal-header border-0">
                                    <h5 class="modal-title" id="modalLeccionLabel">Agregar/Editar Leccion</h5>
                                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                                </div>
                                <div class="modal-body">

                                    <asp:HiddenField ID="hfIdLeccion" runat="server" />
                                    <div class="mb-3">
                                        <label for="txtTituloLeccion" class="form-label">Título</label>
                                        <asp:TextBox ID="txtTituloLeccion" runat="server" CssClass="form-control" />
                                    </div>
                                    <div class="mb-3">
                                        <label for="txtIntroLeccion" class="form-label">Introducción</label>
                                        <asp:TextBox ID="txtIntroLeccion" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" />
                                    </div>
                                </div>
                                <div class="modal-footer border-0">
                                    <asp:Button ID="btnGuardarLeccion" runat="server" CssClass="btn btn-success" Text="Guardar" OnClick="btnGuardarLeccion_Click" />
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
                text: "Esta acción eliminará la leccion, ¿queres continuar?",
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

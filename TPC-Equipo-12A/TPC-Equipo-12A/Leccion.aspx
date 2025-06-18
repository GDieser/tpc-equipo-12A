<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Leccion.aspx.cs" Inherits="TPC_Equipo_12A.Leccion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" />
    <div class="container col-xl-8">
        <div class="container mt-4 mb-4">

            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item">
                        <a href='<%= "Curso.aspx?id=" + IdCurso.ToString() %>'>Nombre del curso</a>
                    </li>
                    <li class="breadcrumb-item">
                        <a href='<%= "Modulo.aspx?id=" + IdModulo.ToString() %>'>Nombre del módulo</a>
                    </li>
                    <li class="breadcrumb-item active" aria-current="page">
                        <asp:Literal ID="litBreadcrumbLeccion" runat="server" />
                    </li>
                </ol>
            </nav>
            <hr />

            <h2 class="text-success">
                <asp:Literal ID="litTitulo" runat="server" /></h2>

            <div class="d-flex justify-content-between align-items-center">
                <p class="text-secondary mb-0">
                    <asp:Literal ID="litDescripcion" runat="server" />
                </p>
                <asp:Button ID="btnAgregarComponente"
                    runat="server"
                    CssClass="btn btn-primary btn-sm mb-3"
                    Text="Agregar Componente"
                    OnClientClick="limpiarModal(); return false;"
                    data-bs-toggle="modal"
                    data-bs-target="#modalComponente" />
            </div>
            <hr class="mt-2 mb-2" />
            <asp:UpdatePanel runat="server">
                <ContentTemplate>
                    <!-- Modal Agregar/Editar Componente -->
                    <div class="modal fade" id="modalComponente" tabindex="-1" aria-labelledby="modalComponenteLabel" aria-hidden="true">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content bg-dark text-white">
                                <div class="modal-header border-0">
                                    <h5 class="modal-title" id="modalComponenteLabel">Agregar/Editar Componente</h5>
                                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                                </div>
                                <div class="modal-body">

                                    <asp:HiddenField ID="hfIdComponente" runat="server" />

                                    <div class="mb-3">
                                        <label for="txtTituloComponente" class="form-label">Título</label>
                                        <asp:TextBox ID="txtTituloComponente" runat="server" CssClass="form-control" />
                                    </div>

                                    <div class="mb-3">
                                        <label for="txtContenidoComponente" class="form-label">Contenido</label>
                                        <asp:TextBox ID="txtContenidoComponente" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" />
                                    </div>

                                    <div class="mb-3">
                                        <label for="ddlTipoComponente" class="form-label">Tipo</label>
                                        <asp:DropDownList ID="ddlTipoComponente" runat="server" CssClass="form-select">
                                            <asp:ListItem Text="Seleccionar..." Value="" />
                                            <asp:ListItem Text="Texto" Value="0" />
                                            <asp:ListItem Text="Imagen" Value="1" />
                                            <asp:ListItem Text="Video" Value="2" />
                                            <asp:ListItem Text="Archivo" Value="3" />
                                        </asp:DropDownList>
                                    </div>

                                </div>
                                <div class="modal-footer border-0">
                                    <asp:Button ID="btnGuardarComponente" runat="server" CssClass="btn btn-success" Text="Guardar" OnClick="btnGuardarComponente_Click" />
                                </div>
                            </div>
                        </div>
                    </div>

                    <asp:Repeater ID="rptComponentes" runat="server" OnItemDataBound="rptComponentes_ItemDataBound">
                        <ItemTemplate>
                            <div class="mb-4">

                                <!-- Texto -->
                                <asp:Panel ID="pnlTexto" runat="server" Visible="false" CssClass="text-justify my-2">
                                    <asp:Literal ID="litTexto" runat="server" />
                                </asp:Panel>

                                <!-- Imagen -->
                                <asp:Panel ID="pnlImagen" runat="server" Visible="false" CssClass="my-4">
                                    <div class="row justify-content-center">
                                        <div class="col-sm-6 text-center">
                                            <asp:Image ID="imgContenido" runat="server" CssClass="img-fluid rounded" />
                                        </div>
                                    </div>
                                </asp:Panel>

                                <!-- Video -->
                                <asp:PlaceHolder ID="phVideo" runat="server" Visible="false" />

                                <!-- Archivo -->
                                <asp:Panel ID="pnlArchivo" runat="server" Visible="false" CssClass="my-2">
                                    <i class="bi bi-file-earmark-text-fill text-primary"></i>
                                    <asp:HyperLink ID="lnkArchivo" runat="server" Target="_blank" Text="" />
                                </asp:Panel>

                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                    <asp:Button ID="btnGuardarCambios" runat="server" CssClass="btn btn-success btn-sm mb-3" Text="Guardar cambios" OnClick="btnGuardarCambios_Click" />

                </ContentTemplate>
            </asp:UpdatePanel>
            <hr class="mt-2 mb-2" />
            <div class="text-end">
                <asp:Button Text="Marcar como completada" CssClass="btn btn-primary" runat="server" ID="btnMarcarCompletada" OnClick="btnMarcarCompletada_Click" />
            </div>
        </div>
    </div>
    <script>
        function limpiarModal() {
            document.getElementById("<%= hfIdComponente.ClientID %>").value = "";
            document.getElementById("<%= txtContenidoComponente.ClientID %>").value = "";
            document.getElementById("<%= txtTituloComponente.ClientID %>").value = "";
            document.getElementById("<%= ddlTipoComponente.ClientID %>").value = "";
        }

        document.addEventListener('DOMContentLoaded', function () {
            const modalEl = document.getElementById('modalLeccion');
            modalEl?.addEventListener('hidden.bs.modal', function () {
                document.body.classList.remove('modal-open');
                const backdrop = document.querySelector('.modal-backdrop');
                if (backdrop) backdrop.remove();
            });
        });
    </script>

</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Modulo.aspx.cs" Inherits="TPC_Equipo_12A.Modulo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" />
    <style>
        .img-banner-curso {
            width: 100%;
            height: 25vh;
            object-fit: cover;
        }
    </style>


    <div class="container col-xl-8">

        <div class="container mt-4">

            <div class="mb-4 text-center">
                <asp:Image ID="imgModulo" runat="server" CssClass="img-fluid rounded shadow img-banner-curso" />
            </div>

            <h2 class="text-primary">
                <asp:Literal ID="litTitulo" runat="server" />
            </h2>
            <div class="d-flex justify-content-between align-items-center">
                <p class="text-secondary mb-0">
                    <asp:Literal ID="litIntro" runat="server" />
                </p>
                <asp:Button ID="btnAgregarLeccion" 
                    runat="server" 
                    CssClass="btn btn-primary btn-sm mb-3" 
                    Text="Agregar Leccion" 
                    OnClientClick="limpiarModal(); return false;" 
                    data-bs-toggle="modal" 
                    data-bs-target="#modalLeccion" />
            </div>
            <hr />
            <asp:UpdatePanel ID="updLecciones" runat="server">
                <ContentTemplate>
                    <asp:Repeater ID="rptLecciones" 
                        runat="server" 
                        OnItemCommand="rptLecciones_ItemCommand">
                        <ItemTemplate>
                            <div class="card mb-2">
                                <div class="card-header d-flex justify-content-between align-items-center">
                                    <div style="flex-grow: 1; cursor: pointer;"
                                        data-bs-toggle="collapse"
                                        data-bs-target='<%# "#intro" + Eval("IdLeccion") %>'>
                                        <span><%# Eval("Titulo") %></span>
                                    </div>
                                    <div class="btn-group">
                                        <asp:LinkButton
                                            ID="btnSubir"
                                            runat="server"
                                            CssClass="btn btn-link text-decoration-none p-0 m-0"
                                            CommandName="Subir"
                                            CommandArgument='<%# Eval("IdLeccion") %>'
                                            ToolTip="Subir leccion">
                                     ⬆️
                                        </asp:LinkButton>

                                        <asp:LinkButton
                                            ID="btnBajar"
                                            runat="server"
                                            CssClass="btn btn-link text-decoration-none p-0 m-0"
                                            CommandName="Bajar"
                                            CommandArgument='<%# Eval("IdLeccion") %>'
                                            ToolTip="Bajar leccion">
                                     ⬇️
                                        </asp:LinkButton>

                                        <asp:LinkButton
                                            ID="btnEditar"
                                            runat="server"
                                            CssClass="btn btn-link text-decoration-none p-0 m-0"
                                            CommandName="Editar"
                                            CommandArgument='<%# Eval("IdLeccion") %>'
                                            ToolTip="Editar leccion">
                                     ✏️
                                        </asp:LinkButton>
                                    </div>
                                    <a href='<%# "Leccion.aspx?id=" + Eval("IdLeccion") %>' 
                                        class="btn btn-primary btn-sm" 
                                        onclick="event.stopPropagation();">
                                        Ir a la leccion
                                    </a>

                                </div>
                                <div id='<%# "intro" + Eval("IdLeccion") %>'
                                    class="collapse card-body bg-light text-secondary">
                                    <%# Eval("Introduccion") %>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                    <asp:Button ID="btnGuardarCambios" 
                        runat="server" 
                        CssClass="btn btn-success btn-sm mb-3" 
                        Text="Guardar cambios" 
                        OnClick="btnGuardarCambios_Click" />

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
                                    <div class="mb-3">
                                        <label for="txtImagenLeccion" class="form-label">URL Imagen (opcional)</label>
                                        <asp:TextBox ID="txtImagenLeccion" runat="server" CssClass="form-control" />
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
            document.getElementById("<%= txtImagenLeccion.ClientID %>").value = "";
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

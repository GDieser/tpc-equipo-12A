<%@ Page Title="" Language="C#" MasterPageFile="~/Aula.Master" AutoEventWireup="true" CodeBehind="Curso.aspx.cs" Inherits="TPC_Equipo_12A.Curso" %>


<asp:Content ID="Content2" ContentPlaceHolderID="AulaContent" runat="server">
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
            <asp:UpdatePanel ID="updModulos" runat="server">
                <ContentTemplate>
                    <asp:Repeater ID="rptModulos" runat="server" OnItemCommand="rptModulos_ItemCommand">
                        <ItemTemplate>
                            <div class="card mb-2 border-0" style="background-color:#211c1c; color: aliceblue;">
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
                                            CssClass="btn btn-link text-decoration-none p-0 m-0"
                                            CommandName="Subir"
                                            CommandArgument='<%# Eval("IdModulo") %>'
                                            ToolTip="Subir módulo">
                                     ⬆️
                                        </asp:LinkButton>

                                        <asp:LinkButton
                                            ID="btnBajar"
                                            runat="server"
                                            CssClass="btn btn-link text-decoration-none p-0 m-0"
                                            CommandName="Bajar"
                                            CommandArgument='<%# Eval("IdModulo") %>'
                                            ToolTip="Bajar módulo">
                                     ⬇️
                                        </asp:LinkButton>

                                        <asp:LinkButton
                                            ID="btnEditar"
                                            runat="server"
                                            CssClass="btn btn-link text-decoration-none p-0 m-0"
                                            CommandName="Editar"
                                            CommandArgument='<%# Eval("IdModulo") %>'
                                            ToolTip="Editar módulo">
                                     ✏️
                                        </asp:LinkButton>
                                    </div>
                                    <a  href='<%# "Modulo.aspx?id=" + Eval("IdModulo") != "0" ? "Modulo.aspx?id=" + Eval("IdModulo") : "#" %>'
                                        class='<%# (Convert.ToInt32(Eval("IdModulo")) > 0 ? "btn btn-primary btn-sm" : "btn btn-secondary btn-sm disabled") %>'
                                        onclick="event.stopPropagation();">Ir al módulo
                                    </a>
 
                                </div>
                                <div id='<%# "intro" + Eval("IdModulo") %>' 
                                    class="collapse card-body border-0" 
                                    style="background-color:#211c1c; color: aliceblue;">
                                    <%# Eval("Introduccion") %>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                    <asp:Button ID="btnGuardarCambios" runat="server" CssClass="btn btn-success btn-sm mb-3" Text="Guardar cambios" OnClick="btnGuardarCambios_Click" />

                    <div class="modal fade" id="modalLeccion" tabindex="-1" aria-labelledby="modalLeccionLabel" aria-hidden="true">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content bg-dark text-white">
                                <div class="modal-header border-0">
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
                                    <asp:Button ID="btnGuardarLeccion" runat="server" CssClass="btn btn-success" Text="Guardar" OnClick="btnGuardarModulo_Click" />
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
    </script>

</asp:Content>

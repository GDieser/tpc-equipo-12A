﻿<%@ Page Title="" Language="C#"
    MasterPageFile="~/Aula.Master" AutoEventWireup="true" CodeBehind="Leccion.aspx.cs" Inherits="TPC_Equipo_12A.Leccion" ValidateRequest="false" %>

<asp:Content ID="Content2" ContentPlaceHolderID="AulaContent" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true" />

    <style>
        .cke_dialog_ui_input_text {
            z-index: 10055 !important;
        }

        .cke_dialog {
            z-index: 10055 !important; /* mayor que el modal de Bootstrap (1050) */
        }

        .literal {
            color: rgb(182, 180, 159);
        }

            .literal h1,
            .literal h2,
            .literal h3,
            .literal h4,
            .literal h5,
            .literal h6 {
                color: darkcyan;
            }
    </style>
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <div class="container p-3">
                <div class="container mt-4 mb-4">
                    <asp:PlaceHolder runat="server" ID="phContenido" Visible="false">
                        <div class="card text-white bg-dark border-secondary mb-4">
                            <div class="card-header border-secondary">
                                <div class="d-flex justify-content-between gap-2">
                                    <h1>
                                        <strong>📝 Editar lección</strong>
                                    </h1>
                                    <div class="d-flex justify-content-end gap-2">
                                        <asp:Button ID="Button1"
                                            runat="server"
                                            Text="💾 Guardar"
                                            CssClass="btn btn-success"
                                            OnClientClick="sincronizarEditor(); return true;"
                                            OnClick="btnGuardarContenido_Click" />
                                        <asp:Button ID="Button2"
                                            runat="server"
                                            Text="❌ Cancelar"
                                            CssClass="btn btn-outline-light"
                                            OnClick="btnCancelarEdicion_Click"
                                            CausesValidation="false" />
                                    </div>
                                </div>
                            </div>
                            <div class="card-body">

                                <div class="mb-3">
                                    <label for="txtTitulo" class="form-label">Título</label>
                                    <asp:TextBox ID="txtTitulo" runat="server" CssClass="form-control bg-dark text-white" />
                                </div>
                                <asp:RequiredFieldValidator
                                    ID="rfvTitulo"
                                    runat="server"
                                    ControlToValidate="txtTitulo"
                                    CssClass="text-danger"
                                    ErrorMessage="⚠️ El título es obligatorio"
                                    Display="Dynamic" />


                                <div class="mb-3">
                                    <label for="txtIntroduccion" class="form-label">Introducción</label>
                                    <asp:TextBox ID="txtIntroduccion" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control bg-dark text-white" />
                                </div>
                                <asp:RequiredFieldValidator
                                    ID="rfvIntroduccion"
                                    runat="server"
                                    ControlToValidate="txtIntroduccion"
                                    CssClass="text-danger"
                                    ErrorMessage="⚠️ La introducción no puede estar vacía"
                                    Display="Dynamic" />


                                <!-- Agregado para videos de yt -->
                                <div class="mb-3">
                                    <label class="form-label">URL Video</label>
                                    <asp:TextBox ID="txtUrl" runat="server" Placeholder="URL de YouTube" CssClass="form-control bg-dark text-white fs-5 mb-3" />

                                    <div class="row">
                                        <div class="col-md-6">
                                            <label class="form-label">Ancho del Video</label>
                                            <asp:TextBox ID="txtAncho" runat="server" Placeholder="Ancho" CssClass="form-control bg-dark text-white" />
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label">Alto del Video</label>
                                            <asp:TextBox ID="txtAlto" runat="server" Placeholder="Alto" CssClass="form-control bg-dark text-white" />
                                        </div>
                                    </div>
                                </div>
                                <!-- Agregado para videos de yt -->

                                <div class="mb-3">
                                    <label for="txtContenidoHTML" class="form-label">Contenido</label>
                                    <textarea id="txtContenidoHTML" runat="server" class="form-control bg-dark text-white" rows="20"></textarea>
                                    <script>
                                        CKEDITOR.replace('<%= txtContenidoHTML.ClientID %>', {
                                            extraAllowedContent: 'iframe[*]',
                                            contentsCss: ['https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css'],
                                            height: 1000
                                        });
                                    </script>
                                </div>

                                <div class="d-flex justify-content-end gap-2">
                                    <asp:Button ID="btnGuardarContenido"
                                        runat="server"
                                        Text="💾 Guardar"
                                        CssClass="btn btn-success"
                                        OnClientClick="sincronizarEditor(); return true;"
                                        OnClick="btnGuardarContenido_Click" />
                                    <asp:Button ID="btnCancelarEdicion"
                                        runat="server"
                                        Text="❌ Cancelar"
                                        CssClass="btn btn-outline-light"
                                        OnClick="btnCancelarEdicion_Click"
                                        CausesValidation="false" />
                                </div>
                            </div>
                        </div>
                    </asp:PlaceHolder>

                    <asp:PlaceHolder ID="phCuerpo" runat="server">
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item">Curso: <a href='<%= "Curso.aspx?id=" + IdCurso.ToString() %>'><%= NombreCurso %></a>
                                </li>
                                <li><strong>/</strong></li>
                                <li class="breadcrumb-item">
                                    <a><%= NombreModulo %></a>
                                </li>

                            </ol>
                        </nav>
                        <hr />
                        <asp:Button Text="← Volver a modulos" CssClass="btn btn-secondary float-end" runat="server" ID="btnAtras" OnClick="btnAtras_Click"/>
                        <h1 class="text-success">
                            <asp:Literal ID="litTitulo" runat="server" /></h1>
                        
                        <div class="d-flex justify-content-between align-items-center">
                            <h5 class="text-secondary mb-0">
                                <asp:Literal ID="litDescripcion" runat="server" />
                            </h5>
                            <asp:Button ID="btnAgregarContenido"
                                runat="server"
                                CssClass="btn btn-primary btn-sm mb-3"
                                Text="Editar Contenido"
                                OnClick="btnAgregarContenido_Click" />
                        </div>
                        <hr />

                        <div style="text-align: center;">
                            <asp:Literal ID="litIframe" runat="server" />
                        </div>


                        <hr class="mt-2 mb-2" />
                        <div class="literal">
                            <asp:Literal ID="litContenido" runat="server" />
                        </div>

                        <hr class="mt-2 mb-2" />
                        <div class="text-end">
                            <asp:Button Text="Marcar como completada" CssClass="btn btn-success" runat="server" ID="btnMarcarCompletada" OnClick="btnMarcarCompletada_Click" />
                        </div>

                        <div class="d-flex justify-content-between mt-4">
                            <% if (IdAnterior != null)
                                { %>
                            <a href='Leccion.aspx?id=<%= IdAnterior %>' class="btn btn-primary">⬅ Anterior
                            </a>
                            <% }
                                else
                                { %>
                            <span></span><% %>
                            <% } %>

                            <% if (IdSiguiente != null)
                                { %>
                            <a href='Leccion.aspx?id=<%= IdSiguiente %>' class="btn btn-primary">Siguiente ➡
                            </a>
                            <%}
                                else
                                {  %>

                            <a href='<%= "Curso.aspx?id=" + IdCurso.ToString() %>' class="btn btn-warning">🔄Volver a modulos</a>
                            <%} %>
                        </div>

                    </asp:PlaceHolder>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <script>
        var editorId = '<%= txtContenidoHTML.ClientID %>';

        function createEditor() {
            if (!CKEDITOR.instances[editorId]) {
                CKEDITOR.replace(editorId, {
                    extraAllowedContent: 'iframe[*]',
                    contentsCss: ['https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css'],
                    height: 1000
                });
            }
        }

        function destroyEditor() {
            if (CKEDITOR.instances[editorId]) {
                CKEDITOR.instances[editorId].destroy(true);
            }
        }
        Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(function () {
            destroyEditor();
        });

        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
            createEditor();
        });

        document.addEventListener('DOMContentLoaded', function () {
            createEditor();
        });

        function sincronizarEditor() {
            for (var instance in CKEDITOR.instances)
                CKEDITOR.instances[instance].updateElement();
        }
    </script>
</asp:Content>

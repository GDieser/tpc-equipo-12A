<%@ Page Title="" Language="C#"
    MasterPageFile="~/Aula.Master" AutoEventWireup="true" CodeBehind="Leccion.aspx.cs" Inherits="TPC_Equipo_12A.Leccion" ValidateRequest="false" %>

<asp:Content ID="Content2" ContentPlaceHolderID="AulaContent" runat="server">
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
    <div class="container col-xl-8">
        <div class="container mt-4 mb-4">
                        <asp:PlaceHolder runat="server" ID="phContenido" Visible="false">
                <div class="card text-white bg-dark border-secondary mb-4">
                    <div class="card-header border-secondary">
                        <h1>
                        <strong>📝 Editar lección</strong></h1>
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

                        <div class="mb-3">
                            <label for="txtContenidoHTML" class="form-label">Contenido</label>
                            <textarea id="txtContenidoHTML" runat="server" class="form-control bg-dark text-white" rows="10"></textarea>
                            <script>
                                CKEDITOR.replace('<%= txtContenidoHTML.ClientID %>', {
                                    extraAllowedContent: 'iframe[*]',
                                    contentsCss: ['https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css']
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
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item">
                        Curso: <a href='<%= "Curso.aspx?id=" + IdCurso.ToString() %>'><%= NombreCurso %></a>
                    </li>
                    <li> <strong>/</strong></li>
                    <li class="breadcrumb-item">
                        <a href='<%= "Modulo.aspx?id=" + IdModulo.ToString() %>'><%= NombreModulo %></a>
                    </li>

                </ol>
            </nav>
            <hr />
            <asp:PlaceHolder ID="phCuerpo" runat="server">
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
                <hr class="mt-2 mb-2" />
                <div class="literal">
                    <asp:Literal ID="litContenido" runat="server" />
                </div>

                <hr class="mt-2 mb-2" />
                <div class="text-end">
                    <asp:Button Text="Marcar como completada" CssClass="btn btn-primary" runat="server" ID="btnMarcarCompletada" OnClick="btnMarcarCompletada_Click" />
                </div>
            </asp:PlaceHolder>
        </div>
    </div>
    <script>
        function sincronizarEditor() {
            for (var instance in CKEDITOR.instances)
                CKEDITOR.instances[instance].updateElement();
        }
    </script>
</asp:Content>

<%@ Page Title="" Language="C#" ValidateRequest="false" MasterPageFile="~/Aula.Master" AutoEventWireup="true" CodeBehind="ForoCurso.aspx.cs" Inherits="TPC_Equipo_12A.ForoCurso" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AulaContent" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true" />
    <style>
        .img-banner-curso {
            width: 100%;
            height: 25vh;
            object-fit: cover;
        }
    </style>

    <style>
        .hover-effect:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 173, 181, 0.1);
            transition: all 0.2s ease;
            border-color: #0dcaf0 !important;
        }

        .card {
            transition: all 0.2s ease;
        }

        .text-decoration-none:hover {
            color: #0dcaf0 !important;
        }
    </style>

    <asp:Panel ID="phCuerpo" runat="server" CssClass="card bg-dark text-white p-4 mb-4 shadow" Visible="true">

        <div class="container p-3">

            <div class="container mt-4">

                <div class="mb-4 text-center">
                    <asp:Image ID="imgBannerCurso" runat="server" CssClass="img-fluid rounded shadow img-banner-curso" />
                </div>

                <div class="d-flex justify-content-between align-items-center mb-4">

                    <h2 class="fw-bold mb-0" style="background: linear-gradient(90deg, #0dcaf0, #0d6efd); -webkit-background-clip: text; background-clip: text; color: transparent; font-size: 2.2rem; text-shadow: 0 2px 4px rgba(13, 110, 253, 0.2);">
                        <asp:Literal ID="litTituloCurso" runat="server" />
                    </h2>

                    <asp:Button Text="Continuar lecciones 🡪" ID="btnLecciones" CssClass="btn btn-primary text-white fw-bold py-2 px-4" OnClick="btnLecciones_Click" runat="server"
                        Style="font-size: 1.1rem; transition: all 0.3s ease; position: relative; padding-right: 2.5rem !important;" />
                </div>
            </div>
        </div>
        <hr />

        <div class="mb-4">

            <div class="d-flex justify-content-between align-items-center mb-3">
                <h4 class="mb-0 text-info">
                    <i class="bi bi-megaphone-fill me-2"></i>Avisos
                </h4>
                <asp:Button ID="btnAviso" Text="Nuevo aviso" Visible="false" CssClass="btn btn-success btn-sm text-white" OnClick="btnAviso_Click" runat="server" />
            </div>

            <div class="mt-3">
                <asp:Repeater ID="rptAvisos" runat="server">
                    <ItemTemplate>
                        <div class="card mb-3 bg-dark border border-secondary hover-effect">
                            <div class="card-body p-3">
                                <div class="d-flex justify-content-between align-items-start">
                                    <div class="flex-grow-1 me-3">
                                        <a href='ForoDetalle.aspx?id=<%# Eval("IdDebate") %>'
                                            class="text-white fw-bold text-decoration-none d-block mb-1">
                                            <i class="bi bi-pin-angle-fill text-warning me-2"></i>
                                            <%# Eval("Titulo") %>
                                        </a>
                                        <div class="small">
                                            <span class="text-white"><%# Eval("NombreUsuario") %> - 
                                    <%# Eval("FechaCreacion", "{0:dd/MM/yyyy}") %></span>
                                        </div>
                                    </div>
                                    <div class="d-flex align-items-center">
                                        <span class="badge bg-info text-dark">
                                            <i class="bi bi-chat-square-text me-1"></i>
                                            <%# Eval("CantidadComentarios") %>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:Label runat="server" Visible='<%# rptAvisos.Items.Count == 0 %>'
                            Text="No hay avisos publicados" CssClass="small" />
                    </FooterTemplate>
                </asp:Repeater>
            </div>
        </div>

        <hr class="border-secondary my-4" />

        <div class="mb-4">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h4 class="mb-0 text-info">
                    <i class="bi bi-chat-square-text-fill me-2"></i>Foro de Dudas
                </h4>
                <asp:Button ID="btnMdlHilo" Text="Nuevo hilo de debate" OnClick="btnMdlHilo_Click" CssClass="btn btn-success btn-sm text-white"
                    runat="server" />
            </div>

            <div class="mt-3">
                <asp:Repeater ID="rptHilos" runat="server">
                    <ItemTemplate>
                        <div class="card mb-3 bg-dark border border-secondary hover-effect">
                            <div class="card-body p-3">
                                <div class="d-flex justify-content-between align-items-start">
                                    <div class="flex-grow-1 me-3">
                                        <a href='ForoDetalle.aspx?id=<%# Eval("IdDebate") %>'
                                            class="text-white fw-bold text-decoration-none d-block mb-1">
                                            <i class="bi bi-chat-left-text me-2"></i>
                                            <%# Eval("Titulo") %>
                                        </a>
                                        <div class="d-flex align-items-center small text-muted">
                                            <img src='<%# Eval("UrlImagen") %>' alt="Perfil"
                                                class="rounded-circle me-2" style="width: 24px; height: 24px; object-fit: cover;" />
                                            <span class="text-white"><%# Eval("NombreUsuario") %> - 
                                    <%# Eval("FechaCreacion", "{0:dd/MM/yyyy}") %></span>
                                        </div>
                                    </div>
                                    <div class="d-flex align-items-center">
                                        <span class="badge bg-secondary">
                                            <i class="bi bi-chat-square-text me-1"></i>
                                            <%# Eval("CantidadComentarios") %>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:Label runat="server" Visible='<%# rptHilos.Items.Count == 0 %>'
                            Text="No hay hilos de discusión" CssClass="text-muted small" />
                    </FooterTemplate>
                </asp:Repeater>
            </div>
        </div>


    </asp:Panel>


    <asp:Panel ID="phNuevoAviso" runat="server" CssClass="card bg-dark text-white p-4 mb-4 shadow" Visible="false">

        <h4 class="mb-3 text-info">Agregar nuevo aviso</h4>

        <div class="mb-3">
            <label for="txtTitulo" class="form-label fw-bold">Título:</label>
            <asp:TextBox ID="txtTitulo" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2" />

        </div>

        <div class="mb-3">
            <label for="txtContenido" class="form-label fw-bold">Contenido del aviso:</label>
            <asp:TextBox ID="txtContenido" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="8" />

        </div>
        <div class="d-flex justify-content-end">
            <asp:Button ID="btnAgregarAviso" runat="server" CssClass="btn btn-success mt-3" Text="Aceptar" OnClick="btnAgregarAviso_Click" />
            <asp:Button ID="btnCancelarAviso" runat="server" CssClass="btn btn-outline-light mt-3 ms-2" Text="Cancelar" OnClick="btnCancelarAviso_Click" />
        </div>
        <script>
            CKEDITOR.replace('<%= txtContenido.ClientID %>', {
                height: '300px',
                extraAllowedContent: 'iframe[width,height,src,frameborder,allow,allowfullscreen,referrerpolicy,sandbox,title];',
                removeButtons: '',
                removePlugins: 'iframe',
                extraPlugins: 'iframe',
                filebrowserBrowseUrl: '',
                filebrowserUploadUrl: '',
                customConfig: ''
            });
        </script>

    </asp:Panel>

    <asp:Panel ID="phNuevoHilo" runat="server" CssClass="card bg-dark text-white p-4 mb-4 shadow" Visible="false">

        <h4 class="mb-3 text-info">Agregar nuevo hilo de debate</h4>

        <div class="mb-3">
            <label for="txtTituloHilo" class="form-label fw-bold">Título:</label>
            <asp:TextBox ID="txtTituloHilo" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" />

        </div>

        <div class="mb-3">
            <label for="txtContenidoHilo" class="form-label fw-bold">Contenido del hilo:</label>
            <textarea id="txtContenidoHilo" runat="server" class="form-control" rows="8"></textarea>

        </div>

        <div class="d-flex justify-content-end">
            <asp:Button ID="btnAgregarHilo" runat="server" CssClass="btn btn-success mt-3 ms-2" Text="Aceptar" OnClick="btnAgregarHilo_Click" />

            <asp:Button ID="btnCancelarHilo" runat="server" CssClass="btn btn-outline-light mt-3" Text="Cancelar" OnClick="btnCancelarHilo_Click" />
        </div>

        <script>
            CKEDITOR.replace('<%= txtContenidoHilo.ClientID %>', {
                height: '300px',
                toolbar: [
                    { name: 'basicstyles', items: ['Bold', 'Italic', 'Underline'] },
                    { name: 'paragraph', items: ['NumberedList', 'BulletedList'] },
                    { name: 'clipboard', items: ['Undo', 'Redo'] },
                    { name: 'links', items: ['Link', 'Unlink'] }
                ],
                extraAllowedContent: 'iframe[width,height,src,frameborder,allow,allowfullscreen,referrerpolicy,sandbox,title];',
                removePlugins: 'iframe',
                extraPlugins: 'iframe',
                filebrowserBrowseUrl: '',
                filebrowserUploadUrl: ''
            });
        </script>

    </asp:Panel>


</asp:Content>

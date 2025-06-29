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

    <asp:Panel ID="phCuerpo" runat="server" CssClass="card bg-dark text-white p-4 mb-4 shadow" Visible="true">

        <div class="container p-3">

            <div class="container mt-4">

                <div class="mb-4 text-center">
                    <asp:Image ID="imgBannerCurso" runat="server" CssClass="img-fluid rounded shadow img-banner-curso" />
                </div>

                <h2 class="text-primary fw-bold">
                    <asp:Literal ID="litTituloCurso" runat="server" />

                </h2>
                <div class="text-end">
                    <asp:Button Text="Seguir con las lecciones" ID="btnLecciones" CssClass="btn btn-primary text-white" OnClick="btnLecciones_Click" runat="server" />
                </div>
            </div>
        </div>
        <hr />

        <div class="mb-4">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h4 class="mb-0">Avisos:</h4>
                <asp:Button ID="btnAviso" Text="Agregar nuevo aviso" CssClass="btn btn-success text-white" OnClick="btnAviso_Click" runat="server" />

            </div>
            <div class="container mt-4">
            </div>
        </div>

        <div class="mb-3">
            <div class="">
                <asp:Repeater ID="rptAvisos" runat="server">
                    <ItemTemplate>
                        <div class="card mb-3 bg-dark bg-gradient text-white">
                            <div class="card-body d-flex justify-content-between align-items-center border-top border-bottom border-secondary">
                                <div style="width: 40%;">
                                    <a href='ForoDetalle.aspx?id=<%# Eval("IdDebate") %>' class="text-white fs-6 fw-bold text-decoration">
                                        <%# Eval("Titulo") %>
                                    </a>
                                </div>
                                <div class="d-flex align-items-center">
                                    <img src='<%# Eval("UrlImagen") %>' alt="Perfil"
                                        class="rounded-circle me-2" style="width: 32px; height: 32px; object-fit: cover;" />
                                    <small><%# Eval("NombreUsuario") %></small>
                                </div>
                                <div><small><%# Eval("FechaCreacion", "{0:dd/MM/yyyy}") %></small></div>
                                <div><span class="badge bg-light text-dark"><%# Eval("CantidadComentarios") %> respuestas</span></div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>


        <hr />
        <div class="mb-4">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h4 class="mb-0">Foro de Dudas:</h4>

                <asp:Button ID="btnMdlHilo" Text="Agregar nuevo hilo de debate" OnClick="btnMdlHilo_Click" CssClass="btn btn-success text-white" runat="server" />


            </div>
            <div class="container mt-4">
            </div>
        </div>

        <div class="mb-4">
            <div class="">
                <asp:Repeater ID="rptHilos" runat="server">
                    <ItemTemplate>
                        <div class="card mb-3 bg-dark bg-gradient text-white">
                            <div class="card-body d-flex justify-content-between align-items-center border-top border-bottom border-secondary">
                                <div style="width: 40%;">
                                    <a href='ForoDetalle.aspx?id=<%# Eval("IdDebate") %>' class="text-white fs-6 fw-bold text-decoration">
                                        <%# Eval("Titulo") %>
                                    </a>
                                </div>
                                <div class="d-flex align-items-center">
                                    <img src='<%# Eval("UrlImagen") %>' alt="Perfil"
                                        class="rounded-circle me-2" style="width: 32px; height: 32px; object-fit: cover;" />
                                    <small><%# Eval("NombreUsuario") %></small>
                                </div>
                                <div><small><%# Eval("FechaCreacion", "{0:dd/MM/yyyy}") %></small></div>
                                <div><span class="badge bg-light text-dark"><%# Eval("CantidadComentarios") %> respuestas</span></div>
                            </div>
                        </div>
                    </ItemTemplate>
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

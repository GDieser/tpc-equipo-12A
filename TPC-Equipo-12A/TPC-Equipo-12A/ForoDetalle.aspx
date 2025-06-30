<%@ Page Title="" Language="C#" MasterPageFile="~/Aula.Master" AutoEventWireup="true" CodeBehind="ForoDetalle.aspx.cs" ValidateRequest="false" Inherits="TPC_Equipo_12A.ForoDetalle" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AulaContent" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" />

    <script>
        function abrirModal() {
            var modal = new bootstrap.Modal(document.getElementById('exampleModal'));
            modal.show();
        }
    </script>

    <script>
        function limpiarModal() {
            document.getElementById('<%= ddlReporte.ClientID %>').value = '0';
        }

        function abrirModalReporte(idComentario) {

            document.getElementById('<%= hfComentarioReportado.ClientID %>').value = idComentario;


            var modalEl = document.getElementById('exampleModal');
            var modal = bootstrap.Modal.getOrCreateInstance(modalEl);
            modal.show();
        }

        function abrirModalEliminar(idComentario) {

            document.getElementById('<%= hfEliminar.ClientID %>').value = idComentario;


            var modalEl = document.getElementById('modalEliminar');
            var modal = bootstrap.Modal.getOrCreateInstance(modalEl);
            modal.show();
        }

        function abrirModalEdicion(idComentario, contenido) {
            document.getElementById('<%= hfIdComentarioEditar.ClientID %>').value = idComentario;
            document.getElementById('<%= txtComentarioEditado.ClientID %>').value = contenido;
            var modal = new bootstrap.Modal(document.getElementById('modalEdicion'));
            modal.show();
        }

        function abrirModalEliminarHilo(idDebate) {
            document.getElementById('<%= hfEliminarHilo.ClientID %>').value = idDebate;

            var modalEl = document.getElementById('modalEliminarHilo');
            var modal = bootstrap.Modal.getOrCreateInstance(modalEl);
            modal.show();
        }

    </script>
    <div class="container mt-3">

        <asp:Panel ID="phCuerpo" runat="server" CssClass="card bg-dark text-white p-4 mb-4 shadow" Visible="true">

            <div class="bg-black-tertiary rounded p-3 mb-4 border border-secondary">

                <div class="d-flex justify-content-between align-items-center mb-2">
                    <h2 class="h2 text-info mb-0">
                        <asp:Literal ID="litTitulo" runat="server" />
                    </h2>

                    <div>
                        <asp:Button ID="btnVolver" runat="server" CssClass="btn btn-sm btn-outline-light" Text="← Volver" OnClick="btnVolver_Click" />

                        <%if (usuarioAutenticado.Rol == Dominio.Rol.Administrador && debate != null)
                            {  %>
                        <button class="btn btn-sm btn-outline-danger" type="button" onclick="abrirModalEliminarHilo(<%= debate.IdDebate %>)">X</button>
                        <%} %>

                        <% if (puedeEditar)
                            { %>
                        <asp:Button ID="btnEditarHilo" runat="server" Text="Editar Hilo" CssClass="btn btn-primary" OnClick="btnEditarHilo_Click" />
                        <% } %>
                    </div>
                </div>

                <hr />

                <div class="d-flex align-items-center mb-3">
                    <asp:Image ID="imgPerfil" runat="server" CssClass="rounded-circle me-2" Width="40px" Height="40px" Style="object-fit: cover;" />
                    <div class="small text-white">
                        <span class="text-white">
                            <h4 class="h4 mb-0">
                                <asp:Literal ID="litNombreCompleto" runat="server" />
                            </h4>
                        </span>(<asp:Literal ID="litNombreUsuario" runat="server" />) · 
                    <asp:Literal ID="litFecha" runat="server" />
                    </div>
                </div>

                <div class="bg-dark rounded p-3 mb-3" style="white-space: pre-line;">
                    <h6 class="h6 mb-0">
                        <asp:Literal ID="litContenido" runat="server" />
                    </h6>
                </div>
            </div>


            <hr />

            <asp:UpdatePanel ID="upComentarios" runat="server" UpdateMode="Conditional">
                <ContentTemplate>

                    <asp:Panel ID="pnlComentarios" runat="server" Visible="false">
                        <h4>
                            <asp:Label ID="lblCantidadComentarios" runat="server" /></h4>

                        <asp:TextBox runat="server" ID="txtAgregarComentario" Visible="false" CssClass="form-control form-control-lg bg-dark-subtle" placeholder="Agregar comentario..." />

                        <asp:Button Text="Agregar" runat="server" ID="btnAgregarComentario" Visible="false" OnClick="btnAgregarComentario_Click" CssClass="btn btn-secondary btn-lg px-4 mt-3" />

                        <hr />

                        <asp:Repeater ID="rptComentario" OnItemCommand="rptComentario_ItemCommand" runat="server">
                            <ItemTemplate>
                                <div class="d-flex mb-3">


                                    <img src='<%# Eval("UrlImagen") %>' alt="img" class="rounded-circle" style="width: 48px; height: 48px; object-fit: cover; margin-right: 25px;" />
                                    <div class="flex-grow-1">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div>
                                                <strong><%# Eval("NombreUsuario") %></strong> - <small><%# ((DateTime)Eval("FechaCreacion")).ToString("dd/MM/yyyy HH:mm") %></small>
                                            </div>
                                            <div>
                                                <%if (usuarioAutenticado != null)
                                                    {  %>

                                                <button class="btn btn-outline-secondary btn-sm" type="button" style="padding: 0.1rem 0.30rem; font-size: 0.6rem;"
                                                    onclick="abrirModalReporte('<%# Eval("IdComentario") %>')">
                                                    !
                                                </button>

                                                <%if (usuarioAutenticado.Rol == Dominio.Rol.Administrador)
                                                    {  %>
                                                <button class="btn btn-outline-danger btn-sm" type="button" style="padding: 0.1rem 0.30rem; font-size: 0.6rem;"
                                                    onclick="abrirModalEliminar('<%# Eval("IdComentario") %>')">
                                                    x
                                                </button>
                                                <%} %>

                                                <%} %>
                                            </div>
                                        </div>
                                        <br />
                                        <p><%# Eval("Contenido") %></p>

                                        <%if (usuarioAutenticado != null)
                                            {  %>
                                        <asp:LinkButton Text="Responder" ID="btnResponder" CommandName="Responder" CommandArgument='<%# Eval("IdComentario") %>' CssClass="btn btn-outline-secondary btn-sm mt-1" runat="server" />

                                        <asp:HiddenField ID="hfIdComentarioPadre" runat="server" Value='<%# Eval("IdComentario") %>' />

                                        <asp:Panel ID="pnlResponder" runat="server" Visible="false" CssClass="mt-2">
                                            <asp:TextBox ID="txtRespuesta" runat="server" CssClass="form-control form-control-lg bg-dark-subtle" placeholder="Escribí una respuesta..." />
                                            <asp:Button Text="Enviar" runat="server" ID="btnEnviarRespuesta" CommandArgument='<%# Eval("IdComentario") + "|" + Eval("NombreUsuario") %>' CommandName="EnviarRespuesta" CssClass="btn btn-outline-secondary btn-sm mt-1" />
                                        </asp:Panel>
                                        <%} %>


                                        <%# PuedeEditarComentario((int)Eval("IdUsuario"), (DateTime)Eval("FechaCreacion")) ? 
                                     "<button class='btn btn-outline-info btn-sm ms-1' onclick=\"abrirModalEdicion('" + Eval("IdComentario") + "','" + Eval("Contenido") + "')\">Editar</button>" 
                                        : "" %>

                                        <asp:Repeater ID="rptRespuestas" OnItemCommand="rptRespuestas_ItemCommand" runat="server" DataSource='<%# Eval("Respuestas") %>'>
                                            <ItemTemplate>
                                                <hr />
                                                <div class="d-flex mb-3">

                                                    <img src='<%# Eval("UrlImagen") %>' alt="img" class="rounded-circle"
                                                        style="width: 40px; height: 40px; object-fit: cover; margin-right: 20px;" />
                                                    <div class="flex-grow-1">
                                                        <div class="d-flex justify-content-between align-items-center mb-1">
                                                            <div>
                                                                <strong><%# Eval("NombreUsuario") %></strong>
                                                                <small class="text-secundary">- <%# ((DateTime)Eval("FechaCreacion")).ToString("dd/MM/yyyy HH:mm") %></small>

                                                            </div>
                                                            <div>
                                                                <%if (usuarioAutenticado != null)
                                                                    {  %>

                                                                <button class="btn btn-outline-secondary btn-sm" type="button" style="padding: 0.1rem 0.30rem; font-size: 0.6rem;"
                                                                    onclick="abrirModalReporte('<%# Eval("IdComentario") %>')">
                                                                    !
                                                                </button>

                                                                <%if (usuarioAutenticado.Rol == Dominio.Rol.Administrador)
                                                                    {  %>
                                                                <button class="btn btn-outline-danger btn-sm" type="button" style="padding: 0.1rem 0.30rem; font-size: 0.6rem;"
                                                                    onclick="abrirModalEliminar('<%# Eval("IdComentario") %>')">
                                                                    x
                                                                </button>
                                                                <%} %>

                                                                <%} %>
                                                            </div>


                                                        </div>
                                                        <p class="mb-2"><%# Eval("Contenido") %></p>

                                                    </div>

                                                </div>
                                                <%# PuedeEditarComentario((int)Eval("IdUsuario"), (DateTime)Eval("FechaCreacion")) ? 
                                            "<button class='btn btn-outline-info btn-sm ms-1' onclick=\"abrirModalEdicion('" + Eval("IdComentario") + "','" + Eval("Contenido") + "')\">Editar</button>" 
                                               : "" %>
                                                <%if (usuarioAutenticado != null)
                                                    {  %>

                                                <asp:LinkButton Text="Responder" ID="btnResponderRespuesta" CommandName="ResponderRespuesta" CommandArgument='<%# Eval("IdComentarioPadre") %>' CssClass="btn btn-outline-secondary btn-sm mt-1" runat="server" />
                                                <asp:HiddenField ID="hfIdComentarioRespuesta" runat="server" Value='<%# Eval("IdComentarioPadre") %>' />

                                                <asp:Panel ID="pnlReRespuesta" Visible="false" CssClass="mt-2" runat="server">
                                                    <asp:TextBox ID="txtReRespuesta" CssClass="form-control form-control-lg bg-dark-subtle" placeholder="Escribí una respuesta..." runat="server" />
                                                    <asp:Button Text="Enviar" runat="server" ID="btnEnviarReRespuesta" CommandArgument='<%# Eval("IdComentarioPadre") + "|" + Eval("NombreUsuario") %>' CommandName="EnviarReRespuesta" CssClass="btn btn-outline-secondary btn-sm mt-1" />
                                                </asp:Panel>

                                                <%} %>
                                            </ItemTemplate>
                                        </asp:Repeater>

                                    </div>
                                </div>
                                <hr />
                            </ItemTemplate>
                        </asp:Repeater>

                    </asp:Panel>
                </ContentTemplate>
            </asp:UpdatePanel>
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
                <asp:Button ID="btnEditarAviso" runat="server" CssClass="btn btn-success mt-3" Text="Aceptar" OnClick="btnEditarAviso_Click" />
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
                <asp:Button ID="btnEditHilo" runat="server" CssClass="btn btn-success mt-3 ms-2" Text="Aceptar" OnClick="btnEditHilo_Click" />

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



        <div class="modal fade bg-dark p-2 text-dark bg-opacity-50" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content bg-dark p-2 text-white">
                    <div class="modal-header">

                        <h2 class="modal-title fs-5" id="exampleModalLabel">Reportar</h2>

                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <asp:HiddenField ID="hfComentarioReportado" runat="server" />
                        <div class="mb-3">
                            <asp:Label runat="server" AssociatedControlID="ddlReporte" Text="Motivo del Reporte:" />
                            <asp:DropDownList runat="server" ID="ddlReporte" CssClass="form-select">
                                <asp:ListItem Text="Inapropiado" Value="0" />
                                <asp:ListItem Text="Spam" Value="1" />
                                <asp:ListItem Text="Ofensivo" Value="2" />
                                <asp:ListItem Text="Violento" Value="3" />
                            </asp:DropDownList>
                        </div>

                    </div>
                    <div class="modal-footer">
                        <asp:Button Text="Enviar" CssClass="btn btn-success mt-4" ID="btnEnviar" OnClick="btnEnviar_Click" runat="server" />

                    </div>
                </div>
            </div>
        </div>


        <div class="modal fade bg-dark p-2 text-dark bg-opacity-50 " id="modalEliminar" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content bg-dark p-2 text-white">
                    <div class="modal-header">

                        <h2 class="modal-title fs-5" id="lblModalEliminar">¿Eliminar comentario?</h2>

                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <asp:HiddenField ID="hfEliminar" runat="server" />

                    <div class="modal-footer">
                        <asp:Button Text="Aceptar y eliminar" CssClass="btn btn-danger mt-4" ID="btnEliminarComentario" OnClick="btnEliminarComentario_Click" runat="server" />

                    </div>
                </div>
            </div>
        </div>


        <div class="modal fade bg-dark p-2 text-dark bg-opacity-50" id="modalEdicion" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content bg-dark p-2 text-white">
                    <div class="modal-header">
                        <h5 class="modal-title">Editar comentario</h5>
                    </div>
                    <div class="modal-body">
                        <asp:HiddenField ID="hfIdComentarioEditar" runat="server" />
                        <asp:TextBox ID="txtComentarioEditado" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <asp:Button ID="btnGuardarEdicion" runat="server" OnClick="btnGuardarEdicion_Click" Text="Guardar" CssClass="btn btn-primary" />
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade bg-dark p-2 text-dark bg-opacity-50" id="modalEliminarHilo" tabindex="-1" aria-labelledby="lblModalEliminarHilo" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content bg-dark p-2 text-white">
                    <div class="modal-header">
                        <h2 class="modal-title fs-5" id="lblModalEliminarHilo">¿Eliminar hilo de debate?</h2>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>

                    <asp:HiddenField ID="hfEliminarHilo" runat="server" />

                    <div class="modal-footer">
                        <asp:Button Text="Eliminar" CssClass="btn btn-danger mt-4" ID="btnEliminarHilo" OnClick="btnEliminarHilo_Click" runat="server" />
                    </div>
                </div>
            </div>
        </div>

    </div>


</asp:Content>

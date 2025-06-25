<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="DetalleNovedad.aspx.cs" Inherits="TPC_Equipo_12A.DetalleNovedad" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

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

    </script>



    <div class="container">
        <div class="col">
            <hr />
            <div>
                <asp:Label ID="lblTitulo" runat="server"
                    Style="font-size: 40px; font-weight: bold; margin-bottom: 15px; display: block;" />
                <asp:Button Text="Modificar" CssClass="btn btn-danger" ID="btnModificar" OnClick="btnModificar_Click" runat="server" />
            </div>

            <div>
                <asp:Label ID="lblFechaPublicacion" runat="server"
                    Style="font-size: 14px; margin-bottom: 10px; display: block;" />
            </div>

            <div class="text-center">
                <asp:Image ID="imgBanner" runat="server"
                    ImageUrl="imageurl"
                    Style="width: 600px; height: auto; margin-bottom: 15px;" />
            </div>
            <hr />
            <div>
                <asp:Label ID="lblResumen" runat="server"
                    Style="margin-bottom: 10px; display: block;" />
            </div>

            <!--
        <div>
            <asp:Label ID="lblDescripcion" runat="server"
                Style="font-size: 18px; margin-bottom: 10px; display: block;" />
        </div>-->

            <hr />
            <asp:Literal ID="litDescripcion" runat="server" Mode="PassThrough"></asp:Literal>

        </div>

        <asp:Repeater runat="server">
            <ItemTemplate>
            </ItemTemplate>
        </asp:Repeater>

        <hr />

        <asp:UpdatePanel ID="upComentarios" runat="server" UpdateMode="Conditional">
            <ContentTemplate>

                <asp:Panel ID="pnlComentarios" runat="server" Visible="false">
                    <h4>
                        <asp:Label ID="lblCantidadComentarios" runat="server" /></h4>
                    <%if (usuarioAutenticado != null)
                        {  %>
                    <asp:TextBox runat="server" ID="txtAgregarComentario" CssClass="form-control form-control-lg bg-dark-subtle" placeholder="Agregar comentario..." />


                    <asp:Button Text="Agregar" runat="server" ID="btnAgregarComentario" OnClick="btnAgregarComentario_Click" CssClass="btn btn-dark btn-lg px-4 mt-3" />
                    <%} %>

                    <hr />

                    <asp:Repeater ID="rptComentario" OnItemCommand="rptComentarios_ItemCommand" runat="server">
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
                                        <asp:Button Text="Enviar" runat="server" ID="btnEnviarRespuesta" CommandArgument='<%# Eval("IdComentario") %>' CommandName="EnviarRespuesta" CssClass="btn btn-outline-secondary btn-sm mt-1" />
                                    </asp:Panel>
                                    <%} %>


                                    <%# PuedeEditarComentario((int)Eval("IdUsuario"), (DateTime)Eval("FechaCreacion")) ? 
                                     "<button class='btn btn-outline-info btn-sm ms-1' onclick=\"abrirModalEdicion('" + Eval("IdComentario") + "','" + Eval("Contenido") + "')\">Editar</button>" 
                                        : "" %>

                                    <asp:Repeater ID="rptRespuestas" runat="server" DataSource='<%# Eval("Respuestas") %>'>
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

        <!-- mod repor-->
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
        <!-- mod eliminar-->
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
        <!-- mod edit (queda solucionar tema update panel...)-->
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

    </div>


</asp:Content>


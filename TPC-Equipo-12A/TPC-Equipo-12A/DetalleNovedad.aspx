<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="DetalleNovedad.aspx.cs" Inherits="TPC_Equipo_12A.DetalleNovedad" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:ScriptManager ID="ScriptManager1" runat="server" />

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
                                <div>
                                    <strong><%# Eval("NombreUsuario") %></strong> - <small><%# ((DateTime)Eval("FechaCreacion")).ToString("dd/MM/yyyy HH:mm") %></small>
                                    <br />
                                    <p><%# Eval("Contenido") %></p>

                                    <%if (usuarioAutenticado != null)
                                        {  %>
                                    <asp:LinkButton Text="Responder" ID="btnResponder" CommandName="Responder" CommandArgument='<%# Eval("IdComentario") %>' CssClass="btn btn-outline-secondary btn-sm mt-1" runat="server" />
                                     
                                    <asp:HiddenField ID="hfIdComentarioPadre" runat="server" Value='<%# Eval("IdComentario") %>' />

                                    <asp:Panel ID="pnlResponder" runat="server" Visible="false" CssClass="mt-2">
                                        <asp:TextBox ID="txtRespuesta" runat="server" CssClass="form-control" placeholder="Escribí una respuesta..." />
                                        <asp:Button Text="Enviar" runat="server" ID="btnEnviarRespuesta" CommandArgument='<%# Eval("IdComentario") %>' CommandName="EnviarRespuesta" CssClass="btn btn-outline-secondary btn-sm mt-1" />
                                    </asp:Panel>
                                    <%} %>
                                     
                                    <asp:Repeater ID="rptRespuestas" runat="server" DataSource='<%# Eval("Respuestas") %>'>
                                        <ItemTemplate>
                                            <hr /> 
                                            <div class="d-flex mb-3 ps-5">
                                                
                                                <img src='<%# Eval("UrlImagen") %>' alt="img" class="rounded-circle"
                                                    style="width: 40px; height: 40px; object-fit: cover; margin-right: 20px;" />
                                                <div class="flex-grow-1">
                                                    <div class="d-flex justify-content-between align-items-center mb-1">
                                                        <div>
                                                            <strong><%# Eval("NombreUsuario") %></strong>
                                                            <small class="text-secundary"> - <%# ((DateTime)Eval("FechaCreacion")).ToString("dd/MM/yyyy HH:mm") %></small>
                                                        </div>
                                                    </div>
                                                    <p class="mb-2"><%# Eval("Contenido") %></p>
                                                </div>
                                            </div>
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
    </div>



</asp:Content>


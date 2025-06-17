<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="FormularioPublicacion.aspx.cs" Inherits="TPC_Equipo_12A.NuevaPublicacion" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>


    <div class="container mt-4">

        <h2 class="mb-4">📝 Nueva Publicación</h2>
        <hr />

        <div class="row">

            <div class="col-md-6">

                <div class="mb-3">
                    <label for="txtTitulo" class="form-label fw-bold">Título:</label>
                    <asp:TextBox ID="txtTitulo" runat="server" CssClass="form-control" />
                    <asp:RequiredFieldValidator ID="rfvTitulo" runat="server"
                        ControlToValidate="txtTitulo"
                        ErrorMessage="El titulo es obligatorio."
                        Display="Dynamic" ForeColor="Red" CssClass="small" />
                </div>


                <div class="mb-3">
                    <label for="txtResumen" class="form-label fw-bold">Resumen:</label>
                    <asp:TextBox ID="txtResumen" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control" />
                    <asp:RequiredFieldValidator ID="rfvResumen" runat="server"
                        ControlToValidate="txtResumen"
                        ErrorMessage="El resumen es obligatorio."
                        Display="Dynamic" ForeColor="Red" CssClass="small" />
                </div>


                <div class="mb-3">

                    <label for="txtDes" class="form-label fw-bold">Descripción:</label>

                    <textarea id="txtDes" runat="server" class="form-control" rows="6"></textarea>

                    <asp:RequiredFieldValidator ID="rfvDescripcion" runat="server"
                        ControlToValidate="txtDes"
                        ErrorMessage="La descripción es obligatoria."
                        Display="Dynamic" ForeColor="Red" CssClass="small" />

                    <script>
                        CKEDITOR.replace('<%= txtDes.ClientID %>');
                    </script>

                </div>

                <div class="mb-3">
                    <label for="ddlCategoria" class="form-label fw-bold">Categoria:</label>
                    <asp:DropDownList ID="ddlCategoria" runat="server" CssClass="form-select">
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvCategoria" runat="server"
                        ControlToValidate="ddlCategoria"
                        InitialValue=""
                        ErrorMessage="Debes seleccionar una categoria."
                        Display="Dynamic" ForeColor="Red" CssClass="small" />
                </div>

                <div class="mb-3">
                    <label for="ddlEstado" class="form-label fw-bold">Estado de publicación:</label>
                    <asp:DropDownList ID="ddlEstado" runat="server" CssClass="form-select">
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvEstado" runat="server"
                        ControlToValidate="ddlEstado"
                        InitialValue=""
                        ErrorMessage="Debes seleccionar un estado."
                        Display="Dynamic" ForeColor="Red" CssClass="small" />
                </div>
            </div>

            <div class="col-md-6">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>

                        <div class="mb-3">
                            <label for="txtImagen" class="form-label fw-bold">URL de Imagen (Miniatura):</label>
                            <asp:TextBox ID="txtMiniatura" runat="server" CssClass="form-control" AutoPostBack="true" OnTextChanged="txtImagen_TextChanged" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                ControlToValidate="txtMiniatura"
                                ErrorMessage="Debe ingresar una URL de imagen."
                                Display="Dynamic" ForeColor="Red" CssClass="small" />
                        </div>

                        <div class="text-center mb-3">
                            <asp:Image ID="imgPreviewMin" runat="server" Width="40%" ImageUrl="https://wiratthungsong.com/wts/assets/img/default.png" />
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>

                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
                        <div class="mb-3">
                            <label for="txtImagen" class="form-label fw-bold">URL de Imagen (Banner):</label>
                            <asp:TextBox ID="txtImagen" runat="server" CssClass="form-control" AutoPostBack="true" OnTextChanged="txtImagen_TextChanged" />
                            <asp:RequiredFieldValidator ID="rfvImagen" runat="server"
                                ControlToValidate="txtImagen"
                                ErrorMessage="Debe ingresar una URL de imagen."
                                Display="Dynamic" ForeColor="Red" CssClass="small" />
                        </div>

                        <div class="text-center mb-3">
                            <asp:Image ID="imgPreview" runat="server" Width="60%" ImageUrl="https://wiratthungsong.com/wts/assets/img/default.png" />
                        </div>

                    </ContentTemplate>
                </asp:UpdatePanel>


                <div class="text-center mt-4">
                    <asp:Button ID="btnGuardar" runat="server" Text="Guardar" CssClass="btn btn-primary px-4" OnClick="btnGuardar_Click" />
                    <a href="Novedades.aspx" class="btn btn-danger px-4 ms-2">Cancelar</a>
                </div>
            </div>
        </div>
    </div>

</asp:Content>

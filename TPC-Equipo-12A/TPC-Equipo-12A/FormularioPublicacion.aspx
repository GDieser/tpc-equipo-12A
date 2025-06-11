<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="FormularioPublicacion.aspx.cs" Inherits="TPC_Equipo_12A.NuevaPublicacion" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <br />
    <h1>Nueva Publicación:</h1>
    <hr />
    <div class="row">

        <div class="col-6">

            <h4>Título:</h4>
            <asp:TextBox ID="txtTitulo" runat="server" CssClass="form-control" Style="width: 80%;" />

            <h4>Resumen:</h4>
            <asp:TextBox ID="txtResumen" CssClass="form-control" runat="server"
                TextMode="MultiLine" Rows="2"
                Style="width: 100%; resize: vertical;" />



            <h4>Descripción:</h4>
            <!-- <asp:TextBox ID="txtDescripcion" CssClass="form-control" runat="server"
                TextMode="MultiLine" Rows="6"
                Style="width: 100%; resize: vertical;" /> -->


            <textarea id="txtDes" runat="server" rows="10" cols="60"></textarea>

            <script>
                CKEDITOR.replace('<%= txtDes.ClientID %>');
            </script>


            <h4>Categoría:</h4>
            <asp:DropDownList ID="ddlCategoria" runat="server" CssClass="form-select" Style="width: 60%;" />

            <div class="mb-3">
                <h4>Estado de publicación:</h4>
                <asp:DropDownList ID="ddlEstado" runat="server" CssClass="form-select" Style="width: 60%;" />
            </div>
        </div>

        <div class="col-6">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">

                <ContentTemplate>

                    <h4>URL de Imagen:</h4>


                    <asp:TextBox ID="txtImagen" runat="server" AutoPostBack="true"
                        OnTextChanged="txtImagen_TextChanged"
                        CssClass="form-control"
                        Style="width: 80%;" />
                    <div class="mb-3 mt-4">
                        <asp:Image ImageUrl="https://wiratthungsong.com/wts/assets/img/default.png" ID="imgPreview" runat="server" Width="80%" />
                    </div>
                </ContentTemplate>

            </asp:UpdatePanel>

            <div class="mb-3 mt-4">
                <div class="text-center">
                    <asp:Button Text="Guardar" ID="btnGuardar" OnClick="btnGuardar_Click" CssClass="btn btn-primary" runat="server" />
                    <a href="Novedades.aspx" class="btn btn-danger">Cancelar</a>
                </div>
            </div>
        </div>
    </div>

</asp:Content>

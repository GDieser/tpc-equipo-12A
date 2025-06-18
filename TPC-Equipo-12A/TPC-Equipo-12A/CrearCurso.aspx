<%@ Page Title="Crear Curso" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="CrearCurso.aspx.cs" Inherits="TPC_Equipo_12A.CrearCurso" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server" />

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" />

    <div class="container">

        <h1><asp:Literal ID="litTituloFormulario" runat="server" /></h1>
        

        <hr />

        <div class="row">
            <div class="col-6">
                <h4>Título:</h4>
                <asp:TextBox ID="txtTitulo" runat="server" CssClass="form-control" Style="width: 80%;" />

                <h4>Resumen:</h4>
                <asp:TextBox ID="txtResumen" runat="server" TextMode="MultiLine" Rows="2" CssClass="form-control" />

                <h4>Descripción:</h4>
                <textarea id="txtDescripcion" runat="server" rows="10" cols="60"></textarea>
                <script>
                    CKEDITOR.replace('<%= txtDescripcion.ClientID %>');
                </script>

                <h4>Categoría:</h4>
                <asp:DropDownList ID="ddlCategoria" runat="server" CssClass="form-select" Style="width: 60%;" />

                <h4>Estado</h4>
                <asp:DropDownList ID="ddlEstado" runat="server" CssClass="form-select" Style="width: 60%;" />


                <h4>Certificado:</h4>
                <asp:CheckBox ID="chkCertificado" runat="server" />

            </div>

            <div class="col-6">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                <h4>Precio:</h4>
                <asp:TextBox ID="txtPrecio" runat="server" CssClass="form-control" />

                <h4>Duración (horas):</h4>
                <asp:TextBox ID="txtDuracion" runat="server" CssClass="form-control" />

                        <h4>URL de imagen:</h4>
                        <asp:TextBox ID="txtImagen" runat="server" AutoPostBack="true"
                            OnTextChanged="txtImagen_TextChanged"
                            CssClass="form-control" />
                        <div class="mt-3">
                            <asp:Image ID="imgPreview" runat="server"
                                ImageUrl="https://www.aprender21.com/images/colaboradores/sql.jpeg"
                                CssClass="img-thumbnail" />
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>

                <div class="text-center mt-4">
                    <asp:Button Text="Guardar Curso" ID="btnGuardar" OnClick="btnGuardar_Click" CssClass="btn btn-success" runat="server" />
                    <a href="ListaCursos.aspx" class="btn btn-danger">Cancelar</a>
                </div>
            </div>
        </div>
    </div>

</asp:Content>


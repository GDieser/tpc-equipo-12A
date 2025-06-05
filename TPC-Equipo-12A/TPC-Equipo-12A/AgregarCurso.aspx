<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AgregarCurso.aspx.cs" Inherits="TPC_Equipo_12A.AgregarCurso" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Agregar Curso</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server" class="container mt-5">
    <asp:ScriptManager ID="ScriptManager1" runat ="server"></asp:ScriptManager>
        <h2 class="mb-4">Agregar Nuevo Curso</h2>

        <div class="mb-3">
            <label for="txtTitulo" class="form-label">Título del curso</label>
            <asp:TextBox ID="txtTitulo" runat="server" CssClass="form-control" />
        </div>
        <div class="mb-3">
            <label for="txtResumen" class="form-label">Resumen</label>
            <asp:TextBox ID="txtResumen" runat="server" CssClass="form-control" TextMode="MultiLine" />
        </div>
        <div class="mb-3">
            <label for="txtDescripcion" class="form-label">Descripcion</label>
            <asp:TextBox ID="txtDescripcion" runat="server" CssClass="form-control" TextMode="MultiLine" />
        </div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate> 

        <div class="mb-4">
            <label for="txtImagenUrl" class="form-label">URL de la imagen</label>
            <asp:TextBox ID="txtImagenUrl" runat="server" CssClass="form-control" 
            AutoPostBack="true" OnTextChanged="txtImagenUrl_TextChanged" />
        </div>
                <asp:Image ImageUrl="https://wiratthungsong.com/wts/assets/img/default.png"
                    ID="imgCurso" runat="server" width="30%" />
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:Button Text="Guardar Curso" ID="btnGuardar"   CssClass="btn btn-primary" runat="server" OnClick="btnGuardar_Click"/>
        <a href="Default.aspx">Cancelar</a>
    </form>
</body>
</html>

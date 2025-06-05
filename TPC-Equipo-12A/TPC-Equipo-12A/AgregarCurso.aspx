<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AgregarCurso.aspx.cs" Inherits="TPC_Equipo_12A.AgregarCurso" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Agregar Curso</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="bg-black">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div class="container">
            <div class="row justify-content-center align-items-center mt-5">
                <div class="col-12 col-sm-10 col-md-8 col-lg-6">
                    <div class="card bg-dark text-white shadow rounded-4 p-4 border-0">
                        <div class="card-body">
                            <h2 class="mb-4 text-center">Agregar Nuevo Curso</h2>

                            <div class="mb-3">
                                <label for="txtTitulo" class="form-label">Título del curso</label>
                                <asp:TextBox ID="txtTitulo" runat="server" CssClass="form-control" />
                            </div>
                            <div class="mb-3">
                                <label for="txtResumen" class="form-label">Resumen</label>
                                <asp:TextBox ID="txtResumen" runat="server" CssClass="form-control" TextMode="MultiLine" />
                            </div>
                            <div class="mb-3">
                                <label for="txtDescripcion" class="form-label">Descripción</label>
                                <asp:TextBox ID="txtDescripcion" runat="server" CssClass="form-control" TextMode="MultiLine" />
                            </div>
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>
                                    <div class="mb-3">
                                        <label for="txtImagenUrl" class="form-label">URL de la imagen</label>
                                        <asp:TextBox ID="txtImagenUrl" runat="server" CssClass="form-control" AutoPostBack="true" OnTextChanged="txtImagenUrl_TextChanged" />
                                    </div>
                                    <div class="text-center mb-3">
                                        <asp:Image ImageUrl="https://wiratthungsong.com/wts/assets/img/default.png"
                                            ID="imgCurso" runat="server" Width="50%" />
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>

                            <asp:Button Text="Guardar Curso" ID="btnGuardar" CssClass="btn btn-primary w-100 mb-3" runat="server" OnClick="btnGuardar_Click" />
                            <div class="text-center">
                                <a href="Default.aspx" class="text-decoration-none text-white">Cancelar</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>

</html>

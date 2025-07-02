<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Perfil.aspx.cs" Inherits="TPC_Equipo_12A.Perfil" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .hidden-file {
            display: none;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="row justify-content-center align-items-center mt-4 mb-4">
            <div class="col-12 col-sm-10 col-md-8 col-lg-7">
                <div class="card bg-dark text-white shadow rounded-4 p-4 border-0">
                    <div class="card-body">
                        <div class="mb-4 text-center">
                            <h4>
                                <asp:Literal ID="litPerfilTitulo" runat="server" />
                            </h4>
                            <small>
                                <asp:Literal ID="litEmail" runat="server" />
                            </small>
                        </div>

                        <asp:ScriptManager ID="ScriptManager1" runat="server" />

                        <asp:UpdatePanel ID="updFotoPerfil" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <div class="text-center mb-3">
                                    <div style="width: 150px; height: 150px; overflow: hidden; border-radius: 50%; margin: auto;">
                                        <asp:Image ID="imgFotoPerfil" runat="server" ClientIDMode="Static"
                                            CssClass="w-100 h-100"
                                            Style="object-fit: cover;" />
                                    </div>
                                    <div class="text-center">
                                        <small>
                                            <asp:Literal ID="litFechaRegistro" runat="server" />
                                        </small>
                                    </div>
                                </div>


                                <div class="form-outline mb-3">
                                    <label class="form-label" for="txtNombre">Nombre</label>
                                    <asp:TextBox ID="txtNombre" CssClass="form-control" runat="server" />
                                </div>

                                <div class="form-outline mb-3">
                                    <label class="form-label" for="txtApellido">Apellido</label>
                                    <asp:TextBox ID="txtApellido" CssClass="form-control" runat="server" />
                                </div>

                                <div class="form-outline mb-3">
                                    <label class="form-label" for="txtCelular">Celular</label>
                                    <asp:TextBox ID="txtCelular" CssClass="form-control" runat="server" />
                                </div>

                                <div class="form-outline mb-3">
                                    <label class="form-label" for="txtFechaNacimiento">Fecha de Nacimiento</label>
                                    <asp:TextBox ID="txtFechaNacimiento" CssClass="form-control" TextMode="Date" runat="server" />
                                </div>



                                <div class="form-outline mb-3">
                                    <label class="form-label">Foto de perfil</label>

                                    <div class="input-group ">
                                        <asp:TextBox ID="txtNombreArchivo" runat="server" CssClass="form-control" ReadOnly="true" />
                                        <button type="button" class="btn btn-outline-secondary rounded-end" onclick="document.getElementById('<%= fuFotoPerfil.ClientID %>').click();">
                                            <i class="bi bi-folder"></i>
                                        </button>
                                        <asp:FileUpload ID="fuFotoPerfil" runat="server" CssClass="hidden-file" />
                                    </div>
                                </div>

                                <asp:Button ID="btnGuardar" runat="server" Text="Guardar Cambios" CssClass="btn btn-primary w-100 mb-3" OnClick="btnGuardar_Click" />

                                <asp:Button ID="btnInhabilitar" Enabled="false" runat="server" Text="" CssClass="btn btn-primary w-100 mb-3" OnClick="btnInhabilitar_Click" />
                                <asp:HyperLink
                                    ID="hlVerMisCompras"
                                    runat="server"
                                    CssClass="btn btn-warning w-100 mb-3"
                                    NavigateUrl='<%# "MisCompras.aspx?id=" + idQueryParam %>'
                                    Text="Ver compras" />

                                <asp:Label ID="lblError" runat="server" CssClass="text-danger mt-3 d-block text-center" />
                                <asp:Label ID="lblExito" runat="server" CssClass="text-succes mt-3 d-block text-center" />

                            </ContentTemplate>
                            <Triggers>
                                <asp:PostBackTrigger ControlID="btnGuardar" />
                            </Triggers>

                        </asp:UpdatePanel>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            var fileInput = document.getElementById("<%= fuFotoPerfil.ClientID %>");
            var txtNombre = document.getElementById("<%= txtNombreArchivo.ClientID %>");

            fileInput.addEventListener("change", function () {
                if (fileInput.files.length > 0) {
                    txtNombre.value = fileInput.files[0].name;

                    const lector = new FileReader();
                    lector.onload = function (e) {
                        const img = document.getElementById("imgFotoPerfil");
                        if (img) img.src = e.target.result;
                    };
                    lector.readAsDataURL(fileInput.files[0]);
                } else {
                    txtNombre.value = "";
                }
            });
        });
    </script>
</asp:Content>

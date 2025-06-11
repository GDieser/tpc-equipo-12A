<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Perfil.aspx.cs" Inherits="TPC_Equipo_12A.Perfil" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
                                        <asp:Image ID="imgFotoPerfil" runat="server"
                                            CssClass="w-100 h-100"
                                            Style="object-fit: cover;"
                                            ImageUrl="https://openclipart.org/download/247324/abstract-user-flat-1.svg" />
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
                                    <label class="form-label" for="txtUrlFoto">Url foto de perfil</label>
                                    <asp:TextBox ID="txtUrlFoto" runat="server" CssClass="form-control mt-2"
                                        AutoPostBack="true" OnTextChanged="txtUrlFoto_TextChanged"
                                        placeholder="Ingresá una URL de imagen" />
                                </div>


                                <asp:Button ID="btnGuardar" runat="server" Text="Guardar Cambios" CssClass="btn btn-primary w-100 mb-3" OnClick="btnGuardar_Click" />
                                <asp:Button ID="btnInhabilitar" runat="server" Text="" CssClass="btn btn-primary w-100 mb-3" OnClick="btnInhabilitar_Click" />
                                <asp:Label ID="lblError" runat="server" CssClass="text-danger mt-3 d-block text-center" />
                                <asp:Label ID="lblExito" runat="server" CssClass="text-succes mt-3 d-block text-center" />

                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>

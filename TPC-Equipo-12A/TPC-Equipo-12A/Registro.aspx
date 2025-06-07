<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Registro.aspx.cs" Inherits="TPC_Equipo_12A.Registro" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="row justify-content-center align-items-center mt-4 mb-4">
            <div class="col-12 col-sm-8 col-md-6 col-lg-5">
                <div class="card bg-dark text-white shadow rounded-4 p-4 border-0">
                    <div class="card-body">
                        <h4 class="mb-4 text-center">Registro de Usuario</h4>

                        <div class="form-outline mb-3">
                            <label class="form-label" for="txtNombre">Nombre<span style="color:red">*</span></label>
                            <asp:TextBox ID="txtNombre" CssClass="form-control" runat="server" />
                            <asp:RequiredFieldValidator ID="rfvNombre" runat="server" ControlToValidate="txtNombre"
                                ErrorMessage="Este campo es obligatorio." Display="Dynamic" ForeColor="Red" />
                        </div>

                        <div class="form-outline mb-3">
                            <label class="form-label" for="txtApellido">Apellido<span style="color:red">*</span></label>
                            <asp:TextBox ID="txtApellido" CssClass="form-control" runat="server" />
                            <asp:RequiredFieldValidator ID="rfvApellido" runat="server" ControlToValidate="txtApellido"
                                ErrorMessage="Este campo es obligatorio." Display="Dynamic" ForeColor="Red" />
                        </div>

                        <div class="form-outline mb-3">
                            <label class="form-label" for="txtNombreUsuario">Nombre de Usuario<span style="color:red">*</span></label>
                            <asp:TextBox ID="txtNombreUsuario" CssClass="form-control" runat="server" />
                            <asp:RequiredFieldValidator ID="rfvNombreUsuario" runat="server" ControlToValidate="txtNombreUsuario"
                                ErrorMessage="Este campo es obligatorio." Display="Dynamic" ForeColor="Red" />
                        </div>

                        <div class="form-outline mb-3">
                            <label class="form-label" for="txtEmail">Email<span style="color:red">*</span></label>
                            <asp:TextBox ID="txtEmail" CssClass="form-control" runat="server" TextMode="Email" />
                            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
                                ErrorMessage="Este campo es obligatorio." Display="Dynamic" ForeColor="Red" />
                        </div>

                        <div class="form-outline mb-3">
                            <label class="form-label" for="txtEmail2">Confirmar Email<span style="color:red">*</span></label>
                            <asp:TextBox ID="txtEmail2" CssClass="form-control" runat="server" TextMode="Email" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtEmail2"
                                ErrorMessage="Este campo es obligatorio." Display="Dynamic" ForeColor="Red" />
                        </div>
                        <asp:CompareValidator ID="cvEmail" runat="server"
                            ControlToCompare="txtEmail"
                            ControlToValidate="txtEmail2"
                            ErrorMessage="Los correos no coinciden."
                            Operator="Equal"
                            Type="String"
                            Display="Dynamic"
                            ForeColor="Red" />


                        <asp:Button ID="btnRegistrar" runat="server" Text="Registrarse" onClick="BtnRegistrar_Click"
                            CssClass="btn btn-primary w-100" />
                        <div class="text-center mt-3">
                            <p>¿Ya tenés cuenta? <a href="./Login.aspx">Inicia sesión</a></p>
                        </div>


                        <asp:Label ID="lblError" runat="server" Text="" ForeColor="Red" />
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>

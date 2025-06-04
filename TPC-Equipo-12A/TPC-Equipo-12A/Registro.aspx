<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Registro.aspx.cs" Inherits="TPC_Equipo_12A.Registro" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        function togglePass() {
            var txtPass = document.getElementById('<%= txtPass.ClientID %>');
            var btnIcon = document.getElementById('txtTogglePass').querySelector('i');

            if (txtPass.type === "password") {
                txtPass.type = "text";
                btnIcon.classList.remove('fa-eye');
                btnIcon.classList.add('fa-eye-slash');
            } else {
                txtPass.type = "password";
                btnIcon.classList.remove('fa-eye-slash');
                btnIcon.classList.add('fa-eye');
            }
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="row justify-content-center align-items-center mt-4 mb-4">
            <div class="col-12 col-sm-8 col-md-6 col-lg-5">
                <div class="card bg-dark text-white shadow rounded-4 p-4 border-0">
                    <div class="card-body">
                        <h4 class="mb-4 text-center">Registro de Usuario</h4>

                        <div class="form-outline mb-3">
                            <label class="form-label" for="txtNombre">Nombre</label>
                            <asp:TextBox ID="txtNombre" CssClass="form-control" runat="server" />
                            <asp:RequiredFieldValidator ID="rfvNombre" runat="server" ControlToValidate="txtNombre"
                                ErrorMessage="El nombre es obligatorio." Display="Dynamic" ForeColor="Red" />
                        </div>

                        <div class="form-outline mb-3">
                            <label class="form-label" for="txtApellido">Apellido</label>
                            <asp:TextBox ID="txtApellido" CssClass="form-control" runat="server" />
                            <asp:RequiredFieldValidator ID="rfvApellido" runat="server" ControlToValidate="txtApellido"
                                ErrorMessage="El apellido es obligatorio." Display="Dynamic" ForeColor="Red" />
                        </div>

                        <div class="form-outline mb-3">
                            <label class="form-label" for="txtNombreUsuario">Nombre de Usuario</label>
                            <asp:TextBox ID="txtNombreUsuario" CssClass="form-control" runat="server" />
                            <asp:RequiredFieldValidator ID="rfvNombreUsuario" runat="server" ControlToValidate="txtNombreUsuario"
                                ErrorMessage="El nombre de usuario es obligatorio." Display="Dynamic" ForeColor="Red" />
                        </div>

                        <div class="form-outline mb-3">
                            <label class="form-label" for="txtEmail">Email</label>
                            <asp:TextBox ID="txtEmail" CssClass="form-control" runat="server" TextMode="Email" />
                            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
                                ErrorMessage="El email es obligatorio." Display="Dynamic" ForeColor="Red" />
                        </div>

                        <div class="form-outline mb-3">
                            <label class="form-label" for="txtCelular">Celular</label>
                            <asp:TextBox ID="txtCelular" CssClass="form-control" runat="server" />
                        </div>

                        <div class="form-outline mb-3">
                            <label class="form-label" for="txtFechaNacimiento">Fecha de Nacimiento</label>
                            <asp:TextBox ID="txtFechaNacimiento" CssClass="form-control" runat="server" TextMode="Date" />
                        </div>



                        <label class="form-label" for="txtPass">Contraseña</label>
                        <div class="position-relative mb-3">
                            <asp:TextBox ID="txtPass" CssClass="form-control pe-5" TextMode="Password" runat="server" />
                            <button type="button" onclick="togglePass()" id="txtTogglePass"
                                class="btn btn-light position-absolute top-0 end-0 h-100 rounded-0 rounded-end border-start"
                                style="width: 2.75rem;">
                                <i class="fas fa-eye text-secondary"></i>
                            </button>
                            <asp:RequiredFieldValidator ID="rfvPass" runat="server" ControlToValidate="txtPass"
                                ErrorMessage="La contraseña es obligatoria." Display="Dynamic" ForeColor="Red" />
                            <asp:RegularExpressionValidator ID="revPass" runat="server"
                                ControlToValidate="txtPass"
                                ValidationExpression=".{8,}"
                                ErrorMessage="La contraseña debe tener al menos 8 caracteres."
                                Display="Dynamic" ForeColor="Red" />
                        </div>

                        <label class="form-label" for="txtPass2">Repetir Contraseña</label>
                        <div class="position-relative mb-3">
                            <asp:TextBox ID="txtPass2" CssClass="form-control pe-5" TextMode="Password" runat="server" />
                            <button type="button" onclick="togglePass()" id="txtTogglePass2"
                                class="btn btn-light position-absolute top-0 end-0 h-100 rounded-0 rounded-end border-start"
                                style="width: 2.75rem;">
                                <i class="fas fa-eye text-secondary"></i>
                            </button>
                            <asp:RequiredFieldValidator ID="rfvPass2" runat="server" ControlToValidate="txtPass2"
                                ErrorMessage="La contraseña es obligatoria." Display="Dynamic" ForeColor="Red" />
                            <asp:CompareValidator ID="cvPass" runat="server"
                                ControlToCompare="txtPass"
                                ControlToValidate="txtPass2"
                                ErrorMessage="Las contraseñas no coinciden."
                                Operator="Equal"
                                Type="String"
                                Display="Dynamic"
                                ForeColor="Red" />
                        </div>

                        <div class="form-outline mb-4">
                            <label class="form-label" for="fuFotoPerfil">Foto de Perfil</label>
                            <asp:FileUpload ID="fuFotoPerfil" CssClass="form-control" runat="server" />
                        </div>

                        <asp:Button ID="btnRegistrar" runat="server" Text="Registrarse" OnClick="btnRegistrar_Click"
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

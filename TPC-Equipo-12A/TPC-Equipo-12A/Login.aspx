<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="TPC_Equipo_12A.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script>
        function togglePass() {
            // Obtengo el textbox por su ClientID generado
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

    <div class="container">
        <div class="row justify-content-center align-items-center mt-4 mb-4">
            <div class="col-12 col-sm-8 col-md-6 col-lg-4">

                <div class="card bg-dark text-white shadow rounded-4 p-4 border-0">
                    <div class="card-body">
                        <asp:Panel ID="pnlLogin" runat="server" DefaultButton="btnLogin">

                            <h4 class="mb-4 text-center">Iniciá Sesion</h4>

                            <div class="form-outline mb-4">
                                <label class="form-label" for="txtUsuario">Nombre de usuario</label>

                                <asp:TextBox ID="txtUsuario" CssClass="form-control" runat="server"></asp:TextBox>
                            </div>

                            <label class="form-label" for="txtPass">Contraseña</label>
                            <div class="position-relative mb-4">

                                <asp:TextBox ID="txtPass" CssClass="form-control pe-5" TextMode="Password" runat="server"></asp:TextBox>
                                <button
                                    type="button"
                                    onclick="togglePass()"
                                    id="txtTogglePass"
                                    class="btn btn-light position-absolute top-0 end-0 h-100 rounded-0 rounded-end border-start"
                                    style="width: 2.75rem;">
                                    <i class="fas fa-eye text-secondary"></i>
                                </button>

                            </div>

                            <div class="row mb-4 text-center">
                                <a href="RestablecerContrasenia.aspx">¿Olvidaste tu contraseña?</a>
                            </div>

                            <asp:Button ID="btnLogin" runat="server" Text="Inicia Sesion" OnClick="btnLogin_Click" CssClass="btn btn-primary w-100 mb-4" />


                            <div class="text-center">
                                <p>¿No sos usuario? <a href="./Registro.aspx">¡Registrate aca!</a></p>
                            </div>
                            <div class="row">
                                <asp:RequiredFieldValidator
                                    ID="rfvEmail"
                                    runat="server"
                                    ControlToValidate="txtUsuario"
                                    ErrorMessage="El nombre de usuario es obligatorio."
                                    ForeColor="Red"
                                    Display="Dynamic" />
                            </div>
                            <div class="row">
                                <asp:RequiredFieldValidator
                                    ID="rfvPass"
                                    runat="server"
                                    ControlToValidate="txtPass"
                                    ErrorMessage="La contraseña es obligatoria."
                                    ForeColor="Red"
                                    Display="Dynamic" />
                                <br />
                            </div>
                            <div class="text-center">
                                <asp:Label ID="lblError" runat="server" Text="Label"></asp:Label>
                            </div>
                        </asp:Panel>
                    </div>
                </div>

            </div>
        </div>
    </div>
</asp:Content>

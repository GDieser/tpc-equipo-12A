<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="GenerarContrasenia.aspx.cs" Inherits="TPC_Equipo_12A.GenerarContrasenia" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        function togglePassById(id, btnId) {
            var txtPass = document.getElementById(id);
            var btnIcon = document.getElementById(btnId).querySelector('i');

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
                        <h4 class="mb-4 text-center">Genere su contraseña</h4>

                        <label class="form-label" for="txtPass">Contraseña</label>
                        <div class="position-relative mb-3">
                            <asp:TextBox ID="txtPass" CssClass="form-control pe-5" TextMode="Password" runat="server" />
                            <button type="button" onclick="togglePassById('<%= txtPass.ClientID %>', 'txtTogglePass')" id="txtTogglePass"
                                class="btn btn-light position-absolute top-0 end-0 h-100 rounded-0 rounded-end border-start"
                                style="width: 2.75rem;">
                                <i class="fas fa-eye text-secondary"></i>
                            </button>
                        </div>
                        <asp:RequiredFieldValidator ID="rfvPass" runat="server" ControlToValidate="txtPass"
                            ErrorMessage="La contraseña es obligatoria." Display="Dynamic" ForeColor="Red" />
                        <asp:RegularExpressionValidator ID="revPass" runat="server"
                            ControlToValidate="txtPass"
                            ValidationExpression=".{8,}"
                            ErrorMessage="La contraseña debe tener al menos 8 caracteres."
                            Display="Dynamic" ForeColor="Red" />

                        <label class="form-label" for="txtPass2">Repetir Contraseña</label>
                        <div class="position-relative mb-3">
                            <asp:TextBox ID="txtPass2" CssClass="form-control pe-5" TextMode="Password" runat="server" />
                            <button type="button" onclick="togglePassById('<%= txtPass2.ClientID %>', 'txtTogglePass2')" id="txtTogglePass2"
                                class="btn btn-light position-absolute top-0 end-0 h-100 rounded-0 rounded-end border-start"
                                style="width: 2.75rem;">
                                <i class="fas fa-eye text-secondary"></i>
                            </button>

                        </div>
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
                        <asp:Button ID="btnGuardarContrasenia" runat="server" Text="Guardar" OnClick="btnGuardarContrasenia_Click" CssClass="btn btn-primary w-100" />

                        <asp:Label ID="lblError" runat="server" Text="" ForeColor="Red" />

                        <p>¡Importante! ¡Estas credenciales son las mismas que usaras para ingresar a Moodle!</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>


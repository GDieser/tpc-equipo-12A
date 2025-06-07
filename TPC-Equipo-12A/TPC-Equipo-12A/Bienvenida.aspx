<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Bienvenida.aspx.cs" Inherits="TPC_Equipo_12A.Bienvenida" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="row justify-content-center align-items-center mt-4 mb-4">
            <div class="col-12 col-sm-8 col-md-6 col-lg-5">
                <div class="card bg-dark text-white shadow rounded-4 p-4 border-0">
                    <div class="card-body">
                        <h4 class="mb-4 text-center">Bienvenid@</h4>
                        <p class="text-center">¡Gracias por registrarte! Tu cuenta ha sido creada exitosamente.</p>
                        <p class="text-center">¡Revisá tu casilla de correo para generar tu contraseña y validar tu correo!</p>
                        <div class="text-center mt-3">
                            <asp:Button Text="Volver" CssClass="btn btn-primary" OnClick="btnVolver_Click" runat="server" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

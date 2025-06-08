<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="RestablecerContrasenia.aspx.cs" Inherits="TPC_Equipo_12A.RestablecerContrasenia" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="row justify-content-center align-items-center mt-4 mb-4">
            <div class="col-12 col-sm-8 col-md-6 col-lg-5">
                <div class="card bg-dark text-white shadow rounded-4 p-4 border-0">
                    <div class="card-body">
                        <h4 class="mb-4 text-center">Restablecer Contraseña</h4>

                        <div class="form-outline mb-3">
                            <label class="form-label" for="txtEmail">Email<span style="color: red">*</span></label>
                            <asp:TextBox ID="txtEmail" CssClass="form-control" runat="server" TextMode="Email" />
                            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
                                ErrorMessage="Este campo es obligatorio." Display="Dynamic" ForeColor="Red" />
                        </div>

                        <asp:Button CssClass="btn btn-primary" Text="Restablecer contraseña" ID="btnRestablecer" OnClick="btnRestablecer_Click" runat="server" />

                        <asp:Label ID="lblError" runat="server" Text="" ForeColor="Red" />
                    </div>
                </div>
            </div>
        </div>
    </div>


</asp:Content>

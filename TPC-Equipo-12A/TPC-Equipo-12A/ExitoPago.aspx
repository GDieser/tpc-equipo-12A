<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="ExitoPago.aspx.cs" Inherits="TPC_Equipo_12A.ExitoPago" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      <div class="container">
        <div class="row justify-content-center align-items-center mt-4 mb-4">
            <div class="col-12 col-sm-8 col-md-6 col-lg-5">
                <div class="card bg-dark text-white shadow rounded-4 p-4 border-0">
                    <div class="card-body text-center">
                        <h4 class="mb-4 text-success">¡Pago exitoso!</h4>
                        <p>Gracias por tu compra. El pago fue procesado correctamente.</p>
                        <a href="Default.aspx" class="btn btn-outline-success mt-3">Volver al inicio</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

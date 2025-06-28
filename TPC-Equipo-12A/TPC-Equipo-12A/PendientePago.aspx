<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="PendientePago.aspx.cs" Inherits="TPC_Equipo_12A.PendientePago" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="row justify-content-center align-items-center mt-4 mb-4">
            <div class="col-12 col-sm-8 col-md-6 col-lg-5">
                <div class="card bg-dark text-white shadow rounded-4 p-4 border-0">
                    <div class="card-body text-center">
                        <h4 class="mb-4 text-warning">Pago pendiente</h4>
                        <p>Tu pago está siendo procesado. Te notificaremos una vez confirmado.</p>
                        <a href="Default.aspx" class="btn btn-outline-warning mt-3">Volver al inicio</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

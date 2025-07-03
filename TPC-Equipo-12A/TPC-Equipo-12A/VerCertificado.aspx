<%@ Page Title="" Language="C#" MasterPageFile="~/Aula.Master" AutoEventWireup="true" CodeBehind="VerCertificado.aspx.cs" Inherits="TPC_Equipo_12A.VerCertificado" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AulaContent" runat="server">
    <style>
        .iframe-container {
            position: relative;
            width: 100%;
            padding-top: 75%; /* Aspect ratio 4:3 (Landscape A4) */
            overflow: hidden;
            border: 1px solid #ccc;
            box-shadow: 0 0 1px rgba(0,0,0,0.2);
            border-radius: 10px;
            background-color: #f9f9f9;
        }

            .iframe-container iframe {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                border: none;
                background-color: white;
            }

        .certificado-wrapper {
            max-width: 1100px;
            margin: 2rem auto;
            padding: 1rem;
        }
    </style>

    <div class="certificado-wrapper">

        <div class="mb-5">
            <h1 class="display-4 fw-bold text-info">
                <i class="bi bi-award"></i>Certificado del Curso
            </h1>
        </div>
        <hr />
        <div class="iframe-container">
            <iframe id="iframeCertificado" src='<%= "CertificadoRender.aspx?idCertificado=" + Request.QueryString.Get("id") %>'></iframe>
        </div>
        <div class="text-center mt-3">
            <button class="btn btn-success" onclick="document.getElementById('iframeCertificado').contentWindow.print();">📄 Imprimir Certificado</button>
        </div>
    </div>

</asp:Content>

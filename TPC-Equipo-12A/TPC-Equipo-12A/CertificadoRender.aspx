<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CertificadoRender.aspx.cs" Inherits="TPC_Equipo_12A.CertificadoRender" %>

<!DOCTYPE html>
<html lang="es">

<head runat="server">
    <meta charset="UTF-8" />
    <title>Certificado de Finalización</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            background-color: #000;
            font-family: 'Segoe UI', 'Helvetica Neue', sans-serif;
        }

        .cert-container {
            width: 1120px;
            height: 793px;
            margin: 0 auto;
            border: 2px solid #fff;
            box-sizing: border-box;
            position: relative;
            padding: 40px 60px;
            display: flex;
            flex-direction: column;
            align-items: center;
            color: #fff;
            background-color: #000;
        }

        .inner-border {
            position: absolute;
            top: 20px;
            left: 20px;
            right: 20px;
            bottom: 20px;
            border: 1px solid #7c7c7c;
            pointer-events: none;
        }

        .ribbon {
            position: absolute;
            top: 20px;
            left: 60px;
            width: 60px;
            height: 120px;
            background: linear-gradient(to bottom, #3785d4, #1355db);
            z-index: 2;
            clip-path: polygon(0 0, 100% 0, 100% 85%, 50% 100%, 0 85%);
        }

        .logo-container {
            margin-bottom: 5px;
        }

        .logo {
            height: 100px;
        }

        .cert-box-title {
            border: 1px solid #a3a300;
            color: #a3a300;
            padding: 0px 10px;
            text-transform: uppercase;
            font-size: 16px;
            letter-spacing: 2px;
            font-weight: 400;
            margin-bottom: 20px;
        }

        .course-name {
            font-size: 44px;
            font-weight: 600;
            margin-bottom: 20px;
            text-align: center;
        }

        .student-name {
            font-size: 40px;
            font-weight: 300;
            margin: 0px 0 10px 0;
            border-bottom: 1px solid #fff;
            padding-bottom: 10px;
            display: inline-block;
        }

        .ceo-name {
            font-size: 24px;
            font-weight: 300;
            display: inline-block;
        }

        .cert-text {
            font-size: 18px;
            font-weight: 300;
            max-width: 800px;
            text-align: center;
            line-height: 1.8;
            margin-bottom: 20px;
        }

        .cert-date {
            font-size: 14px;
            font-weight: 300;
            margin-bottom: 5px;
            text-align: center;
        }

        .code-date {
            font-size: 14px;
            color: #d6d6d6;
            font-weight: 300;
            text-align: center;
        }

        .signatures {
            display: flex;
            justify-content: space-between;
            width: 100%;
            padding: 0 40px;
            margin-top: auto;
        }

        .signature-block {
            text-align: center;
            width: 40%;
        }

        .signature-logo {
            height: 150px;
            filter: brightness(0) invert(1);
        }

        .signature-line {
            width: 100%;
            height: 1px;
            background-color: #a3a3a3;
            margin: 10px 0;
        }

        .signature-text {
            font-size: 14px;
            font-weight: 300;
            color: #fff;
        }
    </style>
    <style media="print">
        @page {
            size: landscape;
            margin: 0;
        }

        body {
            margin: 0;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="cert-container">
            <div class="inner-border"></div>

            <div class="ribbon"></div>

            <div class="logo-container">
                <img src="imagenes/cert/logoIntro.png" alt="Logo" class="logo" />
            </div>


            <div class="cert-box-title">Certificado de Finalización</div>


            <div class="course-name">
                <asp:Literal ID="litNombreCurso" runat="server" />
            </div>


            <div class="student-name">
                <asp:Literal ID="litNombreAlumno" runat="server" />
            </div>


            <div class="cert-text">
                Ha realizado y completado con éxito el curso con una duración de
                <strong>
                    <asp:Literal ID="litHoras" runat="server" />
                </strong>horas dictadas de manera asincrónica,
                cumpliendo con todos los requisitos académicos exigidos.
            </div>


            <div class="cert-date">
                Fecha de finalización: 
                <asp:Literal ID="litFecha" runat="server" />
            </div>

            <div class="code-date">
                Código: 
                <asp:Literal ID="litIdCurso" runat="server" />
            </div>


            <div class="signatures">
                <div class="signature-block">
                    <img src="/imagenes/cert/firma1.png" alt="Logo Firma Instructor" class="signature-logo" />
                    <div class="signature-line"></div>
                    <div class="ceo-name">Walter Lugo</div>
                    <div class="signature-text">Instructor general</div>
                </div>
                <div class="signature-block">
                    <img src="/imagenes/cert/firma2.png" alt="Logo Firma Responsable" class="signature-logo" />
                    <div class="signature-line"></div>
                    <div class="ceo-name">Darian Hiebl</div>
                    <div class="signature-text">CEO - MisCursos</div>
                </div>
            </div>
        </div>
    </form>
</body>

</html>

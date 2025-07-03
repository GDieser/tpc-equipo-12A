<%@ Page Title="" Language="C#" MasterPageFile="~/Aula.Master" AutoEventWireup="true" CodeBehind="MisCertificados.aspx.cs" Inherits="TPC_Equipo_12A.MisCertificados" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AulaContent" runat="server">

    <div class="container py-4">

        <div class="mb-5">
            <h1 class="display-4 fw-bold text-info">🎓 Mis Certificados</h1>
            <p class="lead text-white-50">
                ¡Aqui encontraras todos tus certificados!
            </p>
        </div>
        <asp:Label
            ID="lblMensaje"
            runat="server"
            CssClass="alert alert-warning text-center d-block fs-5 rounded-3 shadow-sm mt-4"
            Visible="false" />
        <asp:Repeater ID="rptCertificados" runat="server">
            <ItemTemplate>
                <div class="col">
                    <div class="card h-100 bg-dark text-light border-secondary shadow-sm rounded-4 d-flex flex-column">
                        <div class="row g-0 h-100">
                            <div class="col-md-4 h-100">
                                <img src='<%# Eval("UrlImagen") %>' class="img-fluid h-100 w-100 object-fit-cover rounded-start" alt="Imagen del curso" />
                            </div>
                            <div class="col-md-8 d-flex align-items-center">
                                <div class="card-body text-center flex-grow-1">
                                    <h4 class="card-title fw-semibold mb-1"><%# Eval("NombreCurso") %></h4>
                                    <p class="card-text text-white-50 mb-1">🆔 Nº Referencia: <%# Eval("IdCertificado") %></p>
                                    <p class="card-text text-white-50">📅 Emitido: <%# Eval("FechaEmision", "{0:dd/MM/yyyy}") %></p>
                                    <a href='VerCertificado.aspx?id=<%# Eval("IdCertificado") %>'
                                        class="btn btn-outline-success btn-sm rounded-pill">Ver certificado
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</asp:Content>


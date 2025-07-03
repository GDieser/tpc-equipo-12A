<%@ Page Title="" Language="C#" MasterPageFile="~/Aula.Master" AutoEventWireup="true" CodeBehind="MisCertificados.aspx.cs" Inherits="TPC_Equipo_12A.MisCertificados" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AulaContent" runat="server">


    <div class="mb-5">
        <h1 class="text-info mb-0">
            <i class="bi bi-award"></i>Mis Certificados
        </h1>
        <p class="lead text-white-50">
            ¡Acá vas a econtrar todos tus certificados!
        </p>
    </div>

    <asp:Label
        ID="lblMensaje"
        runat="server"
        CssClass="alert alert-warning text-center d-block fs-5 rounded-3 shadow-sm mt-4"
        Visible="false" />

    <div class="row g-2" style="height:30vh;">
        <asp:Repeater ID="rptCertificados" runat="server">
            <ItemTemplate>
                <div class="col-sm-6 col-md-4 col-lg-3">
                    <div class="card bg-dark text-light border-secondary shadow-sm rounded-4 h-100">
                        <img src='<%# Eval("UrlImagen") %>' class="card-img-top object-fit-cover rounded-top" style="height: 160px; object-fit: cover;" alt="Imagen del curso" />
                        <div class="card-body text-center">
                            <h5 class="card-title fw-semibold mb-2">🥇 <%# Eval("NombreCurso") %></h5>
                            <p class="card-text text-white-50 mb-2">
                                <i class="bi bi-calendar3"></i>Emitido: <%# Eval("FechaEmision", "{0:dd/MM/yyyy}") %>
                            </p>
                            <a href='VerCertificado.aspx?id=<%# Eval("IdCertificado") %>'
                                class="btn btn-outline-info btn-sm">Ver certificado</a>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>

</asp:Content>


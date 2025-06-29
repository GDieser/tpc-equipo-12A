<%@ Page Title="" Language="C#" MasterPageFile="~/Aula.Master" AutoEventWireup="true" CodeBehind="ForoDetalle.aspx.cs" Inherits="TPC_Equipo_12A.ForoDetalle" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AulaContent" runat="server">

    <div class="container mt-3">
        <div class="bg-black-tertiary rounded p-3 mb-4 border border-secondary">

            <div class="d-flex justify-content-between align-items-center mb-2">
                <h2 class="h2 text-info mb-0">
                    <asp:Literal ID="litTitulo" runat="server" />
                </h2>

                <asp:Button ID="btnVolver" runat="server" CssClass="btn btn-sm btn-outline-light" Text="← Volver" OnClick="btnVolver_Click" />
            </div>

            <hr />

            <div class="d-flex align-items-center mb-3">
                <asp:Image ID="imgPerfil" runat="server" CssClass="rounded-circle me-2" Width="40px" Height="40px" Style="object-fit: cover;" />
                <div class="small text-white">
                    <span class="text-white">
                        <h4 class="h4 mb-0">
                            <asp:Literal ID="litNombreCompleto" runat="server" />
                        </h4>
                    </span>(<asp:Literal ID="litNombreUsuario" runat="server" />) · 
                    <asp:Literal ID="litFecha" runat="server" />
                </div>
            </div>

            <div class="bg-dark rounded p-3 mb-3" style="white-space: pre-line;">
                <h6 class="h6 mb-0">
                    <asp:Literal ID="litContenido" runat="server" />
                </h6>
            </div>

            <div class="text-end">
                <asp:Button ID="btnResponder" runat="server" CssClass="btn btn-sm btn-primary" Text="Responder" />
            </div>
        </div>
    </div>


</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Pagar.aspx.cs" Inherits="TPC_Equipo_12A.Pagar" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-4">
        <h2 class="text-primary">Resumen de tu compra</h2>
        <asp:Repeater ID="rptCursos" runat="server">
            <HeaderTemplate>
                <table class="table table-dark table-striped mt-3">
                    <thead>
                        <tr>
                            <th>Curso</th>
                            <th>Precio</th>
                        </tr>
                    </thead>
                    <tbody>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td><%# Eval("Titulo") %></td>
                    <td>$<%# Eval("Precio", "{0:N2}") %></td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                    </tbody>
                </table>
            </FooterTemplate>
        </asp:Repeater>

        <div class="text-end">
            <h4>Total: $<asp:Literal ID="litTotal" runat="server" /></h4>
            <asp:Button ID="btnPagar" runat="server" CssClass="btn btn-success" Text="Pagar con Mercado Pago" OnClick="btnPagar_Click" />
        </div>
    </div>
</asp:Content>
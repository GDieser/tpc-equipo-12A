<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="MiCarrito.aspx.cs" Inherits="TPC_Equipo_12A.MiCarrito" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container mt-5">
        <h2 class="mb-4">🛒 Mi Carrito</h2>

        <asp:Panel ID="pnlCarrito" runat="server" Visible="false">
            <div class="row justify-content-center">
                <div class="col-md-8">

                    <asp:Repeater ID="repCarrito" OnItemCommand="repCarrito_ItemCommand" runat="server">
                        <ItemTemplate>
                            <div class="card mb-3 bg-dark text-white shadow-sm" style="border-radius: 10px;">
                                <div class="card-body d-flex justify-content-between align-items-center">
                                    <div>
                                        <h5 class="card-title"><%# Eval("Titulo") %></h5>
                                        <p class="card-text">💰 Precio: $<%# Eval("Precio") %></p>
                                    </div>
                                    <asp:Button ID="btnEliminar" runat="server" CssClass="btn btn-outline-danger" CommandName="Eliminar" CommandArgument='<%# Eval("IdCurso") %>' Text="❌" />
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>

                <div class="col-md-4">
                    <div class="card bg-dark text-white shadow-lg" style="border-radius: 15px;">
                        <div class="card-body">
                            <h4 class="card-title text-center">Resumen</h4>
                            <hr class="bg-light" />
                            <p class="card-text text-center">
                                Total: <strong>$<asp:Label ID="lblTotal" runat="server" Text="0.00" /></strong>
                            </p>
                            <asp:Button ID="btnComprar" runat="server" Text="🛒 Comprar" CssClass="btn btn-success w-100 mt-3" />
                        </div>
                    </div>
                </div>
            </div>
        </asp:Panel>

        <br />
        <asp:Label ID="lblMensaje" CssClass="alert alert-dark text-center" runat="server" Visible="false" Text="" />
    </div>

</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="MisCompras.aspx.cs" Inherits="TPC_Equipo_12A.MisCompras" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container text-center">
        <br />
        <h1>Mis Compras</h1>
        <br />

        <div class="mb-4">
            <div class="table-responsive">
                <span class="float-end">
                    <asp:LinkButton
                        ID="btnAgregar"
                        runat="server"
                        CssClass="btn btn-sm btn-outline-light mb-3"
                        OnClick="btnAgregar_Click"
                        ToolTip="Agregar Curso"
                        Visible="false">
                    <i class="bi bi-plus"></i> Agregar compra
                    </asp:LinkButton>
                </span>

                <table class="table table-dark table-hover text-start">
                    <thead>
                        <tr>
                            <th>N° Compra</th>
                            <th>Email comprador</th>
                            <th>Fecha</th>
                            <th>Transacción</th>
                            <th>Estado</th>
                            <th>Monto Total</th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="repCompras" runat="server">
                            <ItemTemplate>
                                <tr style="cursor: pointer"
                                    data-bs-toggle="collapse"
                                    data-bs-target='<%# "#detalleCompra" + Eval("IdCompra") %>'
                                    aria-expanded="false"
                                    aria-controls='<%# "detalleCompra" + Eval("IdCompra") %>'>
                                    <td><%# Eval("IdCompra") %></td>
                                    <td><%# Eval("EmailComprador") %></td>
                                    <td><%# Eval("FechaCompra", "{0:dd/MM/yyyy}") %></td>
                                    <td><%# Eval("CodigoTransaccion") %></td>
                                    <td><%# Eval("Estado") %></td>
                                    <td>$ <%# ((List<Dominio.CompraCursoDTO>)Eval("DetalleCompra")).Sum(dc => dc.Monto).ToString("N2") %>
                                    </td>
                                </tr>

                                <tr class="collapse bg-light text-dark"
                                    id='<%# "detalleCompra" + Eval("IdCompra") %>'>
                                    <td colspan="6" class="bg-secondary">
                                        <asp:Repeater ID="repCursos" runat="server" DataSource='<%# Eval("DetalleCompra") %>'>
                                            <HeaderTemplate>
                                                <table class="table table-sm table-bordered table-dark m-0 w-100"
                                                    style="table-layout: fixed;">
                                                    <thead>
                                                        <tr>
                                                            <th class="w-75">Curso</th>
                                                            <th class="w-25">Precio</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <tr>
                                                    <td><%# Eval("NombreCurso") %></td>
                                                    <td>$ <%# Eval("Monto", "{0:N2}") %></td>
                                                </tr>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                </tbody>
                                </table>
                                            </FooterTemplate>
                                        </asp:Repeater>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <asp:PlaceHolder runat="server" ID="phModal" Visible="false">
        <div class="modal fade" id="modalCompraManual" tabindex="-1" aria-labelledby="modalCompraManualLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content bg-dark text-white">
                    <div class="modal-header border-bottom border-secondary">
                        <h5 class="modal-title" id="modalCompraManualLabel">Agregar Compra Manual</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                    </div>

                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="ddlUsuario" class="form-label">Usuario</label>
                            <asp:DropDownList ID="ddlUsuario" runat="server" CssClass="form-select" AppendDataBoundItems="true">
                                <asp:ListItem Text="Seleccionar..." Value="" />
                            </asp:DropDownList>
                        </div>

                        <div class="mb-3">
                            <label for="ddlCurso" class="form-label">Curso</label>
                            <asp:DropDownList ID="ddlCurso" runat="server" CssClass="form-select" AppendDataBoundItems="true">
                                <asp:ListItem Text="Seleccionar..." Value="" />
                            </asp:DropDownList>
                        </div>
                    </div>

                    <div class="modal-footer border-0">
                        <asp:Button ID="btnConfirmarAgregar" runat="server"
                            CssClass="btn btn-success"
                            Text="Confirmar"
                            OnClick="btnConfirmarAgregar_Click"
                            UseSubmitBehavior="false" />
                    </div>
                </div>
            </div>
        </div>
    </asp:PlaceHolder>
</asp:Content>

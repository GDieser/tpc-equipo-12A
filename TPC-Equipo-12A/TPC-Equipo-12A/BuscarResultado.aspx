<%@ Page Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="BuscarResultado.aspx.cs" Inherits="TPC_Equipo_12A.BuscarResultado" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server" />

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-5">
        <h2 class="text-info mb-4">🔍 Resultados de búsqueda</h2>
        <asp:Label ID="lblMensaje" runat="server" CssClass="text-warning fs-5" Visible="false" />

        <asp:Panel ID="panelCursos" runat="server" Visible="false">
            <h4 class="text-white mt-4 mb-3">🎓 Cursos encontrados</h4>
            <div class="row row-cols-1 row-cols-md-3 g-4 mb-5">
                <asp:Repeater ID="rptCursos" runat="server">
                    <ItemTemplate>
                        <div class="col">
                            <div class="card bg-dark text-white h-100 shadow-sm border-info">
                                <img src='<%# Eval("ImagenUrl") %>' class="card-img-top" style="height: 200px; object-fit: cover;" />
                                <div class="card-body">
                                    <h5 class="card-title"><%# Eval("Titulo") %></h5>
                                    <p class="card-text"><%# Eval("Resumen") %></p>
                                </div>
                                <div class="card-footer text-center bg-transparent border-0">
                                    <a href='DescripcionCurso.aspx?id=<%# Eval("Id") %>' class="btn btn-outline-info">Ver curso</a>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </asp:Panel>

        <asp:Panel ID="panelPublicaciones" runat="server" Visible="false">
            <h4 class="text-white mt-4 mb-3">📰 Publicaciones encontradas</h4>
            <div class="row row-cols-1 row-cols-md-3 g-4">
                <asp:Repeater ID="rptPublicaciones" runat="server">
                    <ItemTemplate>
                        <div class="col">
                            <div class="card bg-dark text-white h-100 shadow-sm border-info">
                                <img src='<%# Eval("ImagenUrl") %>' class="card-img-top" style="height: 200px; object-fit: cover;" />
                                <div class="card-body">
                                    <h5 class="card-title"><%# Eval("Titulo") %></h5>
                                    <p class="card-text"><%# Eval("Resumen") %></p>
                                </div>
                                <div class="card-footer text-center bg-transparent border-0">
                                    <a href='DetalleNovedad.aspx?IdNovedad=<%# Eval("Id") %>' class="btn btn-outline-info">Ver publicación</a>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </asp:Panel>
    </div>
</asp:Content>

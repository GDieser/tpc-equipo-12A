<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Modulo.aspx.cs" Inherits="TPC_Equipo_12A.Modulo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container col-xl-8">

        <div class="container mt-4">

            <div class="mb-4 text-center">
                <asp:Image ID="imgBannerModulo" runat="server" CssClass="img-fluid rounded shadow" />
            </div>

            <h2 class="text-primary">
                <asp:Literal ID="litTituloModulo" runat="server" />
            </h2>
            <p class="text-secondary">
                <asp:Literal ID="litIntroModulo" runat="server" />
            </p>

            <hr />

            <asp:Repeater ID="rptLecciones" runat="server">
                <ItemTemplate>
                    <div class="card mb-2">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <div style="flex-grow: 1; cursor: pointer;"
                                data-bs-toggle="collapse"
                                data-bs-target='<%# "#intro" + Eval("IdLeccion") %>'>
                                <span><%# Eval("Titulo") %></span>
                            </div>
                            <a href='<%# "Leccion.aspx?id=" + Eval("IdLeccion") %>' class="btn btn-outline-primary btn-sm" onclick="event.stopPropagation();">Ir a lección
                            </a>
                        </div>
                        <div id='<%# "intro" + Eval("IdLeccion") %>' class="collapse card-body bg-light text-secondary">
                            <%# Eval("Introduccion") %>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>


        </div>
    </div>
</asp:Content>

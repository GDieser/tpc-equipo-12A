<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Curso.aspx.cs" Inherits="TPC_Equipo_12A.Curso" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        .img-banner-curso {
            width: 100%;
            height: 25vh; 
            object-fit: cover; 
        }
    </style>


    <div class="container col-xl-8">

        <div class="container mt-4">

            <div class="mb-4 text-center">
                <asp:Image ID="imgBannerCurso" runat="server" CssClass="img-fluid rounded shadow img-banner-curso" />
            </div>

            <h2 class="text-primary">
                <asp:Literal ID="litTituloCurso" runat="server" />
            </h2>
            <p class="text-secondary">
                <asp:Literal ID="litIntroCurso" runat="server" />
            </p>

            <hr />

            <asp:Repeater ID="rptModulos" runat="server">
                <ItemTemplate>
                    <div class="card mb-2">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <div style="flex-grow: 1; cursor: pointer;"
                                data-bs-toggle="collapse"
                                data-bs-target='<%# "#intro" + Eval("IdModulo") %>'>
                                <span><%# Eval("Titulo") %></span>
                            </div>
                            <a href='<%# "Modulo.aspx?id=" + Eval("IdModulo") %>' class="btn btn-outline-primary btn-sm" onclick="event.stopPropagation();">Ir a lección
                            </a>
                        </div>
                        <div id='<%# "intro" + Eval("IdModulo") %>' class="collapse card-body bg-light text-secondary">
                            <%# Eval("Introduccion") %>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>


        </div>
    </div>
</asp:Content>

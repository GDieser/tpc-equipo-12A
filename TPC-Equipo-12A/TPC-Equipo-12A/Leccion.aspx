<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Leccion.aspx.cs" Inherits="TPC_Equipo_12A.Leccion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container col-xl-8">
        <div class="container mt-4">

            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item">
                        <a href='<%= "Curso.aspx?id=" + IdCurso.ToString() %>'>Nombre del curso</a>
                    </li>
                    <li class="breadcrumb-item">
                        <a href='<%= "Modulo.aspx?id=" + IdModulo.ToString() %>'>Nombre del módulo</a>
                    </li>
                    <li class="breadcrumb-item active" aria-current="page">
                        <asp:Literal ID="litBreadcrumbLeccion" runat="server" />
                    </li>
                </ol>
            </nav>
            <hr />

            <h2 class="text-success">
                <asp:Literal ID="litTitulo" runat="server" /></h2>
            <p>
                <asp:Literal ID="litDescripcion" runat="server" />
            </p>
            <hr class="mt-2 mb-2" />

            <asp:Repeater ID="rptComponentes" runat="server" OnItemDataBound="rptComponentes_ItemDataBound">
                <ItemTemplate>
                    <div class="mb-4">

                        <!-- Texto -->
                        <asp:Panel ID="pnlTexto" runat="server" Visible="false" CssClass="text-justify my-2">
                            <asp:Literal ID="litTexto" runat="server" />
                        </asp:Panel>

                        <!-- Imagen -->
                        <asp:Panel ID="pnlImagen" runat="server" Visible="false" CssClass="my-4">
                            <div class="row justify-content-center">
                                <div class="col-sm-6 text-center">
                                    <asp:Image ID="imgContenido" runat="server" CssClass="img-fluid rounded" />
                                </div>
                            </div>
                        </asp:Panel>

                        <!-- Video -->
                        <asp:PlaceHolder ID="phVideo" runat="server" Visible="false" />

                        <!-- Archivo -->
                        <asp:Panel ID="pnlArchivo" runat="server" Visible="false" CssClass="my-2">
                            <i class="bi bi-file-earmark-text-fill text-primary"></i>
                            <asp:HyperLink ID="lnkArchivo" runat="server" Target="_blank" Text="" />
                        </asp:Panel>

                    </div>
                </ItemTemplate>
            </asp:Repeater>
            <hr class="mt-2 mb-2" />
            <asp:Button Text="Marcar como completada" CssClass="btn btn-primary" runat="server" ID="btnMarcarCompletada" OnClick="btnMarcarCompletada_Click" />
        </div>
    </div>
</asp:Content>

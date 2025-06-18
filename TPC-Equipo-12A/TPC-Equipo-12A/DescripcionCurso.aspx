<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="DescripcionCurso.aspx.cs" Inherits="TPC_Equipo_12A.DescripcionCurso" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">

        <div class="row my-4">
            <div class="col-md-8 d-flex flex-column justify-content-start">
                <h2 class="text-primary mb-3">
                    <asp:Label ID="lblTitulo" runat="server" />
                </h2>

                <h5 class="text-info">Descripción</h5>
                <asp:Label ID="lblDescripcion" runat="server" CssClass="text-white-50" />

                <hr class="border border-primary opacity-100 my-4" />

                <h5 class="text-info mb-3">Programa</h5>


                <div class="mb-3 p-3 border border-primary rounded bg-dark bg-opacity-50 text-white">
                    <div class="d-flex justify-content-between align-items-start">
                        <h5 class="me-3">Módulo 1:</h5>
                        <p class="mb-0">Descripción del módulo 1</p>
                    </div>
                </div>


                <div class="mb-3 p-3 border border-primary rounded bg-dark bg-opacity-50 text-white">
                    <div class="d-flex justify-content-between align-items-start">
                        <h5 class="me-3">Módulo 2:</h5>
                        <p class="mb-0">Descripción del módulo 2</p>
                    </div>
                </div>


                <div class="mb-3 p-3 border border-primary rounded bg-dark bg-opacity-50 text-white">
                    <div class="d-flex justify-content-between align-items-start">
                        <h5 class="me-3">Módulo 3:</h5>
                        <p class="mb-0">Descripción del módulo 3</p>
                    </div>
                </div>

            </div>



            <div class="col-md-4 d-flex flex-column align-items-center">
                <asp:Image ID="imgCurso"
                    runat="server"
                    CssClass="img-fluid rounded border border-primary mb-3"
                    Style="max-width: 100%; height: 250px; object-fit: cover;"
                    AlternateText="Imagen del curso" />

                <asp:Button CssClass="btn" ID="btnAgregarCarrito" OnClick="btnAgregarCarrito_Click" runat="server" />

                <!--Necesito para el aula un boton de fav-->
                <br />
                <asp:PlaceHolder ID="phBotonFavorito" runat="server" Visible="false">
                    <asp:Button ID="btnFavorito" OnClick="btnFavorito_Click" CssClass="btn" runat="server" />
                </asp:PlaceHolder>

            </div>
        </div>
    </div>
</asp:Content>


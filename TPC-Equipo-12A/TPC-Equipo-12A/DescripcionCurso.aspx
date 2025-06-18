<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="DescripcionCurso.aspx.cs" Inherits="TPC_Equipo_12A.DescripcionCurso" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container my-5">

        <div class="row g-4">
            <div class="col-md-8">
                <h2 class="text-light fw-bold">
                    <asp:Label ID="lblTitulo" runat="server" />
                </h2>

                <h5 class="text-info mt-3">Descripción</h5>
                <hr />
                <asp:Label ID="lblDescripcion" runat="server" CssClass="text-white-75" />


            </div>

            <div class="col-md-4">
                <div class="card bg-dark text-white shadow rounded-4">
                    <asp:Image ID="imgCurso" runat="server" CssClass="card-img-top rounded-top" Style="height: 250px; object-fit: cover;" AlternateText="Imagen del curso" />

                    <div class="card-body text-center">
                        <h5 class="text-white mb-3 fw-semibold">
                            <asp:Label ID="lblPrecio" runat="server" Text="" />
                        </h5>

                        <div class="d-flex justify-content-center gap-3">
                            <asp:Button CssClass="btn" ID="btnAgregarCarrito" OnClick="btnAgregarCarrito_Click" runat="server" />

                            <!--Necesito para el aula un boton de fav-->
                            <br />
                            <asp:PlaceHolder ID="phBotonFavorito" runat="server" Visible="false">
                                <asp:Button ID="btnFavorito" OnClick="btnFavorito_Click" CssClass="btn" runat="server" />
                            </asp:PlaceHolder>

                        </div>
                    </div>
                </div>
            </div>
        </div>
        <hr />

        <p class="mt-4 small text-center">
            ¿Aun no sos parte de MisCursos.com?  
        <a href="https://localhost:44341/Registro.aspx" class="text-info fw-bold text-decoration-none">¡Registrate, es gratis!</a>
        </p>
    </div>

</asp:Content>


<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="PublicacionLista.aspx.cs" Inherits="TPC_Equipo_12A.PublicacionLista" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container text-center">
        <br />
        <h1>Lisa de Novedades</h1>
        <br />

        <div class="mb-4">
            <div class="table-responsive">

                <asp:GridView ID="dgvPublicaciones" CssClass="table table-striped table-dark table-hover table-bordered align-middle text-center" DataKeyNames="IdPublicacion" AutoGenerateColumns="false" runat="server" AllowPaging="true" PageSize="12" OnSelectedIndexChanged="dgvPublicaciones_SelectedIndexChanged" OnPageIndexChanging="dgvPublicaciones_PageIndexChanging">
                    <HeaderStyle CssClass="table-warning" />
                    <Columns>

                        <asp:BoundField HeaderText="Id Publicacion" DataField="IdPublicacion" />
                        <asp:BoundField HeaderText="Titulo" DataField="Titulo" />
                        <asp:BoundField HeaderText="Categoria" DataField="Categoria.Nombre" />
                        <asp:BoundField HeaderText="Fecha Publicacion" DataField="FechaPublicacion" />
                        <asp:BoundField HeaderText="Estado" DataField="Estado" />
                        <asp:CommandField HeaderText="Modificar" ShowSelectButton="true" SelectText="✍️" />

                    </Columns>

                </asp:GridView>

                <asp:Button Text="Agregar Nueva Publicacion" ID="btnAgregar" CssClass="btn btn-primary" OnClick="btnAgregar_Click" runat="server" />
            </div>
        </div>
    </div>

</asp:Content>

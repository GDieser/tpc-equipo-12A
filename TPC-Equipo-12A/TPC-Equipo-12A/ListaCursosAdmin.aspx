<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="ListaCursosAdmin.aspx.cs" Inherits="TPC_Equipo_12A.ListaCursosAdmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container text-center">
        <br />
        <h1>Lista de Cursos</h1>
        <br />

        <div class="mb-4">
            <div class="table-responsive">

                <asp:GridView ID="dgvCursos"
                    runat="server"
                    CssClass="table table-striped table-dark table-hover table-bordered align-middle text-center"
                    AutoGenerateColumns="false"
                    DataKeyNames="IdCurso"
                    AllowPaging="true"
                    PageSize="10"
                    OnPageIndexChanging="dgvCursos_PageIndexChanging"
                    OnSelectedIndexChanged="dgvCursos_SelectedIndexChanged">
                    <HeaderStyle CssClass="table-warning" />
                    <Columns>
                        <asp:BoundField HeaderText="ID Curso" DataField="IdCurso" />
                        <asp:BoundField HeaderText="Título" DataField="Titulo" />
                        <asp:BoundField HeaderText="Categoría" DataField="Categoria.Nombre" />
                        <asp:BoundField HeaderText="Precio" DataField="Precio" DataFormatString="{0:C}" />
                        <asp:BoundField HeaderText="Estado" DataField="Estado" />
                        <asp:BoundField HeaderText="Fecha Publicación" DataField="FechaPublicacion" DataFormatString="{0:dd/MM/yyyy}" />
                        <asp:CommandField HeaderText="Modificar"
                            ShowSelectButton="true"
                            SelectText="✍️" />
                    </Columns>
                </asp:GridView>
                <asp:Button ID="btnAgregar"
                    runat="server"
                    Text="➕ Agregar Nuevo Curso"
                    CssClass="btn btn-success mt-4"
                    OnClick="btnAgregar_Click" />
            </div>
        </div>
    </div>
</asp:Content>


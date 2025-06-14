<%@ Page Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="ListaCursos.aspx.cs" Inherits="TPC_Equipo_12A.ListaCurso" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-4">

        <div class="text-center mb-5">
            <h1 class="display-5 fw-bold text-info">¡Explorá nuestros cursos!</h1>
            <p class="lead text-white-50">Formate con profesionales y descubrí contenido actualizado pensado para vos.</p>
        </div>
        <div class="row mb-4 align-items-center">
            <div class="col-md-6">
                <h3 class="text-white">Cursos disponibles</h3>
            </div>
            <div class="col-md-6 text-end">
                <asp:DropDownList
                    ID="ddlFiltroCategoria"
                    runat="server"
                    CssClass="form-select d-inline-block me-2 w-auto" />
                <asp:Button
                    Text="Filtrar"
                    CssClass="btn btn-info"
                    ID="btnFiltrar"
                    OnClick="btnFiltrar_Click"
                    runat="server" />
            </div>
        </div>

     <div class="row row-cols-1 row-cols-md-3 g-5">
    <asp:Repeater ID="rptCursos" runat="server">
        <ItemTemplate>
            <div class="col d-flex">
                <div class="card h-100 border-primary bg-dark text-white w-100">
                    <div class="card-body text-center">
                        <h5 class="card-title text-info"><%# Eval("Titulo") %></h5>

                        <img
                            src='<%# Eval("ImagenPortada.Url") %>'
                            onerror="this.onerror=null;this.src='https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/480px-No_image_available.svg.png';"
                            class="card-img-top my-3"
                            alt="Imagen no disponible"
                            style="height: 250px; object-fit: cover;" />

                        <p class="card-text"><%# Eval("Resumen") %></p>
                    </div>
                    <div class="card-footer bg-transparent text-center border-top">
                        <a href='DescripcionCurso.aspx?id=<%# Eval("IdCurso") %>' class="btn btn-outline-info me-2">Ver más</a>
                        <a href='Inscripcion.aspx?id=<%# Eval("IdCurso") %>' class="btn btn-outline-success">Suscribirse</a>
                    </div>
                </div>
            </div>
        </ItemTemplate>
    </asp:Repeater>
</div>

    </div>
</asp:Content>

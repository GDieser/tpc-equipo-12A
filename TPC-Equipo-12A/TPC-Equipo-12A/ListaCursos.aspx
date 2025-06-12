<%@ Page Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="ListaCursos.aspx.cs" Inherits="TPC_Equipo_12A.ListaCurso" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <h1 class="text-center mt-4">Cursos Disponibles</h1>
    <hr />

    <asp:Repeater ID="rptCursos" runat="server">
     <ItemTemplate>
    <div class="card mb-4 border-primary bg-dark bg-opacity-75 text-white">
        <div class="row g-0">
            
            <div class="col-md-3 border-end border-primary">
                <img src='<%# Eval("ImagenUrl") %>' class="img-fluid rounded-start h-100" style="object-fit: cover;" alt="alternative tex" />
            </div>

            <div class="col-md-6 border-end border-primary d-flex align-items-center">
                <div class="card-body">
                    <h4 class="card-title text"><%# Eval("Titulo") %></h4>
                    <p class="card-text text"><%# Eval("Resumen") %></p>
                </div>
            </div>

            <div class="col-md-3 d-flex flex-column justify-content-center align-items-center p-3">
                <a href= 'DescripcionCurso.aspx?id=<%# Eval("IdCurso") %>'class="btn btn-outline-info w-75 mb-2">Ver más</a>
                <a href='Inscripcion.aspx?id=<%# Eval("IdCurso") %>' class="btn btn-outline-success w-75">Suscribirse</a>
            </div>

        </div>
    </div>
</ItemTemplate>


    </asp:Repeater>

</asp:Content>

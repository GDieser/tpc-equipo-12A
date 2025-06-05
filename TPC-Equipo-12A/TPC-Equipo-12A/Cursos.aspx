<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Cursos.aspx.cs" Inherits="TPC_Equipo_12A.Cursos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .curso-card {
            width: 75%;
            height: 250px;
            background-color: #212529;
            border: 1px solid #0d6efd;
            color: white;
            border-radius: .5rem;
            display: flex;
            margin: 1rem auto;
        }

        .curso-img {
            width: 25%;
            border-right: 1px solid #0d6efd;
            height: 100%;
            object-fit: cover;
            border-top-left-radius: .5rem;
            border-bottom-left-radius: .5rem;
        }

        .curso-contenido {
            width: 50%;
            padding: 1.5rem;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .curso-acciones {
            width: 25%;
            border-left: 1px solid #0d6efd;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding-left: 1rem;
            padding-right: 1rem;
        }

        .curso-acciones button {
            margin-bottom: 2rem;
        }

        .curso-acciones button:last-child {
            margin-bottom: 0;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:PlaceHolder ID="phCursos" runat="server"></asp:PlaceHolder>
</asp:Content>

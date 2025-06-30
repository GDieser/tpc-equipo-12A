<%@ Page Title="Mis Cursos" Language="C#" MasterPageFile="~/Aula.master" AutoEventWireup="true" CodeBehind="MisCursos.aspx.cs" Inherits="TPC_Equipo_12A.MisCursos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AulaContent" runat="server">

    <style>
        .hover-card {
            transition: all 0.3s ease;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

            .hover-card:hover {
                transform: translateY(-3px);
                box-shadow: 0 6px 12px rgba(13, 202, 240, 0.15);
                border-color: #0dcaf0 !important;
            }


        .card-title {
            transition: color 0.2s ease;
        }

        a:hover .card-title {
            color: #0dcaf0 !important;
        }
    </style>

    <div class="container py-4">

        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1 class="text-info mb-0">
                <i class="bi bi-journal-bookmark-fill me-2"></i>Mis Cursos Inscritos
            </h1>
        </div>

        <hr class="border-secondary mb-4" />

        <div class="row justify-content-center">
            <div class="col-lg-10 col-md-12">
                <div class="row row-cols-1 g-4">
                    <asp:Repeater ID="rptMisCursos" runat="server">
                        <ItemTemplate>
                            <div class="col">
                                <a href='ForoCurso.aspx?IdCurso=<%# Eval("IdCurso") %>' class="text-decoration-none">
                                    <div class="card bg-dark border border-secondary hover-card h-100">
                                        <div class="row g-0 h-100">
                                            <div class="col-md-4 h-100">
                                                <img src='<%# Eval("UrlImagen") %>' class="img-fluid h-100 w-100 object-fit-cover rounded-start" alt="Imagen del curso" />
                                            </div>

                                            <div class="col-md-8 d-flex align-items-center">
                                                <div class="card-body py-3">
                                                    <h5 class="card-title text-white mb-2">
                                                        <i class="bi bi-book me-2"></i><%# Eval("NombreCurso") %>
                                                    </h5>

                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <small class="text-muted">
                                                            <i class="bi bi-clock-history me-1"></i>

                                                        </small>
                                                        <span class="badge bg-success fs-6 px-3 py-2 rounded-pill shadow-sm">
                                                            <%# Eval("PorcentajeCompletado") %>% completado
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </ItemTemplate>

                        <FooterTemplate>
                            <asp:Label runat="server" Visible='<%# rptMisCursos.Items.Count == 0 %>'
                                Text="Actualmente no estás inscrito en ningún curso"
                                CssClass="text-center text-muted py-5" />
                        </FooterTemplate>

                    </asp:Repeater>
                </div>
            </div>
        </div>
    </div>


</asp:Content>


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


    <div class="mb-5">
        <h1 class="text-info mb-0">
            <i class="bi bi-journal-bookmark-fill me-2"></i>Mis Cursos Inscritos
        </h1>
        <p class="lead text-white-50">
            ¡Acá vas a encontrar los cursos en los que estas inscrito!
        </p>
    </div>

    <hr class="border-secondary mb-4" />

    <div class="row justify-content-center">
        <div class="col-lg-8 col-md-10">
            <div class="row row-cols-1 g-4">
                <asp:Repeater ID="rptMisCursos" runat="server">
                    <ItemTemplate>
                        <div class="col">
                            <a href='ForoCurso.aspx?IdCurso=<%# Eval("IdCurso") %>' class="text-decoration-none">
                                <div class="card bg-dark border border-secondary hover-card h-65">
                                    <div class="row g-0 h-65">
                                        <div class="col-md-4">
                                            <img src='<%# Eval("UrlImagen") %>' class="img-fluid w-65 h-65 object-fit-cover rounded-end-5" alt="Imagen del curso" />
                                        </div>

                                        <div class="col-md-8 d-flex align-items-center">
                                            <div class="card-body py-1 px-2 d-flex flex-column justify-content-between h-65">
                                                <h4 class="card-title text-white fw-semibold">
                                                    <i class="bi bi-book me-2"></i><%# Eval("NombreCurso") %>
                                                </h4>

                                                <div class="mt-1">
                                                    <div class="d-flex justify-content-between align-items-center mb-1">
                                                        <small class="text-muted">
                                                            <i class="bi bi-clock-history me-1"></i>Progreso
                                                        </small>
                                                        <small class="text-white fw-bold">
                                                            <%# Eval("PorcentajeCompletado") %>%
                                                        </small>
                                                    </div>
                                                    <div class="progress" style="height: 1.2rem;">
                                                        <div class='progress-bar progress-bar-striped progress-bar-animated <%# ColoresProgeso(Convert.ToInt32(Eval("PorcentajeCompletado"))) %>'
                                                            role="progressbar"
                                                            style='width: <%# Eval("PorcentajeCompletado") %>%;'
                                                            aria-valuenow='<%# Eval("PorcentajeCompletado") %>' aria-valuemin="0" aria-valuemax="100">
                                                        </div>
                                                    </div>
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

</asp:Content>


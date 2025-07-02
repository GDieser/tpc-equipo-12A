<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="DetalleUsuario.aspx.cs" Inherits="TPC_Equipo_12A.DetalleUsuario" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container text-center">
        <hr />
        <asp:Panel ID="pnlUsuarioDetalle" runat="server" CssClass="card mb-4 p-3 shadow-sm bg-dark text-white">
            <div class="d-flex align-items-center">
                <asp:Image ID="imgFotoPerfil" runat="server" CssClass="rounded-circle me-3" Width="100px" Height="100px" />

                <div>
                    <h4 class="mb-0">
                        <asp:Label ID="lblNombreCompleto" runat="server" CssClass="fw-bold" />
                        - 
                        <small class="text-white">@<asp:Label ID="lblNombreUsuario" runat="server" /></small>
                    </h4>
                </div>
            </div>

            <hr />

            <div class="row">
                <div class="col-md-6">
                    <p class="mb-1">
                        <strong>Fecha de registro:</strong>
                        <asp:Label ID="lblFechaRegistro" runat="server" />
                        -  
                        <strong>Email:</strong>
                        <asp:Label ID="lblEmail" runat="server" />
                    </p>
                </div>
                <div class="col-md-6">
                    <p class="mb-1">
                        <strong>Estado:</strong>
                        <asp:Label ID="lblHabilitado" runat="server" CssClass="badge" />
                    </p>
                </div>
            </div>
        </asp:Panel>

        <h3 class="mb-3">Cursos Inscritos</h3>
        <div class="mb-5">
            <div class="table-responsive">
                <asp:GridView ID="gvDatosCursos" CssClass="table table-hover table-dark table-bordered align-middle" AutoGenerateColumns="false" runat="server"
                    EmptyDataText="No se encontraron datos de cursos" EmptyDataRowStyle-CssClass="text-center text-light py-4">
                    <HeaderStyle CssClass="table-warning" />
                    <Columns>
                        <asp:BoundField HeaderText="Nombre del Curso" DataField="NombreCurso" ItemStyle-CssClass="fw-semibold" />
                        <asp:BoundField HeaderText="Lecciones totales" DataField="TotalLecciones" />
                        <asp:BoundField HeaderText="Lecciones completadas" DataField="LeccionesCompletadas" />
                        <asp:TemplateField HeaderText="Porcentaje de avance">
                            <ItemTemplate>
                                <div class="progress" style="height: 24px;">
                                    <div class="progress-bar bg-success progress-bar-striped"
                                        role="progressbar"
                                        style='width: <%# Eval("PorcentajeCompletado") %>%;'
                                        aria-valuenow='<%# Eval("PorcentajeCompletado") %>'
                                        aria-valuemin="0"
                                        aria-valuemax="100">
                                        <%# Eval("PorcentajeCompletado") %>%
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Acción">
                            <ItemTemplate>
                                <a href='<%# Eval("UrlCurso") %>' title="Ver curso" class="btn btn-primary btn-sm">Ver curso </a>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>

        <hr class="my-4" />

        <h3 class="mb-3">Historial de Compras</h3>
        <div class="table-responsive mb-5">
            <asp:GridView runat="server" ID="gvComprasUsuario" CssClass="table table-dark table-hover table-bordered align-middle" AutoGenerateColumns="false"
                EmptyDataText="No se encontraron registros de compra" EmptyDataRowStyle-CssClass="text-center text-light py-4">
                <HeaderStyle CssClass="table-warning" />
                <Columns>
                    <asp:BoundField HeaderText="N° Compra" DataField="IdCompra" />
                    <asp:BoundField HeaderText="Fecha" DataField="FechaCompra" DataFormatString="{0:d}" />
                    <asp:BoundField HeaderText="Estado" DataField="Estado" />
                    <asp:BoundField HeaderText="Código Transacción" DataField="CodigoTransaccion" />
                </Columns>
            </asp:GridView>
        </div>

        <hr class="my-4" />

        <h3 class="mb-3">Reportes recibidos</h3>
        <div class="table-responsive">
            <asp:GridView runat="server" ID="gvReportes" CssClass="table table-dark table-hover table-bordered align-middle" AutoGenerateColumns="false"
                EmptyDataText="No hay reportes recibidos" EmptyDataRowStyle-CssClass="text-center text-light py-4">
                <HeaderStyle CssClass="table-warning" />
                <Columns>
                    <asp:BoundField HeaderText="Comentario" DataField="Contenido" />
                    <asp:BoundField HeaderText="Fecha" DataField="FechaNotificacion" DataFormatString="{0:d}" />
                    <asp:BoundField HeaderText="Motivo" DataField="MotivoReporte" />
                    <asp:BoundField HeaderText="Reportador por" DataField="NombreUsuario" />
                </Columns>
            </asp:GridView>
        </div>

        <hr class="my-4" />

        <h3 class="mb-3">Comentarios del usuario</h3>
        <div class="table-responsive">
            <asp:GridView runat="server" ID="gvComentarios" CssClass="table table-dark table-hover table-bordered align-middle" AutoGenerateColumns="false"
                EmptyDataText="No se encontraron comentarios" EmptyDataRowStyle-CssClass="text-center text-light py-4">
                <HeaderStyle CssClass="table-warning" />
                <Columns>
                    <asp:BoundField HeaderText="Comentario" DataField="Comentario" />
                    <asp:BoundField HeaderText="Fecha" DataField="FechaCreacion" DataFormatString="{0:d}" />
                    <asp:BoundField HeaderText="Origen" DataField="TipoOrigen" />
                </Columns>
            </asp:GridView>
        </div>
        
        <a href="ListaUsuarios.aspx" class="btn btn-primary">Volver a la lista</a>

    </div>
    <hr />
</asp:Content>

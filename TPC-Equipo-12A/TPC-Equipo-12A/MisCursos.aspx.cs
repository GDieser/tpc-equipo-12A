﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Servicio;
using Dominio;

namespace TPC_Equipo_12A
{
    public partial class MisCursos : System.Web.UI.Page
    {
        UsuarioAutenticado usuario;
        protected void Page_Load(object sender, EventArgs e)
        {
            usuario = (UsuarioAutenticado)Session["UsuarioAutenticado"];
            CursoServicio servicio = new CursoServicio();
            List<CursoDTO> lista = new List<CursoDTO>();

            if (usuario == null)
            {
                Session.Add("error", "Hey, no deberías andar por acá 🤨. Acceso no permitido");
                Response.Redirect("Error.aspx");
            }

            if (!IsPostBack)
            {
                lista = servicio.ObtenerCursosCompletosDeUsuario(usuario.IdUsuario, (usuario.Rol) == Rol.Administrador ? true : false);

                rptMisCursos.DataSource = lista;
                rptMisCursos.DataBind();
            }

        }

        protected string ColoresProgeso(int porcentaje)
        {
            if (porcentaje >= 80)
                return "bg-success";
            else if (porcentaje >= 40)
                return "bg-warning";
            else
                return "bg-danger";
        }

    }
}
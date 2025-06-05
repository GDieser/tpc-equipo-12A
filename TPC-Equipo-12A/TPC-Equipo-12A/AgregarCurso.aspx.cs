using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TPC_Equipo_12A
{
    public partial class AgregarCurso : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                imgCurso.ImageUrl = "https://wiratthungsong.com/wts/assets/img/default.png";
            }
        }
        protected void txtImagenUrl_TextChanged(object sender, EventArgs e)
        {
            imgCurso.ImageUrl = txtImagenUrl.Text;
        }
    }
}
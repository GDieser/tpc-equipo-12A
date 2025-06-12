using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TPC_Equipo_12A
{
    public enum TipoError
    {
        SUCCESS,	
        ERROR,
        WARNING,
        INFO,
        QUESTION
    }

    public static class TipoErrorUtils
    {
        public static string EnumATexto(TipoError tipo)
        {
            return tipo.ToString().ToLower(); 
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Utils
{
    public class ControlEventArgs : EventArgs
    {
        public int Id { get; }
        public string Vista { get; }

        public ControlEventArgs(int id, string vista)
        {
            Id = id;
            Vista = vista;
        }
    }
}

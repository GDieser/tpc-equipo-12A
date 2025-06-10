namespace Dominio
{
    public class Categoria
    {
        public int IdCategoria { get; set; }
        public string Nombre { get; set; }

        public override string ToString()
        {
            return Nombre;
        }
    }
}

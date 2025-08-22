using System.ComponentModel.DataAnnotations;

namespace MiniProject2.Model
{
    public class Customer
    {
        [Key]
        public int CustomerId { get; set; }

        public string Name { get; set; }

        [Range(18,100)]
        public int Age { get; set; }
    }
}

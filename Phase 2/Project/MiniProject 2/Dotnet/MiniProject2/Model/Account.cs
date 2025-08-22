using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MiniProject2.Model
{
    public class Account
    {
        [Key]
        public int AccountId { get; set; } 
        public int CustomerId { get; set; }

        public int Number { get; set; }

        public int Balance { get; set; }

        public DateOnly CreatedDate { get; set; }

        [ForeignKey("CustomerId")]
        public Customer customer { get; set; }
    }
}


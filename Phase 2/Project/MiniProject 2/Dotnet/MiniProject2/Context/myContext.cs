using Microsoft.EntityFrameworkCore;
using MiniProject2.Model;

namespace MiniProject2.Context
{
    public class myContext : DbContext
    {
        public myContext(DbContextOptions<myContext> options) : base(options) { }

        public DbSet<Account> account { get; set; }

        public DbSet<Customer> customer { get; set; }


    }
}

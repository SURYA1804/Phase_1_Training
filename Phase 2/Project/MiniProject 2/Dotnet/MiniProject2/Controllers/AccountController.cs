using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using MiniProject2.Context;
using MiniProject2.DTO;
using MiniProject2.Mapper;
using MiniProject2.Model;
using System.IO;


namespace MiniProject2.Controllers
{
    [Route("Account")]
    [ApiController]
    public class AccountController : ControllerBase
    {
        private myContext myContext {  get; set; }
        private IMapper myMapper { get; set; }

        public AccountController(myContext myContext, IMapper myMapper)
        {
            this.myContext = myContext;
            this.myMapper = myMapper;
        }

        [HttpGet("GetAllAccount")]
        public IActionResult GetAllAccount()
        {
            var allAccounts = myContext.account.Include(m => m.customer ).ToList();
            var accountsToSend = myMapper.Map<List<AccountDTO>>(allAccounts);
            return Ok(accountsToSend);
        }

        [HttpGet("GetAccountByID")]
        public IActionResult GetAccountByID(int AccountNumber)
        {
            var allAccounts = myContext.account.Where(m => m.Number == AccountNumber).Include(m => m.customer).FirstOrDefault();
            if(allAccounts == null)
            {
                return NotFound();
            }
            var accountsToSend = myMapper.Map<AccountDTO>(allAccounts);
            return Ok(accountsToSend);
        }
        [Authorize(Roles ="admin")]
        [HttpPost("CreateAccount")]
        public IActionResult CreateAccount([FromBody] AccountDTO account)
        {
            if (account == null)
            {
                return BadRequest();
            }
            if(account.Age<18)
            {
                return BadRequest("Customer Age should be greater than 18");
            }

            var customer = myContext.customer.FirstOrDefault(d => d.Name == account.CustomerName);
            if (customer == null)
            {
                customer = new Customer { Name = account.CustomerName,Age = account.Age };
                myContext.customer.Add(customer);
                myContext.SaveChanges();
            }
            var AccountToAdd = new Account { customer = customer,CustomerId = customer.CustomerId,
            Balance = account.Balance,Number = account.AccountNumber,CreatedDate = account.CreatedDate};

            myContext.account.Add(AccountToAdd);
            myContext.SaveChanges();
            return CreatedAtAction(nameof(GetAccountByID), new { AccountNumber = AccountToAdd.Number }, AccountToAdd);

        }


        [HttpDelete("DeleteById")]
        public IActionResult DeleteById(int AccountNumber)
        {
            var accountToDelete = myContext.account.FirstOrDefault(m => m.Number == AccountNumber);
            if(accountToDelete == null)
            {
                return NotFound();
            }
            myContext.account.Remove(accountToDelete);
            myContext.SaveChanges();
            return NoContent();
        }
    }
}

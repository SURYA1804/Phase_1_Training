using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using MiniProject2.Context;
using MiniProject2.DTO;
using MiniProject2.Model;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

[ApiController]
[Route("Customer")]
public class CustomerController : ControllerBase
{
    private readonly myContext _context;
    private readonly IMapper _mapper;

    public CustomerController(myContext context, IMapper mapper)
    {
        _context = context;
        _mapper = mapper;
    }

    [HttpGet("GetAllCustomer")]
    public IActionResult GetAllCustomer()
    {
        var customers =  _context.customer.ToList();
        var result = _mapper.Map<List<CustomerDTO>>(customers);
        return Ok(result);
    }

    [HttpGet("GetCustomerByID")]
    public IActionResult GetCustomerByID(int id)
    {
        var customer =  _context.customer.FirstOrDefault(c => c.CustomerId == id);
        if (customer == null)
            return NotFound();

        return Ok(_mapper.Map<CustomerDTO>(customer));
    }

    [Authorize(Roles = "admin")]
    [HttpPost("CreateCustomer")]
    public IActionResult Create([FromBody] CustomerDTO dto)
    {


        var entity = _mapper.Map<Customer>(dto);
        _context.customer.Add(entity);
        _context.SaveChangesAsync();

        var createdDto = _mapper.Map<CustomerDTO>(entity);
        return CreatedAtAction(nameof(GetCustomerByID), new { id = entity.CustomerId }, createdDto);
    }

    [HttpDelete("DeleteCustomer")]
    public IActionResult DeleteCustomer(int id)
    {
        var entity =  _context.customer.FirstOrDefault(c => c.CustomerId == id);
        if (entity == null)
            return NotFound();

        _context.customer.Remove(entity);
        _context.SaveChangesAsync();
        return NoContent();
    }

    [HttpGet("GetTotalBalance")]
    public IActionResult GetTotalBalance(string CustomerName)
    {
        var result = _context.account.Where(m => m.customer.Name == CustomerName).Sum(m => m.Balance);
        return Ok(new
        {
            TotalBalance = result
        });
    }
    [Authorize]
    [HttpGet("GetMyBalance")]
    public IActionResult GetMyResult()
    {
        var name = User.Claims.FirstOrDefault(c => c.Type == "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name")?.Value;
        var result = _context.account.Where(m => m.customer.Name == name).Sum(m => m.Balance);
        return Ok(new
        {
            MyBalance = result
        });
    }

}

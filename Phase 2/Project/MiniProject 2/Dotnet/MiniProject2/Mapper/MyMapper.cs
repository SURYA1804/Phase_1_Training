using AutoMapper;
using MiniProject2.DTO;
using MiniProject2.Model;


namespace MiniProject2.Mapper
{
    public class MyMapper:Profile
    {
        public MyMapper()
        {
            CreateMap<Account, AccountDTO>()
                .ForMember(dest => dest.AccountNumber, opt => opt.MapFrom(src => src.Number))
                .ForMember(dest => dest.Age, opt => opt.MapFrom(src => src.customer != null ? src.customer.Age : 0));

            CreateMap<Account, NewAccountDTO>()
              .ForMember(dest => dest.AccountNumber, opt => opt.MapFrom(src => src.Number));
             // .ForMember(dest => dest.Age, opt => opt.MapFrom(src => src.customer != null ? src.customer.Age : 0));

            CreateMap<AccountDTO, Account>()
                .ForMember(dest => dest.Number, opt => opt.MapFrom(src => src.AccountNumber));
            CreateMap<Customer, CustomerDTO>();
            CreateMap<CustomerDTO, Customer>();
        }
    }
}

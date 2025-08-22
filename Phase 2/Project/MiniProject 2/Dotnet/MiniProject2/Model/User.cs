namespace MiniProject2.Model
{
    public class UserResponse
    {
        public string Message { get; set; }
        public User User { get; set; }
    }

    public class User
    {
        public string Name { get; set; }
        public string Role { get; set; }
    }

}

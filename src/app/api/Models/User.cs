using System.ComponentModel.DataAnnotations;

namespace Api.Models;

public class User
{
    [Key]
    public string? Id { get; set; }
    public string? Name { get; set; }
    public string? Email { get; set; }
    public string? Role { get; set; }
}
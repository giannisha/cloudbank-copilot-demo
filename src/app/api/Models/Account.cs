using System.ComponentModel.DataAnnotations;

namespace Api.Models;

public class Account
{
    [Key]
    public string? Number { get; set; }
    public string? Title { get; set; }
}
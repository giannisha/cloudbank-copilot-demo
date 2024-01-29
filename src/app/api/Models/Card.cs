using System.ComponentModel.DataAnnotations;

namespace Api.Models;

public class Card
{
    [Key]
    public string? Number { get; set; }
    public string? Title { get; set; }
}
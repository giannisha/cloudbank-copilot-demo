namespace Api.Models;

public class AccountTransaction
{
    public int Id { get; set; }
    public string? From { get; set; }
    public string? To { get; set; }
    public DateTime Date { get; set; }
    public string? Description { get; set; }
    public decimal Amount { get; set; }
    public string? Type { get; set; }
    public string? Category { get; set; }
}
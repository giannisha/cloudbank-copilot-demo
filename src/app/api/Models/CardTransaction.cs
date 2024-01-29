namespace Api.Models;

public class CardTransaction
{
    public int Id { get; set; }
    public string? CardNumber { get; set; }
    public decimal Amount { get; set; }
    public DateTime Date { get; set; }
    public string? MerchantName { get; set; }
    public string? Type { get; set; }
    public string? Location { get; set; }
    public string? Description { get; set; }
    public string? Category { get; set; }
}
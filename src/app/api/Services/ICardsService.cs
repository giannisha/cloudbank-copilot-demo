
using Api.Models;

namespace Api.Services;

public interface ICardsService
{
    Task<IReadOnlyList<CardTransaction>> GetAllCardTransactions();
}
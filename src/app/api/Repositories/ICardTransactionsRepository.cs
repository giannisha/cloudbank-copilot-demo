using Api.Models;

namespace Api.Repositories;

public interface ICardTransactionsRepository
{
    Task<IReadOnlyList<CardTransaction>> GetAllCardTransactions();
}
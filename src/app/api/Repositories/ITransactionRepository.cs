
using Api.Models;

namespace Api.Repositories;

public interface ITransactionsRepository
{
    Task<List<AccountTransaction>> GetTransactions(string accountName);
    Task<AccountTransaction> CreateTransaction(AccountTransaction transaction);
    Task<List<AccountTransaction>> GetAllTransactions();
}
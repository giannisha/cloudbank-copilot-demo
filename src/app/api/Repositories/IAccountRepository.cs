
using Api.Models;

namespace Api.Repositories;

public interface IAccountsRepository
{
    Task<Account?> GetAccount(string name);
    Task<List<Account>> GetAccounts();
    Task<Account> CreateAccount(Account account);
    Task<Account> UpdateAccount(Account account);
    Task DeleteAccount(string name);
}
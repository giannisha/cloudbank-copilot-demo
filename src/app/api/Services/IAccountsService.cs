using Api.Models;

namespace Api.Services;

public interface IAccountsService
{
    Task<Account?> GetAccount(string number);
    Task<List<Account>> GetAccounts();
    Task<Account> CreateAccount(Account account);
    Task<Account> UpdateAccount(Account account);
    Task DeleteAccount(string number);
    Task<List<AccountTransaction>> GetTransactions(string accountNumber);
    Task<AccountTransaction> CreateTransaction(AccountTransaction transaction);
    Task<List<AccountTransaction>> GetAllTransactions();
}
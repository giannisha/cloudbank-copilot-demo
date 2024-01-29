using Api.Models;
using Api.Repositories;

namespace Api.Services;

public class AccountsService : IAccountsService
{
    private readonly IAccountsRepository _accountsRepo;
    private readonly ITransactionsRepository _transactionsRepo;

    public AccountsService(IAccountsRepository accountsRepo, ITransactionsRepository transactionsRepo)
    {
        _accountsRepo = accountsRepo;
        _transactionsRepo = transactionsRepo;
    }

    public async Task<Account?> GetAccount(string number)
    {
        return await _accountsRepo.GetAccount(number);
    }

    public async Task<List<Account>> GetAccounts()
    {
        return await _accountsRepo.GetAccounts();
    }

    public async Task<Account> CreateAccount(Account account)
    {
        return await _accountsRepo.CreateAccount(account);
    }

    public async Task<Account> UpdateAccount(Account account)
    {
        return await _accountsRepo.UpdateAccount(account);
    }

    public async Task DeleteAccount(string number)
    {
        await _accountsRepo.DeleteAccount(number);
    }

    public async Task<List<AccountTransaction>> GetTransactions(string accountNumber)
    {
        return await _transactionsRepo.GetTransactions(accountNumber);
    }

    public async Task<AccountTransaction> CreateTransaction(AccountTransaction transaction)
    {
        return await _transactionsRepo.CreateTransaction(transaction);
    }

    public async Task<List<AccountTransaction>> GetAllTransactions()
    {
        return await _transactionsRepo.GetAllTransactions();
    }
}
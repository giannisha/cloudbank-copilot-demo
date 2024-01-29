using Api.Models;
using Microsoft.EntityFrameworkCore;

namespace Api.Repositories;

public class AccountsRepository : IAccountsRepository
{
    private readonly CloudBankDb _db;

    public AccountsRepository(CloudBankDb db)
    {
        _db = db;
    }

    public async Task<Account?> GetAccount(string number)
    {
        return await _db.Accounts.FirstOrDefaultAsync(a => a.Number == number);
    }

    public async Task<List<Account>> GetAccounts()
    {
        return await _db.Accounts.ToListAsync();
    }

    public async Task<Account> CreateAccount(Account account)
    {
        _db.Accounts.Add(account);
        await _db.SaveChangesAsync();
        return account;
    }

    public async Task<Account> UpdateAccount(Account account)
    {
        _db.Accounts.Update(account);
        await _db.SaveChangesAsync();
        return account;
    }

    public async Task DeleteAccount(string number)
    {
        var account = await _db.Accounts.FirstOrDefaultAsync(a => a.Number == number);
        if (account != null)
        {
            _db.Accounts.Remove(account);
            await _db.SaveChangesAsync();
        }
    }


}
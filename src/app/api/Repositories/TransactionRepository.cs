using Api.Models;
using Microsoft.EntityFrameworkCore;

namespace Api.Repositories;

public class TransactionsRepository : ITransactionsRepository
{
    private readonly CloudBankDb _db;

    public TransactionsRepository(CloudBankDb db)
    {
        _db = db;
    }

    public async Task<List<AccountTransaction>> GetTransactions(string accountNumber)
    {
        return await _db.Transactions.Where(t => t.From == accountNumber).ToListAsync();
    }

    public async Task<AccountTransaction> CreateTransaction(AccountTransaction transaction)
    {
        _db.Transactions.Add(transaction);
        await _db.SaveChangesAsync();
        return transaction;
    }

    public async Task<List<AccountTransaction>> GetAllTransactions()
    {
        return await _db.Transactions.ToListAsync();
    }
}
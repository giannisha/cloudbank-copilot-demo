using Api.Models;
using Microsoft.EntityFrameworkCore;

namespace Api.Repositories;

public class CardTransactionsRepository : ICardTransactionsRepository
{
    private readonly CloudBankDb _db;

    public CardTransactionsRepository(CloudBankDb db)
    {
        _db = db;
    }

    public async Task<IReadOnlyList<CardTransaction>> GetAllCardTransactions()
    {
        return await _db.CardTransactions.ToListAsync();
    }
}
using Api.Models;
using Api.Repositories;

namespace Api.Services;

public class CardsService : ICardsService
{
    private readonly ICardTransactionsRepository _cardTransactionsRepository;

    public CardsService(ICardTransactionsRepository cardTransactionsRepository)
    {
        _cardTransactionsRepository = cardTransactionsRepository;
    }

    public async Task<IReadOnlyList<CardTransaction>> GetAllCardTransactions()
    {
        return await _cardTransactionsRepository.GetAllCardTransactions();
    }
}
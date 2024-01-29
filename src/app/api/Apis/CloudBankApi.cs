using Api.Models;
using Microsoft.AspNetCore.Http.HttpResults;

namespace Api;

public static class CloudBankApi
{
    public static IEndpointRouteBuilder MapCloudBankApi(this IEndpointRouteBuilder app)
    {
        // Routes for querying catalog items.
        app.MapGet("/accounts/transactions", GetAllTransactions);
        // .RequireAuthorization(); // Disabled for testing purposes
        app.MapGet("/accounts/{accountNumber:minlength(5)}/transactions", GetAccountTransactions);
        // .RequireAuthorization(); // Disabled for testing purposes
        app.MapGet("/cards/transactions", GetAllCardTransactions);
        // .RequireAuthorization(); // Disabled for testing purposes
        app.MapPost("/notifications", CreateNotification);
        // .RequireAuthorization(); // Disabled for testing purposes
        app.MapGet("/notifications", GetNotifications);
        // .RequireAuthorization(); // Disabled for testing purposes

        // Public Endpoints
        app.MapGet("/loans/calc", GetLoanCalculation);

        return app;
    }

    public static async Task<Results<Ok<List<AccountTransaction>>, NotFound, BadRequest<string>>> GetAllTransactions(
        [AsParameters] ApiServices services)
    {
        var transactions = await services.AccountsService.GetAllTransactions(); // ONLY for demo purposes the userId is omitted
        return TypedResults.Ok(transactions);
    }

    public static async Task<Results<Ok<List<AccountTransaction>>, NotFound, BadRequest<string>>> GetAccountTransactions(
        [AsParameters] ApiServices services,
        string accountNumber)
    {
        var transactions = await services.AccountsService.GetTransactions(accountNumber); // ONLY for demo purposes the userId is omitted
        return TypedResults.Ok(transactions);
    }

    public static async Task<Results<Ok<IReadOnlyList<CardTransaction>>, NotFound, BadRequest<string>>> GetAllCardTransactions(
        [AsParameters] ApiServices services)
    {
        var transactions = await services.CardsService.GetAllCardTransactions(); // ONLY for demo purposes the userId is omitted
        return TypedResults.Ok(transactions);
    }

    public static async Task<Results<Ok, NotFound, BadRequest<string>>> CreateNotification(
        [AsParameters] ApiServices services,
        Notification notification)
    {
        await services.NotificationsService.CreateNotification(notification); // ONLY for demo purposes the userId is omitted
        return TypedResults.Ok();
    }

    public static async Task<Results<Ok<List<Notification>>, NotFound, BadRequest<string>>> GetNotifications(
        [AsParameters] ApiServices services)
    {
        var notifications = await services.NotificationsService.GetNotifications(); // ONLY for demo purposes the userId is omitted
        return TypedResults.Ok(notifications);
    }

    public static Results<Ok<LoanCalculation>, NotFound, BadRequest<string>> GetLoanCalculation(
        decimal amount = 1000,
        int months = 12)
    {
        decimal interestRate = 0.05m; // 5% annual interest rate
        decimal monthlyInterestRate = interestRate / 12;
        decimal installmentAmount = Math.Round((amount * monthlyInterestRate) / (1 - (decimal)Math.Pow(1 + (double)monthlyInterestRate, -months)), 2);

        return TypedResults.Ok(new LoanCalculation
        {
            LoanAmount = amount,
            Months = months,
            InstallmentAmount = installmentAmount,
            InterestRate = interestRate
        });
    }
}
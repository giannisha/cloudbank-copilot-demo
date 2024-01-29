using Api.Repositories;
using Api.Repository;
using Api.Services;
using Microsoft.EntityFrameworkCore;

public static class Extensions
{
    public static void AddApplicationServices(this IHostApplicationBuilder builder)
    {
        builder.Services.AddDbContext<CloudBankDb>(options =>
        {
            options.UseSqlServer(builder.Configuration.GetConnectionString("CloudBankDb"));

        });
        builder.Services.AddEndpointsApiExplorer();
        builder.Services.AddSwaggerGen();
        builder.Services.AddCors(options => options.AddDefaultPolicy(builder => builder.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader()));

        builder.Services.AddScoped<IAccountsRepository, AccountsRepository>();
        builder.Services.AddScoped<ITransactionsRepository, TransactionsRepository>();
        builder.Services.AddScoped<IAccountsService, AccountsService>();
        builder.Services.AddScoped<ICardsService, CardsService>();
        builder.Services.AddScoped<ICardTransactionsRepository, CardTransactionsRepository>();
        builder.Services.AddScoped<INotificationsRepository, NotificationRepository>();
        builder.Services.AddScoped<INotificationService, NotificationService>();
    }
}
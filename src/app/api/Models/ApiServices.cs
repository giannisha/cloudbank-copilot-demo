using Api.Services;

public class ApiServices(
  CloudBankDb db,
  IAccountsService accountsService,
  ICardsService cardsService,
  INotificationService notificationsService,
  ILogger<ApiServices> logger
  )
{
  public CloudBankDb Db { get; } = db;
  public IAccountsService AccountsService { get; } = accountsService;
  public ICardsService CardsService { get; } = cardsService;
  public INotificationService NotificationsService { get; } = notificationsService;
  public ILogger<ApiServices> Logger { get; } = logger;
}
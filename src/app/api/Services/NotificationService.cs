using Api.Models;
using Api.Repository;

namespace Api.Services;

public class NotificationService : INotificationService
{
    private readonly INotificationsRepository _repository;

    public NotificationService(INotificationsRepository repository)
    {
        _repository = repository;
    }

    public async Task<List<Notification>> GetNotifications()
    {
        return await _repository.GetNotifications();
    }

    public async Task<Notification> CreateNotification(Notification notification)
    {
        return await _repository.CreateNotification(notification);
    }
}
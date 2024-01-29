using Api.Models;

namespace Api.Services;

public interface INotificationService
{
    Task<List<Notification>> GetNotifications();
    Task<Notification> CreateNotification(Notification notification);
}
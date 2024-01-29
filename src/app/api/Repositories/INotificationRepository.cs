using Api.Models;

namespace Api.Repository;

public interface INotificationsRepository
{
    Task<List<Notification>> GetNotifications();
    Task<Notification> CreateNotification(Notification notification);
}
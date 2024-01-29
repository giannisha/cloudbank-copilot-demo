using Api.Models;
using Microsoft.EntityFrameworkCore;

namespace Api.Repository;

public class NotificationRepository : INotificationsRepository
{
    private readonly CloudBankDb _db;

    public NotificationRepository(CloudBankDb db)
    {
        _db = db;
    }

    public async Task<List<Notification>> GetNotifications()
    {
        return await _db.Notifications.ToListAsync();
    }

    public async Task<Notification> CreateNotification(Notification notification)
    {
        _db.Notifications.Add(notification);
        await _db.SaveChangesAsync();
        return notification;
    }
}
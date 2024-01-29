using Api.Models;
using Microsoft.EntityFrameworkCore;

public class CloudBankDb : DbContext
{
  public CloudBankDb(DbContextOptions<CloudBankDb> options) : base(options) { }

  public DbSet<Account> Accounts { get; set; }

  public DbSet<AccountTransaction> Transactions { get; set; }

  public DbSet<Card> Cards { get; set; }

  public DbSet<CardTransaction> CardTransactions { get; set; }

  public DbSet<User> Users { get; set; }

  public DbSet<Notification> Notifications { get; set; }

  protected override void OnModelCreating(ModelBuilder modelBuilder)
  {
    modelBuilder.Entity<AccountTransaction>()
      .Property(t => t.Amount)
      .HasColumnType("decimal(10, 2)"); // specify the SQL Server column type

    modelBuilder.Entity<CardTransaction>()
      .Property(t => t.Amount)
      .HasColumnType("decimal(10, 2)"); // specify the SQL Server column type

    modelBuilder.Entity<Notification>()
      .Property(t => t.Date)
      .HasDefaultValueSql("getdate()");

    modelBuilder.Entity<Notification>()
      .Property(t => t.Id)
      .ValueGeneratedOnAdd();
  }
}
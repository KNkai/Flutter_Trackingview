using System;
using BidPhar_services.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace BidPhar_services.Repositories
{
    public partial class BID_PHARContext : DbContext
    {
        public BID_PHARContext()
        {
        }

        public BID_PHARContext(DbContextOptions<BID_PHARContext> options)
            : base(options)
        {
        }

        public virtual DbSet<DataEntry> DataEntries { get; set; }
        public virtual DbSet<ProductTransactions> ProductTransactions { get; set; }
        public virtual DbSet<Location> Locations { get; set; }
        public virtual DbSet<Products> Products { get; set; }
        public virtual DbSet<Roles> Roles { get; set; }
        public virtual DbSet<Users> Users { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. See http://go.microsoft.com/fwlink/?LinkId=723263 for guidance on storing connection strings.
                optionsBuilder.UseSqlServer("Server=DESKTOP-CB6RF28;Database=BID_PHAR;Trusted_Connection=True;");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<DataEntry>(entity =>
            {
                entity.HasKey(e => e.IdDataEntry);

                entity.ToTable("DATA_ENTRY");

                entity.Property(e => e.IdDataEntry)
                    .HasColumnName("ID_DATA_ENTRY")
                    .HasMaxLength(10)
                    .IsUnicode(false)
                    .IsFixedLength();

                entity.Property(e => e.EndDate)
                    .HasColumnName("END_DATE")
                    .HasColumnType("date");

                entity.Property(e => e.IdLocation).HasColumnName("ID_LOCATION");

                entity.Property(e => e.StartDate)
                    .HasColumnName("START_DATE")
                    .HasColumnType("date");

                entity.HasOne(d => d.IdLocationNavigation)
                    .WithMany(p => p.DataEntry)
                    .HasForeignKey(d => d.IdLocation)
                    .HasConstraintName("FK_DATA_ENTRY_LOCATION");
            });

            modelBuilder.Entity<Location>(entity =>
            {
                entity.HasKey(e => e.IdLocation);

                entity.ToTable("LOCATION");

                entity.Property(e => e.IdLocation).HasColumnName("ID_LOCATION");

                entity.Property(e => e.Location1)
                    .HasColumnName("LOCATION")
                    .HasMaxLength(50);
            });

            modelBuilder.Entity<ProductTransactions>(entity =>
            {
                entity.HasKey(e => e.IdProductTransactions);

                entity.ToTable("PRODUCT_TRANSACTIONS");

                entity.Property(e => e.IdProductTransactions).HasColumnName("ID_PRODUCT_TRANSACTIONS");

                entity.Property(e => e.DateChecked)
                    .HasColumnName("DATE_CHECKED")
                    .HasColumnType("datetime");

                entity.Property(e => e.Detail)
                    .HasColumnName("DETAIL")
                    .HasMaxLength(250);

                entity.Property(e => e.IdLocation).HasColumnName("ID_LOCATION");

                entity.Property(e => e.IdProduct)
                    .HasColumnName("ID_PRODUCT")
                    .HasMaxLength(20)
                    .IsUnicode(false)
                    .IsFixedLength();

                entity.Property(e => e.IdUser)
                    .HasColumnName("ID_USER")
                    .HasMaxLength(10)
                    .IsUnicode(false)
                    .IsFixedLength();

                entity.HasOne(d => d.IdLocationNavigation)
                    .WithMany(p => p.ProductTransactions)
                    .HasForeignKey(d => d.IdLocation)
                    .HasConstraintName("FK_PRODUCT_TRANSACTIONS_LOCATION");

                entity.HasOne(d => d.IdProductNavigation)
                    .WithMany(p => p.ProductTransactions)
                    .HasForeignKey(d => d.IdProduct)
                    .HasConstraintName("FK_PRODUCT_TRANSACTIONS_PRODUCTS");

                entity.HasOne(d => d.IdUserNavigation)
                    .WithMany(p => p.ProductTransactions)
                    .HasForeignKey(d => d.IdUser)
                    .HasConstraintName("FK_PRODUCT_TRANSACTIONS_USERS");
            });

            modelBuilder.Entity<Products>(entity =>
            {
                entity.HasKey(e => e.IdProduct);

                entity.ToTable("PRODUCTS");

                entity.Property(e => e.IdProduct)
                    .HasColumnName("ID_PRODUCT")
                    .HasMaxLength(20)
                    .IsUnicode(false)
                    .IsFixedLength();

                entity.Property(e => e.Details)
                    .HasColumnName("DETAILS")
                    .HasColumnType("text");

                entity.Property(e => e.ExpiredDate)
                    .HasColumnName("EXPIRED_DATE")
                    .HasColumnType("datetime");

                entity.Property(e => e.IdUser)
                    .HasColumnName("ID_USER")
                    .HasMaxLength(10)
                    .IsUnicode(false)
                    .IsFixedLength();

                entity.Property(e => e.Manufactured)
                    .HasColumnName("MANUFACTURED")
                    .HasMaxLength(50);

                entity.Property(e => e.ManufacturedDate)
                    .HasColumnName("MANUFACTURED_DATE")
                    .HasColumnType("datetime");

                entity.Property(e => e.NameProduct)
                    .HasColumnName("NAME_PRODUCT")
                    .HasMaxLength(250);

                entity.HasOne(d => d.IdUserNavigation)
                    .WithMany(p => p.Products)
                    .HasForeignKey(d => d.IdUser)
                    .HasConstraintName("FK_PRODUCTS_USERS");
            });

            modelBuilder.Entity<Roles>(entity =>
            {
                entity.HasKey(e => e.IdRole);

                entity.ToTable("ROLES");

                entity.Property(e => e.IdRole).HasColumnName("ID_ROLE");

                entity.Property(e => e.NameRole)
                    .HasColumnName("NAME_ROLE")
                    .HasMaxLength(50);
            });

            modelBuilder.Entity<Users>(entity =>
            {
                entity.HasKey(e => e.IdUser);

                entity.ToTable("USERS");

                entity.Property(e => e.IdUser)
                    .HasColumnName("ID_USER")
                    .HasMaxLength(10)
                    .IsUnicode(false)
                    .IsFixedLength();

                entity.Property(e => e.Avatar)
                    .HasColumnName("AVATAR")
                    .IsUnicode(false);

                entity.Property(e => e.Email)
                    .HasColumnName("EMAIL")
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.IdRole).HasColumnName("ID_ROLE");

                entity.Property(e => e.NameUser)
                    .HasColumnName("NAME_USER")
                    .HasMaxLength(50);

                entity.Property(e => e.Password)
                    .HasColumnName("PASSWORD")
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Username)
                    .HasColumnName("USERNAME")
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.HasOne(d => d.IdRoleNavigation)
                    .WithMany(p => p.Users)
                    .HasForeignKey(d => d.IdRole)
                    .HasConstraintName("FK_USERS_ROLES");
            });

            OnModelCreatingPartial(modelBuilder);
        }
        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}

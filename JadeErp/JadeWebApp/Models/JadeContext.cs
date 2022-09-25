using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace JadeWebApp.Models
{
    public partial class JadeContext : DbContext
    {
        public JadeContext()
        {
        }

        public JadeContext(DbContextOptions<JadeContext> options)
            : base(options)
        {
        }

        public virtual DbSet<Employee> Employees { get; set; } = null!;
        public virtual DbSet<Job> Jobs { get; set; } = null!;

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Employee>(entity =>
            {
                entity.ToTable("Employee", "HumanResources");

                entity.Property(e => e.Id).HasComment("Identificador único del empleado (Autonumérico)");

                entity.Property(e => e.FirstName)
                    .HasMaxLength(20)
                    .IsUnicode(false)
                    .HasComment("Primer nombre del empleado");

                entity.Property(e => e.JobId).HasComment("Identificador del puesto de trabajo que ocupa el empleado");

                entity.Property(e => e.LastName)
                    .HasMaxLength(20)
                    .IsUnicode(false)
                    .HasComment("Apellido del empleado");

                entity.Property(e => e.MiddleName)
                    .HasMaxLength(20)
                    .IsUnicode(false)
                    .HasComment("Segundo nombre del empleado");

                entity.HasOne(d => d.Job)
                    .WithMany(p => p.Employees)
                    .HasForeignKey(d => d.JobId)
                    .OnDelete(DeleteBehavior.ClientSetNull);
            });

            modelBuilder.Entity<Job>(entity =>
            {
                entity.ToTable("Job", "HumanResources");

                entity.HasIndex(e => e.Name, "UK_Job_Name")
                    .IsUnique();

                entity.Property(e => e.Id).ValueGeneratedOnAdd();

                entity.Property(e => e.Activo)
                    .IsRequired()
                    .HasDefaultValueSql("((1))");

                entity.Property(e => e.Description)
                    .HasMaxLength(500)
                    .IsUnicode(false);

                entity.Property(e => e.Name)
                    .HasMaxLength(100)
                    .IsUnicode(false);
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}

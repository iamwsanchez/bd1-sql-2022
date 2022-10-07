using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;

namespace JadeWebApp.Models
{
    public static class ModelBuilderExtensions
    {
        public static void Seed(this ModelBuilder modelBuilder)
        {
            //Crear ROLES
            List<IdentityRole> roles = new()
            {
                new IdentityRole{ Name = "Administrator", NormalizedName = "ADMINISTRATOR" },
                new IdentityRole { Name = "HrTechnician", NormalizedName = "HRTECHNICIAN" },
                new IdentityRole{ Name = "OpTechnician", NormalizedName = "OPTECHNICIAN" },
                new IdentityRole{ Name = "Vendor", NormalizedName = "VENDOR" }
            };
            modelBuilder.Entity<IdentityRole>().HasData(roles);

            //Crear USUARIOS
            List<ApplicationUser> users = new()
            {
                new ApplicationUser
                {
                    UserName = "wsanchez@jaic.com",
                    NormalizedUserName = "WSANCHEZ@JAIC.COM",
                    Email = "wsanchez@jaic.com",
                    NormalizedEmail = "WSANCHEZ@JAIC.COM",
                    EmailConfirmed = true
                },
                new ApplicationUser
                {
                    UserName = "jperez@jaic.com",
                    NormalizedUserName = "JPEREZ@JAIC.COM",
                    Email = "jperez@jaic.com",
                    NormalizedEmail = "JPEREZ@JAIC.COM",
                    EmailConfirmed = true
                }
            };
            modelBuilder.Entity<ApplicationUser>().HasData(users);

            //Agregar contraseña a los usuarios
            var hasher = new PasswordHasher<ApplicationUser>();
            users[0].PasswordHash = hasher.HashPassword(users[0], "pA$$1234");
            users[1].PasswordHash = hasher.HashPassword(users[1], "pA$$1234");

            //Agregar roles a usuario
            List<IdentityUserRole<string>> userRoles = new List<IdentityUserRole<string>>();
            userRoles.Add(new IdentityUserRole<string> 
            {
                UserId = users[0].Id,
                RoleId = roles.First(x => x.Name.Equals("Administrator")).Id
            });
            userRoles.Add(new IdentityUserRole<string>
            {
                UserId = users[1].Id,
                RoleId = roles.First(x => x.Name.Equals("HrTechnician")).Id
            });
            modelBuilder.Entity<IdentityUserRole<string>>().HasData(userRoles);
        }
    }
}
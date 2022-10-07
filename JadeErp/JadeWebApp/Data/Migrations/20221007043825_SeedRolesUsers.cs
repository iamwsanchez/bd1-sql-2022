using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace JadeWebApp.Data.Migrations
{
    public partial class SeedRolesUsers : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "Discriminator",
                table: "AspNetUsers",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.InsertData(
                table: "AspNetRoles",
                columns: new[] { "Id", "ConcurrencyStamp", "Name", "NormalizedName" },
                values: new object[,]
                {
                    { "038ef21f-8d2d-4fac-9b6b-441cccc9f0d8", "81eb640d-7598-47f8-9665-7c158cd02b88", "Administrator", "ADMINISTRATOR" },
                    { "076a8894-b723-4120-b7d6-e5de8257a563", "12b8d921-594c-4660-97d2-06dc9a19cddb", "HrTechnician", "HRTECHNICIAN" },
                    { "2b3dd1ab-4e68-4dde-81f9-6f20968c5ab0", "4826a75a-a5a9-410d-b5d2-b0b298502fa9", "OpTechnician", "OPTECHNICIAN" },
                    { "a549222d-0288-4019-bc50-9ca6ea1290d8", "2e8818e7-6749-4c0c-ab47-e7186222aab3", "Vendor", "VENDOR" }
                });

            migrationBuilder.InsertData(
                table: "AspNetUsers",
                columns: new[] { "Id", "AccessFailedCount", "ConcurrencyStamp", "Discriminator", "Email", "EmailConfirmed", "LockoutEnabled", "LockoutEnd", "NormalizedEmail", "NormalizedUserName", "PasswordHash", "PhoneNumber", "PhoneNumberConfirmed", "SecurityStamp", "TwoFactorEnabled", "UserName" },
                values: new object[,]
                {
                    { "3d4b6b79-0f00-482c-9c6c-b9ab5cc0d8a5", 0, "ffd3dcd1-92a4-4b5a-9b43-16cbe63169b1", "ApplicationUser", "jperez@jaic.com", true, false, null, "JPEREZ@JAIC.COM", "JPEREZ@JAIC.COM", "AQAAAAEAACcQAAAAEHq/51KC5Btvy5pWZR4C85B8OgjIl33bcn9dT4AUphQeD7nrDwW559zBjceDVAmf7Q==", null, false, "575d9aa2-5b17-497b-9826-7f058b18e3c2", false, "jperez@jaic.com" },
                    { "b87c6762-653a-4daa-b197-30e5ba49dbab", 0, "ae36e34e-07dd-4d8a-9a8a-633a3753b7d3", "ApplicationUser", "wsanchez@jaic.com", true, false, null, "WSANCHEZ@JAIC.COM", "WSANCHEZ@JAIC.COM", "AQAAAAEAACcQAAAAEM1fFAF6q+ADrrlTpHYuyYSVcnR/VfxSD9omGWhwudOnvaPSnx3G30AVYLEluF3tbg==", null, false, "dedaddb1-a158-4d99-b75f-826131f3dfd5", false, "wsanchez@jaic.com" }
                });

            migrationBuilder.InsertData(
                table: "AspNetUserRoles",
                columns: new[] { "RoleId", "UserId" },
                values: new object[] { "076a8894-b723-4120-b7d6-e5de8257a563", "3d4b6b79-0f00-482c-9c6c-b9ab5cc0d8a5" });

            migrationBuilder.InsertData(
                table: "AspNetUserRoles",
                columns: new[] { "RoleId", "UserId" },
                values: new object[] { "038ef21f-8d2d-4fac-9b6b-441cccc9f0d8", "b87c6762-653a-4daa-b197-30e5ba49dbab" });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "2b3dd1ab-4e68-4dde-81f9-6f20968c5ab0");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "a549222d-0288-4019-bc50-9ca6ea1290d8");

            migrationBuilder.DeleteData(
                table: "AspNetUserRoles",
                keyColumns: new[] { "RoleId", "UserId" },
                keyValues: new object[] { "076a8894-b723-4120-b7d6-e5de8257a563", "3d4b6b79-0f00-482c-9c6c-b9ab5cc0d8a5" });

            migrationBuilder.DeleteData(
                table: "AspNetUserRoles",
                keyColumns: new[] { "RoleId", "UserId" },
                keyValues: new object[] { "038ef21f-8d2d-4fac-9b6b-441cccc9f0d8", "b87c6762-653a-4daa-b197-30e5ba49dbab" });

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "038ef21f-8d2d-4fac-9b6b-441cccc9f0d8");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "076a8894-b723-4120-b7d6-e5de8257a563");

            migrationBuilder.DeleteData(
                table: "AspNetUsers",
                keyColumn: "Id",
                keyValue: "3d4b6b79-0f00-482c-9c6c-b9ab5cc0d8a5");

            migrationBuilder.DeleteData(
                table: "AspNetUsers",
                keyColumn: "Id",
                keyValue: "b87c6762-653a-4daa-b197-30e5ba49dbab");

            migrationBuilder.DropColumn(
                name: "Discriminator",
                table: "AspNetUsers");
        }
    }
}

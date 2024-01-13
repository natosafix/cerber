using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Web.Migrations
{
    /// <inheritdoc />
    public partial class CryptoKeyRequired : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<string>(
                name: "CryptoKey",
                table: "events",
                type: "text",
                nullable: false,
                oldClrType: typeof(string),
                oldType: "text",
                oldDefaultValue: "b97584f9-82a5-4f34-8db4-f5d9ba0a5673");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<string>(
                name: "CryptoKey",
                table: "events",
                type: "text",
                nullable: false,
                defaultValue: "b97584f9-82a5-4f34-8db4-f5d9ba0a5673",
                oldClrType: typeof(string),
                oldType: "text");
        }
    }
}

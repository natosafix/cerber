using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Web.Migrations
{
    /// <inheritdoc />
    public partial class TicketQrCodeFields : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "QrCodeSize",
                table: "tickets",
                type: "integer",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "QrCodeX",
                table: "tickets",
                type: "integer",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "QrCodeY",
                table: "tickets",
                type: "integer",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "QrCodeSize",
                table: "draftTickets",
                type: "integer",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "QrCodeX",
                table: "draftTickets",
                type: "integer",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "QrCodeY",
                table: "draftTickets",
                type: "integer",
                nullable: false,
                defaultValue: 0);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "QrCodeSize",
                table: "tickets");

            migrationBuilder.DropColumn(
                name: "QrCodeX",
                table: "tickets");

            migrationBuilder.DropColumn(
                name: "QrCodeY",
                table: "tickets");

            migrationBuilder.DropColumn(
                name: "QrCodeSize",
                table: "draftTickets");

            migrationBuilder.DropColumn(
                name: "QrCodeX",
                table: "draftTickets");

            migrationBuilder.DropColumn(
                name: "QrCodeY",
                table: "draftTickets");
        }
    }
}

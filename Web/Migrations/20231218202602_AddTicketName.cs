using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Web.Migrations
{
    /// <inheritdoc />
    public partial class AddTicketName : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_answers_orders_OrderId",
                table: "answers");

            migrationBuilder.RenameColumn(
                name: "OrderId",
                table: "answers",
                newName: "Customer");

            migrationBuilder.RenameIndex(
                name: "IX_answers_OrderId",
                table: "answers",
                newName: "IX_answers_Customer");

            migrationBuilder.AddColumn<string>(
                name: "Name",
                table: "tickets",
                type: "text",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddForeignKey(
                name: "FK_answers_orders_Customer",
                table: "answers",
                column: "Customer",
                principalTable: "orders",
                principalColumn: "Customer",
                onDelete: ReferentialAction.SetNull);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_answers_orders_Customer",
                table: "answers");

            migrationBuilder.DropColumn(
                name: "Name",
                table: "tickets");

            migrationBuilder.RenameColumn(
                name: "Customer",
                table: "answers",
                newName: "OrderId");

            migrationBuilder.RenameIndex(
                name: "IX_answers_Customer",
                table: "answers",
                newName: "IX_answers_OrderId");

            migrationBuilder.AddForeignKey(
                name: "FK_answers_orders_OrderId",
                table: "answers",
                column: "OrderId",
                principalTable: "orders",
                principalColumn: "Customer",
                onDelete: ReferentialAction.SetNull);
        }
    }
}

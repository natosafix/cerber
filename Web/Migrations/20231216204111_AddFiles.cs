using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace Web.Migrations
{
    /// <inheritdoc />
    public partial class AddFiles : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "CoverId",
                table: "events",
                type: "integer",
                nullable: true);

            migrationBuilder.CreateTable(
                name: "userFiles",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Name = table.Column<string>(type: "text", nullable: false),
                    Path = table.Column<string>(type: "text", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_userFiles", x => x.Id);
                });

            migrationBuilder.CreateIndex(
                name: "IX_events_CoverId",
                table: "events",
                column: "CoverId",
                unique: true);

            migrationBuilder.AddForeignKey(
                name: "FK_events_userFiles_CoverId",
                table: "events",
                column: "CoverId",
                principalTable: "userFiles",
                principalColumn: "Id",
                onDelete: ReferentialAction.SetNull);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_events_userFiles_CoverId",
                table: "events");

            migrationBuilder.DropTable(
                name: "userFiles");

            migrationBuilder.DropIndex(
                name: "IX_events_CoverId",
                table: "events");

            migrationBuilder.DropColumn(
                name: "CoverId",
                table: "events");
        }
    }
}

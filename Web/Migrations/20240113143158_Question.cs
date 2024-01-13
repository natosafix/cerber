using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Web.Migrations
{
    /// <inheritdoc />
    public partial class Question : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "Content",
                table: "questions",
                newName: "Title");

            migrationBuilder.AddColumn<string>(
                name: "AnswerChoices",
                table: "questions",
                type: "text",
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "AnswerChoices",
                table: "questions");

            migrationBuilder.RenameColumn(
                name: "Title",
                table: "questions",
                newName: "Content");
        }
    }
}

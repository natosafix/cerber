using System;
using Microsoft.EntityFrameworkCore.Migrations;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;

#nullable disable

namespace Web.Migrations
{
    /// <inheritdoc />
    public partial class AllChanges : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_answers_orders_OrderId",
                table: "answers");

            migrationBuilder.RenameColumn(
                name: "Content",
                table: "questions",
                newName: "Title");

            migrationBuilder.RenameColumn(
                name: "OrderId",
                table: "answers",
                newName: "Customer");

            migrationBuilder.RenameIndex(
                name: "IX_answers_OrderId",
                table: "answers",
                newName: "IX_answers_Customer");

            migrationBuilder.AddColumn<Guid>(
                name: "CoverId",
                table: "tickets",
                type: "uuid",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Name",
                table: "tickets",
                type: "text",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "AnswerChoices",
                table: "questions",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "Paid",
                table: "orders",
                type: "boolean",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AlterColumn<string>(
                name: "ShortDescription",
                table: "events",
                type: "character varying(50)",
                maxLength: 50,
                nullable: true,
                oldClrType: typeof(string),
                oldType: "character varying(50)",
                oldMaxLength: 50);

            migrationBuilder.AlterColumn<int>(
                name: "CategoryId",
                table: "events",
                type: "integer",
                nullable: true,
                oldClrType: typeof(int),
                oldType: "integer");

            migrationBuilder.AddColumn<Guid>(
                name: "CoverId",
                table: "events",
                type: "uuid",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "CryptoKey",
                table: "events",
                type: "text",
                nullable: false,
                defaultValue: "");

            migrationBuilder.CreateTable(
                name: "draftEvents",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    OwnerId = table.Column<string>(type: "text", nullable: false),
                    CoverImageId = table.Column<Guid>(type: "uuid", nullable: true),
                    Title = table.Column<string>(type: "text", nullable: true),
                    Description = table.Column<string>(type: "text", nullable: true),
                    City = table.Column<string>(type: "text", nullable: true),
                    Address = table.Column<string>(type: "text", nullable: true),
                    From = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: true),
                    To = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_draftEvents", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "draftQuestions",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    DraftEventId = table.Column<int>(type: "integer", nullable: false),
                    Title = table.Column<string>(type: "text", nullable: false),
                    Type = table.Column<int>(type: "integer", nullable: false),
                    AnswerChoices = table.Column<string>(type: "text", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_draftQuestions", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "draftTickets",
                columns: table => new
                {
                    Id = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    DraftEventId = table.Column<int>(type: "integer", nullable: false),
                    CoverImageId = table.Column<Guid>(type: "uuid", nullable: false),
                    Name = table.Column<string>(type: "text", nullable: false),
                    Price = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_draftTickets", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "userFiles",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    Name = table.Column<string>(type: "text", nullable: false),
                    Path = table.Column<string>(type: "text", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_userFiles", x => x.Id);
                });

            migrationBuilder.CreateIndex(
                name: "IX_tickets_CoverId",
                table: "tickets",
                column: "CoverId");

            migrationBuilder.CreateIndex(
                name: "IX_events_CoverId",
                table: "events",
                column: "CoverId");

            migrationBuilder.AddForeignKey(
                name: "FK_answers_orders_Customer",
                table: "answers",
                column: "Customer",
                principalTable: "orders",
                principalColumn: "Customer",
                onDelete: ReferentialAction.SetNull);

            migrationBuilder.AddForeignKey(
                name: "FK_events_userFiles_CoverId",
                table: "events",
                column: "CoverId",
                principalTable: "userFiles",
                principalColumn: "Id",
                onDelete: ReferentialAction.SetNull);

            migrationBuilder.AddForeignKey(
                name: "FK_tickets_userFiles_CoverId",
                table: "tickets",
                column: "CoverId",
                principalTable: "userFiles",
                principalColumn: "Id",
                onDelete: ReferentialAction.SetNull);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_answers_orders_Customer",
                table: "answers");

            migrationBuilder.DropForeignKey(
                name: "FK_events_userFiles_CoverId",
                table: "events");

            migrationBuilder.DropForeignKey(
                name: "FK_tickets_userFiles_CoverId",
                table: "tickets");

            migrationBuilder.DropTable(
                name: "draftEvents");

            migrationBuilder.DropTable(
                name: "draftQuestions");

            migrationBuilder.DropTable(
                name: "draftTickets");

            migrationBuilder.DropTable(
                name: "userFiles");

            migrationBuilder.DropIndex(
                name: "IX_tickets_CoverId",
                table: "tickets");

            migrationBuilder.DropIndex(
                name: "IX_events_CoverId",
                table: "events");

            migrationBuilder.DropColumn(
                name: "CoverId",
                table: "tickets");

            migrationBuilder.DropColumn(
                name: "Name",
                table: "tickets");

            migrationBuilder.DropColumn(
                name: "AnswerChoices",
                table: "questions");

            migrationBuilder.DropColumn(
                name: "Paid",
                table: "orders");

            migrationBuilder.DropColumn(
                name: "CoverId",
                table: "events");

            migrationBuilder.DropColumn(
                name: "CryptoKey",
                table: "events");

            migrationBuilder.RenameColumn(
                name: "Title",
                table: "questions",
                newName: "Content");

            migrationBuilder.RenameColumn(
                name: "Customer",
                table: "answers",
                newName: "OrderId");

            migrationBuilder.RenameIndex(
                name: "IX_answers_Customer",
                table: "answers",
                newName: "IX_answers_OrderId");

            migrationBuilder.AlterColumn<string>(
                name: "ShortDescription",
                table: "events",
                type: "character varying(50)",
                maxLength: 50,
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(string),
                oldType: "character varying(50)",
                oldMaxLength: 50,
                oldNullable: true);

            migrationBuilder.AlterColumn<int>(
                name: "CategoryId",
                table: "events",
                type: "integer",
                nullable: false,
                defaultValue: 0,
                oldClrType: typeof(int),
                oldType: "integer",
                oldNullable: true);

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

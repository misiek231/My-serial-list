using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace MySerialList.Data.Migrations
{
    public partial class B : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<string>(
                name: "Released",
                table: "Episodes",
                nullable: true,
                oldClrType: typeof(DateTime));
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<DateTime>(
                name: "Released",
                table: "Episodes",
                nullable: false,
                oldClrType: typeof(string),
                oldNullable: true);
        }
    }
}

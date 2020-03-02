using Microsoft.EntityFrameworkCore.Migrations;

namespace MySerialList.Data.Migrations
{
    public partial class C : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "Episodes",
                table: "WatchingFilmProductionStatuses",
                nullable: false,
                defaultValue: 0);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Episodes",
                table: "WatchingFilmProductionStatuses");
        }
    }
}

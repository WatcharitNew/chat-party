defmodule ChatParty.Repo.Migrations.CreateUserRooms do
  use Ecto.Migration

  def change do
    create table(:user_rooms) do
      add :user_id, references(:users)
      add :room_id, references(:rooms)

      timestamps()
    end

    create unique_index(:user_rooms, [:user_id, :room_id])
  end
end

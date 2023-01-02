defmodule ChatParty.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :text, :string
      add :user_id, references(:users)
      add :room_id, references(:rooms, on_delete: :delete_all), null: false

      timestamps()
    end
  end
end

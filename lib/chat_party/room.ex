defmodule ChatParty.Room do
  use Ecto.Schema
  import Ecto.Changeset

  alias ChatParty.{Room, Repo}

  schema "rooms" do
    field :name, :string

    many_to_many :users, ChatParty.User, join_through: "user_rooms"

    timestamps()
  end

  def changeset(room, attrs) do
    room
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> validate_format(:name, ~r/^[a-zA-Z0-9_]*$/,
      message: "only letters, numbers, and underscores please"
    )
    |> validate_length(:name, max: 12)
  end

  def list_rooms() do
    Repo.all(Room)
  end

  def change_room(%Room{} = room, attrs \\ %{}) do
    Room.changeset(room, attrs)
  end

  def create_room(attrs \\ %{}) do
    %Room{}
    |> Room.changeset(attrs)
    |> Repo.insert()
  end
end

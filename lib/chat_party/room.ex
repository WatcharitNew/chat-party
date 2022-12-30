defmodule ChatParty.Room do
  use Ecto.Schema
  alias ChatParty.{Room, Repo}

  schema "rooms" do
    field :name, :string

    many_to_many :users, ChatParty.User, join_through: "user_rooms"

    timestamps()
  end

  def list_rooms() do
    Repo.all(Room)
  end
end

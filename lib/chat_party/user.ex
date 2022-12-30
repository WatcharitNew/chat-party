defmodule ChatParty.User do
  use Ecto.Schema

  schema "users" do
    field :name, :string

    many_to_many :rooms, ChatParty.Room, join_through: "user_rooms"

    timestamps()
  end
end

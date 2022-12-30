defmodule ChatParty.UserRoom do
  use Ecto.Schema

  schema "user_rooms" do
    belongs_to :user, ChatParty.User
    belongs_to :room, ChatParty.Room

    timestamps()
  end
end

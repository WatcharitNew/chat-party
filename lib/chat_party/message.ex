defmodule ChatParty.Message do
  use Ecto.Schema

  schema "messages" do
    field :text, :string

    belongs_to :user, ChatParty.User
    belongs_to :room, ChatParty.Room

    timestamps()
  end
end

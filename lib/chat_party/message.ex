defmodule ChatParty.Message do
  use Ecto.Schema
  import Ecto.Changeset

  alias ChatParty.{Message, Repo}

  schema "messages" do
    field :text, :string

    belongs_to :user, ChatParty.User
    belongs_to :room, ChatParty.Room

    timestamps()
  end

  def changeset(message, attrs) do
    message
    |> cast(attrs, [:text, :room_id])
    |> validate_required([:text, :room_id])
  end

  def change_message(%Message{} = message, attrs \\ %{}) do
    Message.changeset(message, attrs)
  end

  def create_message(attrs \\ %{}) do
    %Message{}
    |> Message.changeset(attrs)
    |> Repo.insert()
  end
end

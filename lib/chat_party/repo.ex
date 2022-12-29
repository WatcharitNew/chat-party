defmodule ChatParty.Repo do
  use Ecto.Repo,
    otp_app: :chat_party,
    adapter: Ecto.Adapters.Postgres
end

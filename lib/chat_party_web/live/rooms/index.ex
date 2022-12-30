defmodule ChatPartyWeb.RoomsLive.Index do
  use ChatPartyWeb, :live_view

  alias ChatParty.Room
  alias ChatPartyWeb.RoomsLive
  alias ChatPartyWeb.RoomsView

  def render(assigns) do
    RoomsView.render("index.html", assigns)
  end

  def mount(_params, %{}, socket) do
    if connected?(socket), do: Process.send_after(self(), :update, 1000)

    {:ok, assign(socket, :rooms, rooms())}
  end

  def handle_info(:update, socket) do
    Process.send_after(self(), :update, 1000)

    {:noreply, assign(socket, :rooms, rooms())}
  end

  defp rooms do
    Room.list_rooms()
  end
end

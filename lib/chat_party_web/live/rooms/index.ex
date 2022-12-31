defmodule ChatPartyWeb.RoomsLive.Index do
  use ChatPartyWeb, :live_view

  alias ChatParty.Room
  alias ChatPartyWeb.RoomsView

  def render(assigns) do
    RoomsView.render("index.html", assigns)
  end

  def mount(_params, %{}, socket) do
    if connected?(socket), do: Process.send_after(self(), :update, 1000)

    {
      :ok,
      assign(
        socket,
        %{
          rooms: rooms(),
          room: nil
        }
      )
    }
  end

  def handle_info(:update, socket) do
    Process.send_after(self(), :update, 1000)
    selected_room = if socket.assigns.room, do: room(socket.assigns.room.id), else: nil

    {
      :noreply,
      assign(socket, %{
        rooms: rooms(),
        room: selected_room
      })
    }
  end

  def handle_event("get_messages", %{"id" => id}, socket) do
    {:noreply, assign(socket, %{room: room(id)})}
  end

  defp rooms() do
    Room.list_rooms()
  end

  defp room(id) do
    Room.get_room!(id)
  end
end

defmodule ChatPartyWeb.RoomsLive.Index do
  use ChatPartyWeb, :live_view

  alias ChatParty.{Room, Message}
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
          room: nil,
          message_changeset: nil
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
        room: selected_room,
        message_changeset: socket.assigns.message_changeset
      })
    }
  end

  def handle_event("get_messages", %{"id" => id}, socket) do
    {
      :noreply,
      assign(socket, %{
        room: room(id),
        message_changeset: message_changeset(%{})
      })
    }
  end

  def handle_event("send_message", %{"message" => params}, socket) do
    case Message.create_message(Map.merge(params, %{"room_id" => socket.assigns.room.id})) do
      {:ok, _} ->
        socket
        |> put_flash(:info, "Message sent successfully.")

        {:noreply, assign(socket, message_changeset: nil)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, message_changeset: changeset)}
    end
  end

  defp rooms() do
    Room.list_rooms()
  end

  defp room(id) do
    Room.get_room!(id)
  end

  defp message_changeset(params) do
    %Message{}
    |> Message.change_message(params)
    |> Map.put(:action, :insert)
  end
end

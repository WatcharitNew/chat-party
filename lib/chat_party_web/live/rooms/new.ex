defmodule ChatPartyWeb.RoomsLive.New do
  use ChatPartyWeb, :live_view

  alias ChatParty.Room
  alias ChatPartyWeb.RoomsLive
  alias ChatPartyWeb.RoomsView
  alias ChatPartyWeb.Router.Helpers, as: Routes

  def render(assigns) do
    RoomsView.render("new.html", assigns)
  end

  def mount(_params, %{}, socket) do
    # if connected?(socket), do: Process.send_after(self(), :update, 1000)

    {
      :ok,
      assign(socket, %{
        changeset: Room.change_room(%Room{})
      })
    }
  end

  # def handle_event(:validate, %{"user" => params}, socket) do
  #   changeset =
  #     %User{}
  #     |> Accounts.change_user(params)
  #     |> Map.put(:action, :insert)

  #   {:noreply, assign(socket, changeset: changeset)}
  # end

  def handle_event("validate", %{"room" => params}, socket) do
    changeset =
      %Room{}
      |> Room.change_room(params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"room" => room_params}, socket) do
    case Room.create_room(room_params) do
      {:ok, _} ->
        {:noreply,
         socket
         |> put_flash(:info, "Room created successfully.")
         |> redirect(to: Routes.live_path(socket, RoomsLive.Index))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end

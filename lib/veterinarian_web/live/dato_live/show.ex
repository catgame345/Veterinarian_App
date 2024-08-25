defmodule VeterinarianWeb.DatoLive.Show do
  use VeterinarianWeb, :live_view

  alias Veterinarian.Datos

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:dato, Datos.get_dato!(id))}
  end

  defp page_title(:show), do: "Show Dato"
  defp page_title(:edit), do: "Edit Dato"
end

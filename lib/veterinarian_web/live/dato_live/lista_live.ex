defmodule VeterinarianWeb.ListaLive do
  use VeterinarianWeb, :live_view

  alias Veterinarian.Datos

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: Datos.subscribe()
    {:ok, assign(socket, datos: Datos.list_datos())}
  end

  @impl true
  def handle_info({:date_created, _dato}, socket) do
    {:noreply, assign(socket, datos: Datos.list_datos())}
  end

  @impl true
  def handle_info({:date_deleted, _dato}, socket) do
    {:noreply, assign(socket, datos: Datos.list_datos())}
  end
end

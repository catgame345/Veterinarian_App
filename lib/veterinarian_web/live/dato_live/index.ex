defmodule VeterinarianWeb.DatoLive.Index do
  use VeterinarianWeb, :live_view

  alias Veterinarian.Datos
  alias Veterinarian.Datos.Dato

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: Datos.subscribe()
    {:ok, stream(socket, :datos, Datos.list_datos())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Dato")
    |> assign(:dato, Datos.get_dato!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Dato")
    |> assign(:dato, %Dato{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Datos")
    |> assign(:dato, nil)
  end

  @impl true
  def handle_info({VeterinarianWeb.DatoLive.FormComponent, {:saved, dato}}, socket) do
    {:noreply, stream_insert(socket, :datos, dato)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    dato = Datos.get_dato!(id)
    {:ok, _} = Datos.delete_dato(dato)

    {:noreply, stream_delete(socket, :datos, dato)}
  end

  @impl true
  def handle_info({:date_created, dato}, socket) do
    {:noreply, stream_insert(socket, :datos, dato)}
  end

  @impl true
  def handle_info({:date_deleted, dato}, socket) do
    {:noreply, stream_delete(socket, :datos, dato)}
  end
end

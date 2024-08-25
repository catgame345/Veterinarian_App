defmodule VeterinarianWeb.DatoLive.FormComponent do
  use VeterinarianWeb, :live_component

  alias Veterinarian.Datos

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage dato records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="dato-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:nombre]} type="text" label="Nombre" />
        <.input field={@form[:edad]} type="number" label="Edad" />
        <.input field={@form[:animal]} type="text" label="Animal" />
        <.input field={@form[:raza]} type="text" label="Raza" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Dato</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{dato: dato} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Datos.change_dato(dato))
     end)}
  end

  @impl true
  def handle_event("validate", %{"dato" => dato_params}, socket) do
    changeset = Datos.change_dato(socket.assigns.dato, dato_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"dato" => dato_params}, socket) do
    save_dato(socket, socket.assigns.action, dato_params)
  end

  defp save_dato(socket, :edit, dato_params) do
    case Datos.update_dato(socket.assigns.dato, dato_params) do
      {:ok, dato} ->
        notify_parent({:saved, dato})

        {:noreply,
         socket
         |> put_flash(:info, "Dato updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_dato(socket, :new, dato_params) do
    case Datos.create_dato(dato_params) do
      {:ok, dato} ->
        notify_parent({:saved, dato})

        {:noreply,
         socket
         |> put_flash(:info, "Dato created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end

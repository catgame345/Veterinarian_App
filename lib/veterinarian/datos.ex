defmodule Veterinarian.Datos do
  @moduledoc """
  The Datos context.
  """

  import Ecto.Query, warn: false
  alias Veterinarian.Repo

  alias Veterinarian.Datos.Dato

  @doc """
  Returns the list of datos.

  ## Examples

      iex> list_datos()
      [%Dato{}, ...]

  """
  def list_datos do
    Repo.all(Dato)
  end

  @doc """
  Gets a single dato.

  Raises `Ecto.NoResultsError` if the Dato does not exist.

  ## Examples

      iex> get_dato!(123)
      %Dato{}

      iex> get_dato!(456)
      ** (Ecto.NoResultsError)

  """
  def get_dato!(id), do: Repo.get!(Dato, id)

  @doc """
  Creates a dato.

  ## Examples

      iex> create_dato(%{field: value})
      {:ok, %Dato{}}

      iex> create_dato(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_dato(attrs \\ %{}) do
    %Dato{}
    |> Dato.changeset(attrs)
    |> Repo.insert()
    |> broadcast(:date_created)
  end

  @doc """
  Updates a dato.

  ## Examples

      iex> update_dato(dato, %{field: new_value})
      {:ok, %Dato{}}

      iex> update_dato(dato, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_dato(%Dato{} = dato, attrs) do
    dato
    |> Dato.changeset(attrs)
    |> Repo.update()
    |> broadcast(:date_created)
  end

  @doc """
  Deletes a dato.

  ## Examples

      iex> delete_dato(dato)
      {:ok, %Dato{}}

      iex> delete_dato(dato)
      {:error, %Ecto.Changeset{}}

  """
  def delete_dato(%Dato{} = dato) do
    Repo.delete(dato)
    |> broadcast(:date_deleted)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking dato changes.

  ## Examples

      iex> change_dato(dato)
      %Ecto.Changeset{data: %Dato{}}

  """
  def change_dato(%Dato{} = dato, attrs \\ %{}) do
    Dato.changeset(dato, attrs)
  end

  def subscribe do
    Phoenix.PubSub.subscribe(Veterinarian.PubSub, "dates")
  end

  defp broadcast({:error, _reason} = error, _event), do: error

  defp broadcast({:ok, dato}, event) do
    Phoenix.PubSub.broadcast(Veterinarian.PubSub, "dates", {event, dato})
    {:ok, dato}
  end

end

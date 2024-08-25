defmodule Veterinarian.DatosFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Veterinarian.Datos` context.
  """

  @doc """
  Generate a dato.
  """
  def dato_fixture(attrs \\ %{}) do
    {:ok, dato} =
      attrs
      |> Enum.into(%{
        animal: "some animal",
        edad: 42,
        nombre: "some nombre",
        raza: "some raza"
      })
      |> Veterinarian.Datos.create_dato()

    dato
  end
end

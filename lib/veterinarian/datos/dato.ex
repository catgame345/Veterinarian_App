defmodule Veterinarian.Datos.Dato do
  use Ecto.Schema
  import Ecto.Changeset

  schema "datos" do
    field :nombre, :string
    field :edad, :integer
    field :animal, :string
    field :raza, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(dato, attrs) do
    dato
    |> cast(attrs, [:nombre, :edad, :animal, :raza])
    |> validate_required([:nombre, :edad, :animal, :raza])
  end
end

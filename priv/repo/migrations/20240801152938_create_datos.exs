defmodule Veterinarian.Repo.Migrations.CreateDatos do
  use Ecto.Migration

  def change do
    create table(:datos) do
      add :nombre, :string
      add :edad, :integer
      add :animal, :string
      add :raza, :string

      timestamps(type: :utc_datetime)
    end
  end
end

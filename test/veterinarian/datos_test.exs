defmodule Veterinarian.DatosTest do
  use Veterinarian.DataCase

  alias Veterinarian.Datos

  describe "datos" do
    alias Veterinarian.Datos.Dato

    import Veterinarian.DatosFixtures

    @invalid_attrs %{nombre: nil, edad: nil, animal: nil, raza: nil}

    test "list_datos/0 returns all datos" do
      dato = dato_fixture()
      assert Datos.list_datos() == [dato]
    end

    test "get_dato!/1 returns the dato with given id" do
      dato = dato_fixture()
      assert Datos.get_dato!(dato.id) == dato
    end

    test "create_dato/1 with valid data creates a dato" do
      valid_attrs = %{nombre: "some nombre", edad: 42, animal: "some animal", raza: "some raza"}

      assert {:ok, %Dato{} = dato} = Datos.create_dato(valid_attrs)
      assert dato.nombre == "some nombre"
      assert dato.edad == 42
      assert dato.animal == "some animal"
      assert dato.raza == "some raza"
    end

    test "create_dato/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Datos.create_dato(@invalid_attrs)
    end

    test "update_dato/2 with valid data updates the dato" do
      dato = dato_fixture()
      update_attrs = %{nombre: "some updated nombre", edad: 43, animal: "some updated animal", raza: "some updated raza"}

      assert {:ok, %Dato{} = dato} = Datos.update_dato(dato, update_attrs)
      assert dato.nombre == "some updated nombre"
      assert dato.edad == 43
      assert dato.animal == "some updated animal"
      assert dato.raza == "some updated raza"
    end

    test "update_dato/2 with invalid data returns error changeset" do
      dato = dato_fixture()
      assert {:error, %Ecto.Changeset{}} = Datos.update_dato(dato, @invalid_attrs)
      assert dato == Datos.get_dato!(dato.id)
    end

    test "delete_dato/1 deletes the dato" do
      dato = dato_fixture()
      assert {:ok, %Dato{}} = Datos.delete_dato(dato)
      assert_raise Ecto.NoResultsError, fn -> Datos.get_dato!(dato.id) end
    end

    test "change_dato/1 returns a dato changeset" do
      dato = dato_fixture()
      assert %Ecto.Changeset{} = Datos.change_dato(dato)
    end
  end
end

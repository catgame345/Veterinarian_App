defmodule VeterinarianWeb.DatoLiveTest do
  use VeterinarianWeb.ConnCase

  import Phoenix.LiveViewTest
  import Veterinarian.DatosFixtures

  @create_attrs %{nombre: "some nombre", edad: 42, animal: "some animal", raza: "some raza"}
  @update_attrs %{nombre: "some updated nombre", edad: 43, animal: "some updated animal", raza: "some updated raza"}
  @invalid_attrs %{nombre: nil, edad: nil, animal: nil, raza: nil}

  defp create_dato(_) do
    dato = dato_fixture()
    %{dato: dato}
  end

  describe "Index" do
    setup [:create_dato]

    test "lists all datos", %{conn: conn, dato: dato} do
      {:ok, _index_live, html} = live(conn, ~p"/datos")

      assert html =~ "Listing Datos"
      assert html =~ dato.nombre
    end

    test "saves new dato", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/datos")

      assert index_live |> element("a", "New Dato") |> render_click() =~
               "New Dato"

      assert_patch(index_live, ~p"/datos/new")

      assert index_live
             |> form("#dato-form", dato: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#dato-form", dato: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/datos")

      html = render(index_live)
      assert html =~ "Dato created successfully"
      assert html =~ "some nombre"
    end

    test "updates dato in listing", %{conn: conn, dato: dato} do
      {:ok, index_live, _html} = live(conn, ~p"/datos")

      assert index_live |> element("#datos-#{dato.id} a", "Edit") |> render_click() =~
               "Edit Dato"

      assert_patch(index_live, ~p"/datos/#{dato}/edit")

      assert index_live
             |> form("#dato-form", dato: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#dato-form", dato: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/datos")

      html = render(index_live)
      assert html =~ "Dato updated successfully"
      assert html =~ "some updated nombre"
    end

    test "deletes dato in listing", %{conn: conn, dato: dato} do
      {:ok, index_live, _html} = live(conn, ~p"/datos")

      assert index_live |> element("#datos-#{dato.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#datos-#{dato.id}")
    end
  end

  describe "Show" do
    setup [:create_dato]

    test "displays dato", %{conn: conn, dato: dato} do
      {:ok, _show_live, html} = live(conn, ~p"/datos/#{dato}")

      assert html =~ "Show Dato"
      assert html =~ dato.nombre
    end

    test "updates dato within modal", %{conn: conn, dato: dato} do
      {:ok, show_live, _html} = live(conn, ~p"/datos/#{dato}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Dato"

      assert_patch(show_live, ~p"/datos/#{dato}/show/edit")

      assert show_live
             |> form("#dato-form", dato: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#dato-form", dato: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/datos/#{dato}")

      html = render(show_live)
      assert html =~ "Dato updated successfully"
      assert html =~ "some updated nombre"
    end
  end
end

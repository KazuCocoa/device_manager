defmodule DeviceManager.RentalControllerTest do
  use DeviceManager.ConnCase

  alias DeviceManager.Rental
  @valid_attrs %{device_name: "some content", is_rentaled: true, who: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, rental_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    rental = Repo.insert! %Rental{}
    conn = get conn, rental_path(conn, :show, rental)
    assert json_response(conn, 200)["data"] == %{
      "id" => rental.id
    }
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, rental_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, rental_path(conn, :create), rental: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Rental, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, rental_path(conn, :create), rental: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    rental = Repo.insert! %Rental{}
    conn = put conn, rental_path(conn, :update, rental), rental: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Rental, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    rental = Repo.insert! %Rental{}
    conn = put conn, rental_path(conn, :update, rental), rental: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    rental = Repo.insert! %Rental{}
    conn = delete conn, rental_path(conn, :delete, rental)
    assert json_response(conn, 200)["data"]["id"]
    refute Repo.get(Rental, rental.id)
  end
end

defmodule DeviceManager.RentalTest do
  use DeviceManager.ModelCase

  alias DeviceManager.Rental

  @valid_attrs %{device_name: "some content", is_rentaled: true, who: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Rental.changeset(%Rental{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Rental.changeset(%Rental{}, @invalid_attrs)
    refute changeset.valid?
  end
end

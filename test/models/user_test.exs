defmodule DeviceManager.UserTest do
  use DeviceManager.ModelCase

  alias DeviceManager.User

  @valid_attrs %{device_id: 1, user_name: "some content", user_sex: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end

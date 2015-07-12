defmodule DeviceManager.DeviceTest do
  use DeviceManager.ModelCase

  alias DeviceManager.Device

  @valid_attrs %{description: "some content", device_id: "some content", device_name: "some content", device_type: "some content", os: "iOS", os_version: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Device.changeset(%Device{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Device.changeset(%Device{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "description is not required" do
    changeset = Device.changeset(%Device{}, Dict.delete(@valid_attrs, :description))
    assert changeset.valid?
  end

  test "os is Android" do
    changeset = Device.changeset(%Device{}, Dict.put(@valid_attrs, :os, "Android"))
    assert changeset.valid?
  end

  test "os is iOS" do
    changeset = Device.changeset(%Device{}, Dict.put(@valid_attrs, :os, "iOS"))
    assert changeset.valid?
  end

  test "os must be Android or iOS" do
    attrs = %{@valid_attrs | os: "neko"}
    assert {:os, "Must be Android or iOS"} in errors_on(%Device{}, attrs)
  end
end

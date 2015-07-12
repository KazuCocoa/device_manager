defmodule DeviceManager.Device do
  use DeviceManager.Web, :model

  schema "devices" do
    field :device_name, :string
    field :device_type, :string
    field :os, :string
    field :os_version, :string
    field :device_id, :string
    field :description, :string

    timestamps
  end

  @required_fields ~w(device_name device_type os os_version device_id)
  @optional_fields ~w(description)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_format(:os, ~r/^iOS|Android$/, message: "Must be Android or iOS")
  end
end

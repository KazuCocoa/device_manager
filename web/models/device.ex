defmodule DeviceManager.Device do
  use DeviceManager.Web, :model

  schema "devices" do
    field :device_name, :string
    field :device_type, :string
    field :os, :string
    field :os_version, :string
    field :description, :string

    has_many :rentals, DeviceManager.Rental, foreign_key: :rental_id
    timestamps
  end

  @required_fields ~w(rental_id device_name device_type os os_version)
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

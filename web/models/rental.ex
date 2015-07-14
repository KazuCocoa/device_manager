defmodule DeviceManager.Rental do
  use DeviceManager.Web, :model

  schema "rental" do
    field :device_name, :string
    field :who, :string
    field :is_rentaled, :boolean, default: false

    belongs_to :device, DeviceManager.Device, foreign_key: :device_id
    timestamps
  end

  @required_fields ~w(device_id device_name who is_rentaled)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end

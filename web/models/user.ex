defmodule DeviceManager.User do
  use DeviceManager.Web, :model

  schema "users" do
    field :user_name, :string
    field :user_sex, :string
    belongs_to :device, DeviceManager.Device, foreign_key: :device_id

    timestamps
  end

  @required_fields ~w(device_id user_name user_sex)
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

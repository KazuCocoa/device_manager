defmodule DeviceManager.Repo.Migrations.CreateRental do
  use Ecto.Migration

  def change do
    create table(:rental) do
      add :device_id, :integer
      add :device_name, :string
      add :who, :string
      add :is_rentaled, :boolean, default: false

      timestamps
    end
    create index(:rental, [:device_id])

  end
end

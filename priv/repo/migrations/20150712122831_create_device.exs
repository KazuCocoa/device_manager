defmodule DeviceManager.Repo.Migrations.CreateDevice do
  use Ecto.Migration

  def change do
    create table(:devices) do
      add :device_name, :string
      add :device_type, :string
      add :os, :string
      add :os_version, :string
      add :description, :string
      add :rental_id, :integer
      add :user_id, :integer

      timestamps
    end
    create index(:devices, [:user_id])
    create index(:devices, [:rental_id])

  end
end

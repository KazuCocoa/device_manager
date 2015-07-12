defmodule DeviceManager.Repo.Migrations.CreateDevice do
  use Ecto.Migration

  def change do
    create table(:devices) do
      add :device_name, :string
      add :device_type, :string
      add :os, :string
      add :os_version, :string
      add :device_id, :string
      add :description, :string

      timestamps
    end

  end
end

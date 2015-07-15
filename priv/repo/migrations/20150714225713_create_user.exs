defmodule DeviceManager.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :user_name, :string
      add :user_sex, :string
      add :device_id, :integer

      timestamps
    end
    create index(:users, [:device_id])

  end
end

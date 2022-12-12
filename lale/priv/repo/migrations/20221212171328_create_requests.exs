defmodule Lale.Repo.Migrations.CreateRequests do
  use Ecto.Migration

  def change do
    create table(:requests) do
      add :timestamp, :utc_datetime

      timestamps()
    end
  end
end

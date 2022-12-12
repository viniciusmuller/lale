defmodule Lale.Repo.Migrations.CreateLogEntries do
  use Ecto.Migration

  def change do
    create table(:log_entries) do
      add :timestamp, :utc_datetime
      add :level, :string
      add :content, :string
      add :application_id, :integer
      add :request_id, :integer

      timestamps()
    end
  end
end

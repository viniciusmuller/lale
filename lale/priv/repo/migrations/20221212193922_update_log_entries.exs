defmodule Lale.Repo.Migrations.UpdateLogEntries do
  use Ecto.Migration

  def change do
    rename table(:log_entries), :content, to: :message
    alter table(:log_entries) do
      add(:metadata, :map)
    end
  end
end

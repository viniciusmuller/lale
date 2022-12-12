defmodule Lale.LogEntries.LogEntry do
  use Ecto.Schema
  import Ecto.Changeset

  schema "log_entries" do
    field :timestamp, :utc_datetime
    field :application_id, :integer
    field :content, :string
    field :level, :string
    field :request_id, :integer

    timestamps()
  end

  @doc false
  def changeset(log_entry, attrs) do
    log_entry
    |> cast(attrs, [:level, :content, :application_id, :request_id, :timestamp])
    |> validate_required([:level, :content, :application_id, :timestamp])
  end
end

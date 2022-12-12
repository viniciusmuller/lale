defmodule LaleWeb.LogEntryController do
  use LaleWeb, :controller

  alias Lale.LogEntries

  def index(conn, _params) do
    entries = LogEntries.list_log_entries()
    json(conn, entries)
  end

  def create(conn, params) do
    IO.inspect(params, label: :controller)
    with {:ok, entry} <- LogEntries.create_log_entry(params) do
      json(conn, entry)
    else
      {:error, changeset} ->
        json(conn, changeset.errors)
    end
  end
end

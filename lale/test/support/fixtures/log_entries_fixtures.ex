defmodule Lale.LogEntriesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Lale.LogEntries` context.
  """

  @doc """
  Generate a log_entry.
  """
  def log_entry_fixture(attrs \\ %{}) do
    {:ok, log_entry} =
      attrs
      |> Enum.into(%{
        application_id: 42,
        content: "some content",
        level: "some level",
        request_id: 42,
        timestamp: DateTime.utc_now()
      })
      |> Lale.LogEntries.create_log_entry()

    log_entry
  end
end

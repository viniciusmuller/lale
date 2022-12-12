defmodule Lale.LogEntriesTest do
  use Lale.DataCase

  alias Lale.LogEntries

  describe "log_entries" do
    alias Lale.LogEntries.LogEntry

    import Lale.LogEntriesFixtures

    @invalid_attrs %{application_id: nil, content: nil, level: nil, request_id: nil}

    test "list_log_entries/0 returns all log_entries" do
      log_entry = log_entry_fixture()
      assert LogEntries.list_log_entries() == [log_entry]
    end

    test "get_log_entry!/1 returns the log_entry with given id" do
      log_entry = log_entry_fixture()
      assert LogEntries.get_log_entry!(log_entry.id) == log_entry
    end

    test "create_log_entry/1 with valid data creates a log_entry" do
      valid_attrs = %{application_id: 42, content: "some content", level: "some level", request_id: 42, timestamp: DateTime.utc_now()}

      assert {:ok, %LogEntry{} = log_entry} = LogEntries.create_log_entry(valid_attrs)
      assert log_entry.application_id == 42
      assert log_entry.content == "some content"
      assert log_entry.level == "some level"
      assert log_entry.request_id == 42
    end

    test "create_log_entry/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = LogEntries.create_log_entry(@invalid_attrs)
    end

    test "update_log_entry/2 with valid data updates the log_entry" do
      log_entry = log_entry_fixture()
      update_attrs = %{application_id: 43, content: "some updated content", level: "some updated level", request_id: 43}

      assert {:ok, %LogEntry{} = log_entry} = LogEntries.update_log_entry(log_entry, update_attrs)
      assert log_entry.application_id == 43
      assert log_entry.content == "some updated content"
      assert log_entry.level == "some updated level"
      assert log_entry.request_id == 43
    end

    test "update_log_entry/2 with invalid data returns error changeset" do
      log_entry = log_entry_fixture()
      assert {:error, %Ecto.Changeset{}} = LogEntries.update_log_entry(log_entry, @invalid_attrs)
      assert log_entry == LogEntries.get_log_entry!(log_entry.id)
    end

    test "delete_log_entry/1 deletes the log_entry" do
      log_entry = log_entry_fixture()
      assert {:ok, %LogEntry{}} = LogEntries.delete_log_entry(log_entry)
      assert_raise Ecto.NoResultsError, fn -> LogEntries.get_log_entry!(log_entry.id) end
    end

    test "change_log_entry/1 returns a log_entry changeset" do
      log_entry = log_entry_fixture()
      assert %Ecto.Changeset{} = LogEntries.change_log_entry(log_entry)
    end
  end
end

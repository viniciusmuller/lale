defmodule Lale.TestLoggerBackend do
  @moduledoc """
  Custom logger backend for Lale.
  See https://hexdocs.pm/logger/1.13.1/Logger.html for more information.
  """
  @behaviour :gen_event

  @impl true
  def init(_opts) do
    {:ok, :ok}
  end

  @impl true
  def handle_event({_level, gl, {Logger, _, _, _}}, state)
      when node(gl) != node() do
    {:ok, state}
  end

  def handle_event(
        {level, group_leader,
         {Logger, message, {{year, month, day}, {hour, minute, second, millisecond}}, metadata}},
        state
      ) do
    {:ok, naive} = NaiveDateTime.new(year, month, day, hour, minute, second)
    timestamp = NaiveDateTime.add(naive, millisecond * 1000, :microsecond)

    base_metadata = %{host: node(group_leader)}

    # Figure out where this comes from (probably Phoenix)
    stacktrace =
      case Keyword.fetch(metadata, :crash_reason) do
        {:ok, {_, traces}} -> %{stacktrace: Enum.map(traces, &inspect/1)}
        :error -> %{}
      end

    metadata =
      metadata
      |> Enum.filter(fn {_k, v} ->
        case Jason.encode(v) do
          {:ok, _} -> true
          {:error, _} -> false
        end
      end)
      |> Map.new()
      |> Map.merge(base_metadata)
      |> Map.merge(stacktrace)

    data =
      %{
        message: to_string(message),
        level: level,
        timestamp: timestamp,
        metadata: metadata
      }
      |> IO.inspect()

    # json = Jason.Formatter.pretty_print(Jason.encode!(data))

    # TODO: maybe use finch
    HTTPoison.post!(
      "http://127.0.0.1:4000/api/logs",
      Jason.encode!(data),
      [{"content-type", "application/json"}])
    |> IO.inspect()

    {:ok, state}
  end

  def handle_event(:flush, _) do
    # TODO: use buffering to send requests in batch
    IO.inspect("custom logger backend is flushing")
  end

  @impl true
  def handle_call({:configure, _opts}, state) do
    # new_state = reconfigure_state(state, options)
    {:ok, :ok, state}
  end
end

defimpl Jason.Encoder, for: PID do
  def encode(pid, _opts), do: inspect(pid)
end

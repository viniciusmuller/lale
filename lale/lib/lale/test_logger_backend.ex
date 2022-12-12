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

  defp stringify_trace({module, function, details, metadata}) do
    "#{module} #{function}/#{inspect(details)} #{inspect(metadata)}"
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

    stacktrace =
      # Figure out where this comes from (probably Phoenix)
      case Keyword.fetch(metadata, :crash_reason) do
        {:ok, {_, traces}} -> %{stacktrace: Enum.map(traces, &stringify_trace/1)}
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

    IO.puts(Jason.Formatter.pretty_print(Jason.encode!(data)))
    {:ok, state}
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

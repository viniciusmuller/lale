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

  def handle_event({_level, _group_leader, {Logger, _message, _timestamp, _metadata}} = s, state) do
    IO.inspect(s)
    {:ok, state}
  end

  @impl true
  def handle_call({:configure, _opts}, state) do
    # new_state = reconfigure_state(state, options)
    {:ok, :ok, state}
  end
end

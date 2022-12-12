defmodule Lale.RequestsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Lale.Requests` context.
  """

  @doc """
  Generate a request.
  """
  def request_fixture(attrs \\ %{}) do
    {:ok, request} =
      attrs
      |> Enum.into(%{
        timestamp: ~U[2022-12-11 17:13:00Z]
      })
      |> Lale.Requests.create_request()

    request
  end
end

defmodule Lale.ApplicationsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Lale.Applications` context.
  """

  @doc """
  Generate a application.
  """
  def application_fixture(attrs \\ %{}) do
    {:ok, application} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Lale.Applications.create_application()

    application
  end
end

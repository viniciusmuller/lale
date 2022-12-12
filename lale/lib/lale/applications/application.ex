defmodule Lale.Applications.Application do
  use Ecto.Schema
  import Ecto.Changeset

  schema "applications" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(application, attrs) do
    application
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end

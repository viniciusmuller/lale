defmodule Lale.Requests.Request do
  use Ecto.Schema
  import Ecto.Changeset

  schema "requests" do
    field :timestamp, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(request, attrs) do
    request
    |> cast(attrs, [:timestamp])
    |> validate_required([:timestamp])
  end
end

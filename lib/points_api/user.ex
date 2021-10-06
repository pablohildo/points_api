defmodule PointsApi.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :points, :integer, default: 0

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:points])
    |> validate_required([:points])
    |> validate_number(:points, greater_than_or_equal_to: 0)
    |> validate_number(:points, less_than_or_equal_to: 100)
    |> validate_required(:points)
  end
end

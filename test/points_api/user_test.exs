defmodule PointsApi.UserTest do
  use PointsApi.DataCase

  alias PointsApi.User

  test "points must be an integer between 0 and 100" do
    invalid_attrs = [
      %{points: -1},
      %{points: 101},
      %{points: "abc"}
    ]

    valid_attrs = [
      %{points: 0},
      %{points: 50},
      %{points: 100}
    ]

    changeset = User.changeset(%User{}, Enum.at(invalid_attrs, 0))
    assert %{points: ["must be greater than or equal to 0"]} = errors_on(changeset)

    changeset = User.changeset(%User{}, Enum.at(invalid_attrs, 1))
    assert %{points: ["must be less than or equal to 100"]} = errors_on(changeset)

    changeset = User.changeset(%User{}, Enum.at(invalid_attrs, 2))
    assert %{points: ["is invalid"]} = errors_on(changeset)

    Enum.each(valid_attrs, fn attrs ->
      changeset = User.changeset(%User{}, attrs)
      assert changeset.valid?
    end)
  end
end

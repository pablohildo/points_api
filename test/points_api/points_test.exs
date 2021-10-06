defmodule PointsApi.PointsTest do
  use PointsApi.DataCase

  alias PointsApi.Points

  describe "users" do
    alias PointsApi.Points.User

    import PointsApi.PointsFixtures

    @invalid_attrs %{points: nil}
    @date NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)

    test "randomize_all_points/0 changes points for every user" do
      _users = [
        user_fixture(),
        user_fixture(),
        user_fixture()
      ]

      Points.randomize_all_points()
      fetched_users = Points.list_users()

      Enum.each(fetched_users, fn user ->
        assert user.points != 42
      end)
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Points.list_users() == [user]
    end

    test "list_users_by_points/1 returns only users with points greater than an integer" do
      users = [
        user_fixture(points: 10),
        user_fixture(points: 50),
        user_fixture(points: 60)
      ]

      refute Points.list_users_by_points(47) |> Enum.member?(Enum.at(users, 0))
    end

    test "insert_all_users/1 inserts a list of users" do
      users = [
        %{points: 10, inserted_at: @date, updated_at: @date},
        %{points: 50, inserted_at: @date, updated_at: @date},
        %{points: 60, inserted_at: @date, updated_at: @date}
      ]

      assert {3, _} = Points.insert_all_users(users)
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{points: 42}

      assert {:ok, %User{} = user} = Points.create_user(valid_attrs)
      assert user.points == 42
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Points.create_user(@invalid_attrs)
    end
  end
end

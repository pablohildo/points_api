defmodule PointsApiWeb.PointsControllerTest do
  use PointsApiWeb.ConnCase
  import PointsApi.PointsFixtures

  describe "index" do
    test "returns one timestamp and exactly two users", %{conn: conn} do
      user_fixture()
      user_fixture()

      conn = get(conn, Routes.points_path(conn, :index))
      %{"users" => users, "timestamp" => timestamp} = json_response(conn, 200)

      assert is_list(users)
      assert length(users) == 2

      # If the controller is being called for the first time, the timestamp may be nil
      case timestamp do
        nil -> :noop
        _ -> assert {:ok, _} = NaiveDateTime.from_iso8601(timestamp)
      end
    end

    test "returns one timestamp and exactly one user", %{conn: conn} do
      user_fixture()

      conn = get(conn, Routes.points_path(conn, :index))
      %{"users" => users, "timestamp" => timestamp} = json_response(conn, 200)

      assert is_list(users)
      assert length(users) == 1

      # If the controller is being called for the first time, the timestamp may be nil
      case timestamp do
        nil -> :noop
        _ -> assert {:ok, _} = NaiveDateTime.from_iso8601(timestamp)
      end
    end

    test "returns one timestamp and no user", %{conn: conn} do
      conn = get(conn, Routes.points_path(conn, :index))
      %{"users" => users, "timestamp" => timestamp} = json_response(conn, 200)

      assert is_list(users)
      assert Enum.empty?(users)

      case timestamp do
        nil -> :noop
        _ -> assert {:ok, _} = NaiveDateTime.from_iso8601(timestamp)
      end
    end
  end
end

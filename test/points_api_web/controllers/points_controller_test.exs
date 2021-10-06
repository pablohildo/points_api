defmodule PointsApiWeb.PointsControllerTest do
  use PointsApiWeb.ConnCase

  describe "index" do
    test "returns one timestamp and exactly two users", %{conn: conn} do
      conn = get(conn, Routes.points_path(conn, :index))
      %{"users" => users, "timestamp" => timestamp} = json_response(conn, 200)

      assert is_list(users)
      assert {:ok, _} = NaiveDateTime.from_iso8601(timestamp)
    end
  end
end

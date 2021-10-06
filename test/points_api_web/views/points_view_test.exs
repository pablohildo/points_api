defmodule PointsApiWeb.UserViewTest do
  use PointsApiWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  alias PointsApi.Points.User

  @date NaiveDateTime.from_iso8601!("2021-12-31T23:59:59")
  @valid_user %User{points: 50, id: 1, inserted_at: @date, updated_at: @date}
  @valid_input %{users: [@valid_user, @valid_user], timestamp: @date}

  test "renders index.json" do
    assert render(PointsApiWeb.PointsView, "index.json", @valid_input) == %{
             timestamp: @date,
             users: [%{id: 1, points: 50}, %{id: 1, points: 50}]
           }
  end

  test "renders user.json" do
    assert render(PointsApiWeb.PointsView, "user.json", %{points: @valid_user}) ==
             %{id: 1, points: 50}
  end
end

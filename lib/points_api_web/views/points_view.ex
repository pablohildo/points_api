defmodule PointsApiWeb.PointsView do
  use PointsApiWeb, :view
  alias PointsApiWeb.PointsView

  def render("index.json", %{users: users, timestamp: timestamp}) do
    %{
      timestamp: timestamp,
      users: render_many(users, PointsView, "user.json")
    }
  end

  def render("user.json", %{points: %PointsApi.User{} = user}) do
    %{
      id: user.id,
      points: user.points
    }
  end
end

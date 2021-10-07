defmodule PointsApiWeb.PointsController do
  use PointsApiWeb, :controller

  def index(conn, _) do
    render(conn, worker().retrieve())
  end

  defp worker do
    Application.get_env(:points_api, :worker)
  end
end

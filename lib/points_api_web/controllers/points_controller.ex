defmodule PointsApiWeb.PointsController do
  use PointsApiWeb, :controller

  def index(conn, _) do
    render(conn, PointsApi.Worker.retrieve())
  end
end

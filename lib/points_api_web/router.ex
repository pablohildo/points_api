defmodule PointsApiWeb.Router do
  use PointsApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipe_through :api
  get "/", PointsApiWeb.PointsController, :index
end

defmodule PointsApi.WorkerMock do
  @moduledoc """
  Mocked Worker for tests, always returns all users
  """
  alias PointsApi.Points

  def retrieve do
    %{
      users: Points.list_users_by_points(0),
      timestamp: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)
    }
  end
end

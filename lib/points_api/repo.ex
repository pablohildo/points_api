defmodule PointsApi.Repo do
  use Ecto.Repo,
    otp_app: :points_api,
    adapter: Ecto.Adapters.Postgres
end

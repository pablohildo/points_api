defmodule PointsApi.Points do
  @moduledoc """
  The Points context.
  """

  import Ecto.Query, warn: false
  alias PointsApi.Repo

  alias PointsApi.Points.User

  @doc """
  Updates all user points with a random number between 0 and 100.
  """
  def randomize_all_points do
    from(u in User,
      update: [set: [points: fragment("floor(random()*100)"), updated_at: fragment("now()")]]
    )
    |> Repo.update_all([])
  end

  @doc """
  Returns the list of users whose points are greater than the given parameter.
  """
  def list_users_by_points(max_points) do
    from(u in User,
      where: u.points > ^max_points,
      # Ordering by random makes results more diverse
      order_by: fragment("RANDOM()"),
      limit: 2
    )
    |> Repo.all()
  end

  @doc """
  Inserts a list of users
  """
  def insert_all_users(users) do
    Repo.insert_all(User, users)
  end

  @doc """
  Returns the list of users.
  """

  def list_users do
    Repo.all(User)
  end

  @doc """
  Creates a user.
  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end
end

defmodule PointsApi.Worker do
  @moduledoc """
  Points worker responsible for updating and retrieving user points
  based on it's state {max_number, timestamp}
  """
  use GenServer
  alias PointsApi.Points

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: PointsWorker)
  end

  # {max_number, timestamp}
  def init(_) do
    Process.send_after(self(), :tick, :timer.minutes(1))

    {:ok, {Enum.random(0..100), nil}}
  end

  def handle_info(:tick, {_, timestamp}) do
    Points.randomize_all_points()

    Process.send_after(self(), :tick, :timer.minutes(1))

    {:noreply, {Enum.random(0..100), timestamp}}
  end

  def handle_call(:retrieve, _, {max_points, timestamp}) do
    users = Points.list_users_by_points(max_points)

    {:reply, %{users: users, timestamp: timestamp}, {max_points, NaiveDateTime.utc_now()}}
  end

  @doc """
  Makes a call to the genserver retrieving the users and the timestamp of the last call
  """
  def retrieve do
    GenServer.call(PointsWorker, :retrieve)
  end
end

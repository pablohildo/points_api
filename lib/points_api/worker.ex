defmodule PointsApi.Worker do
  use GenServer
  import Ecto.Query, only: [from: 2]
  alias PointsApi.{Repo, User}

  def start_link(_) do
    GenServer.start_link(__MODULE__, {0, nil}, name: PointsWorker)
  end

  # {max_number, timestamp}
  def init(_) do
    Process.send_after(self(), :tick, :timer.minutes(1))

    {:ok, {0, nil}}
  end

  def handle_info(:tick, {_, timestamp}) do
    from(u in User,
      update: [set: [points: fragment("floor(random()*100)"), updated_at: fragment("now()")]]
    )
    |> Repo.update_all([])

    Process.send_after(self(), :tick, :timer.minutes(1))

    {:noreply, {Enum.random(0..100), timestamp}}
  end

  def handle_call(:retrieve, _, {max_number, timestamp}) do
    users =
      from(u in User,
        where: u.points > ^max_number,
        limit: 2
      )
      |> Repo.all()

    {:reply, %{users: users, timestamp: timestamp}, {max_number, NaiveDateTime.utc_now()}}
  end

  def retrieve() do
    GenServer.call(PointsWorker, :retrieve)
  end
end

# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     PointsApi.Repo.insert!(%PointsApi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
entries = Enum.map(1..100, fn _ -> %PointsApi.User{points: 0} end)

Ecto.Multi.new()
|> Ecto.Multi.insert_all(entries)
|> PointsApi.Repo.transaction()

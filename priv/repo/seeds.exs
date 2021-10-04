# postgresql protocol can not handle 2000000 parameters, the maximum is 65535
# Chunking every 32767 allows inserting the most rows considering we have two parameters per row
1..1_000_000
|> Enum.chunk_every(32767)
|> Enum.each(fn chunk ->
  users =
    Enum.map(chunk, fn _ ->
      %{
        inserted_at: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second),
        updated_at: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)
      }
    end)

  PointsApi.Repo.insert_all(PointsApi.User, users)
end)

defmodule PointsApi.WorkerTest do
  use PointsApi.DataCase, async: false
  alias PointsApi.Worker

  describe "start_link/1" do
    test "Worker is supervised with main application" do
      assert Worker.start_link([])
    end
  end

  describe "retrieve/1" do
    test "returns nil timestamp on first run" do
      assert %{timestamp: nil} = Worker.retrieve()
    end

    test "returns non nil timestamp on next runs" do
      %{timestamp: timestamp} = Worker.retrieve()
      assert not is_nil(timestamp)
    end
  end
end

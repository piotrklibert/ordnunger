defmodule Ordnunger.Worker do
  def start_link(), do: GenServer.start_link(__MODULE__, :ok, [])

  use GenServer
  def init(_state), do: {:ok, :state}
end

defmodule Ordnunger.App do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec
    children = [
      worker(Ordnunger.Worker, [])
    ]
    Supervisor.start_link(children, strategy: :one_for_one)
  end
end

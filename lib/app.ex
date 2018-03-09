defmodule Ordnunger.W do
  use GenServer

  def init(_) do
    {:ok, 1}
  end

  def start_link() do
    GenServer.start_link(__MODULE__, :ok, [])
  end

end

defmodule OrdnungerApp do
  use Application
  import Supervisor.Spec

  def start(a, _args) do
    Supervisor.start_link([worker(Ordnunger.W, [])],
                          [strategy: :one_for_one])
  end

end

defmodule OrdnungerTest do
  use ExUnit.Case
  alias Ordnunger.Rand, as: R
  doctest Ordnunger.Rand

  test "greets the world" do
    max = 100
    seed = R.seed(Date.utc_today())
    {n, seed} = R.rand_int(seed, max)
    assert is_number(n)
    assert n < 100
  end
end

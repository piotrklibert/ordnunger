defmodule Ordnunger.Rand do
  def seed(date) do
    :rand.seed_s(:exrop, {date.year, date.month, date.day*10})
  end

  def rand_int(seed, min \\ 0, max) do
    {rand, seed} = :rand.uniform_s(seed)
    int = round(rand * (max - min) + min)
    {int, seed}
  end
end

defmodule Ordnunger.Members do
  alias Ordnunger.Rand

  defmodule Ordnung do
    defstruct list: nil, seed: nil, members: nil, chairman: nil, date: nil
  end

  def member_list() do
    case System.get_env("MEMBERS") |> Code.eval_string do
      {nil, []} ->
        raise "ERROR: MEMBERS environment variable unset or empty"
      {members, _} -> members
    end
  end

  def get_for_today() do
    get_for_date(Date.utc_today())
  end

  def get_for_date(date), do: get_for_date(date, member_list())
  def get_for_date(date, list) do
    %Ordnung{list: list, seed: Rand.seed(date), date: date}
    |> put_random_chairman()
    |> put_random_members()
  end

  def put_random_chairman(ordnung = %Ordnung{list: list, seed: seed}) do
    {rand_idx, seed} = Rand.rand_int(seed, length(list) - 1)
    chair = Enum.at(list, rand_idx)
    # TODO: re-draw chairman if the same was chosen yesterday
    %Ordnung{ordnung | list: list, chairman: chair, seed: seed}
  end

  def put_random_members(ordnung = %Ordnung{list: list, seed: seed}) do
    {order, seed} = get_random_indexes(seed, list)
    members = for idx <- order, do: Enum.at(list, idx)
    %Ordnung{ordnung | seed: seed, members: members}
  end


  defp get_random_indexes(seed, list) when is_list(list) do
    count = length(list) - 1
    get_random_indexes(seed, count, count, [])
  end

  defp get_random_indexes(seed, _count, -1, acc), do: {acc, seed}
  defp get_random_indexes(seed, count, pos, acc) do
    {idx, seed} = Rand.rand_int(seed, count)
    case Enum.member?(acc, idx) do
      true  -> get_random_indexes(seed, count, pos, acc)
      false -> get_random_indexes(seed, count, pos - 1, [idx | acc])
    end
  end

end

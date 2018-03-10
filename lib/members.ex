defmodule Ordnunger.Members do
  @member_list ["Jakub F.", "Maciej W.", "Magda K.",
                "Piotr J.", "Jarosław G.", "Jacek Sz.",
                "Piotr K.", "Alexander K.", "Piotr P."]

  def get_random_members do
    count = length(@member_list) - 1
    for idx <- get_random_indexes(count), do:
        Enum.at(@member_list, idx)
  end

  defp get_random_indexes(count) do
    get_random_indexes(count, seed(Date.utc_today()))
  end

  defp get_random_indexes(count, seed) do
    get_random_indexes(count, seed, count, [])
  end

  defp get_random_indexes(_range, _seed, -1, idxs), do: idxs
  defp get_random_indexes(range, seed, count, idxs) do
    {rand, seed} = :rand.uniform_s(seed)
    idx = round(rand * range)
    case Enum.member?(idxs, idx) do
      true  ->
        # ignore the current index, generate another one
        get_random_indexes(range, seed, count, idxs)
      false ->
        # accept the current index, proceed to generate further indexes
        get_random_indexes(range, seed, count - 1, [idx | idxs])
    end
  end

  defp seed(date) do
    :rand.seed_s(:exrop, {date.year, date.month, date.day})
  end
end

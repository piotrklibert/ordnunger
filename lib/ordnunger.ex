defmodule Ordnunger do
  use Trot.Router
  use Trot.Template

  if Mix.env == :dev do
    use Plug.Debugger
  end

  @template_root "priv/templates/"

  @member_list [
    "Jakub F.",
    "Maciej W.",
    "Magda K.",
    "Piotr J.",
    "Jarosław G.",
    "Jacek Sz.",
    "Piotr K.",
    "Alexander K.",
    "Piotr P."
  ]

  @static_root "priv/static/"
  static "/statics/", ""


  get "" do
    today = Date.utc_today()
    render_template "index.html.eex", [
      today: today,
      members: get_random_members()
    ]
  end

  def get_random_members do
    count = length(@member_list) - 1
    for idx <- get_random_indexes(count), do:
        Enum.at(@member_list, idx)
  end

  def get_random_indexes(count) do
    %{year: year, month: month, day: day} = DateTime.utc_now()
    seed = :rand.seed_s(:exrop, {year, month, day})
    get_random_indexes(count, seed, count, [])
  end

  def get_random_indexes(_range, _seed, -1, idxs), do: idxs
  def get_random_indexes(range, seed, count, idxs) do
    {rand, seed} = :rand.uniform_s(seed)
    rand = round(rand * range)
    case Enum.member?(idxs, rand) do
      true  -> get_random_indexes(range, seed, count, idxs)
      false -> get_random_indexes(range, seed, count - 1, [rand | idxs])
    end
  end
end

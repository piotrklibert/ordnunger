defmodule Ordnunger.Router do
  use Trot.Router
  use Trot.Template
  use Plug.Debugger

  @static_root "priv/static/"
  @template_root "priv/templates/"

  # Routes:

  static "/statics/", ""

  get "" do
    import Ordnunger.Members
    render_template "index.html.eex", [
      today: Date.utc_today(),
      members: get_random_members()
    ]
  end
end

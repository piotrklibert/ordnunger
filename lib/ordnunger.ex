defmodule Ordnunger.Router do
  use Trot.Router
  use Trot.Template
  use Plug.Debugger

  @static_root Application.app_dir(:ordnunger) |> Path.join("/priv/static/")
  @template_root "priv/templates/"

  # Routes:

  static "/statics/", ""

  get "" do
    alias Ordnunger.Members
    ordnung = Members.get_for_today()
    render_template "index.html.eex", [
      today: Date.utc_today(),
      members: ordnung.members,
      chairman: ordnung.chairman,
      show_chairman: false
    ]
  end
end

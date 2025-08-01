defmodule Rocket4ce.Repo do
  use Ecto.Repo,
    otp_app: :rocket4ce,
    adapter: Ecto.Adapters.Postgres
end

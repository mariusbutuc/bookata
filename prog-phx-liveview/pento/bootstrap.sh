PHOENIX_VERSION=1.6.15

mix local.rebar --force
mix local.hex --if-missing --force
mix archive.install --force hex phx_new #{PHOENIX_VERSION}

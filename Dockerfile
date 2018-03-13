FROM elixir:alpine

RUN apk add --no-cache git bash openssh-client \
    && mix local.hex --force \
    && mix local.rebar --force

COPY . /app

RUN cd /app \
    && mix deps.get \
    && MIX_ENV=prod mix release

ENTRYPOINT ["/app/_build/prod/rel/ordnunger/bin/ordnunger"]

EXPOSE 4000:4000

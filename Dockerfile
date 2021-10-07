FROM elixir:1.12.3-alpine

WORKDIR /app

RUN mix do local.hex --force, local.rebar --force

COPY mix.exs mix.lock ./

COPY config config

RUN mix do deps.get, deps.compile

COPY . ./
RUN mix compile

CMD mix phx.server


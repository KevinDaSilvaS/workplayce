FROM elixir

COPY ./ .

EXPOSE 4000

RUN mix local.hex --force

RUN mix deps.get

RUN mix local.rebar --force

CMD mix phx.server

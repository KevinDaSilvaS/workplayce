FROM elixir

WORKDIR /app

COPY ./ .

RUN mix local.hex --force

RUN mix deps.get, deps.compile

RUN mix local.rebar --force

WORKDIR /app/apps/server

RUN MIX_ENV=dev mix compile

RUN mix phx.digest

WORKDIR /app

RUN MIX_ENV=dev mix release

FROM elixir

EXPOSE 4000
ENV PORT=4000 \
    MIX_ENV=dev \
    SHELL=/bin/bash

WORKDIR /app

COPY --from=releaser app/_build/prod/rel/server .

COPY --from=releaser app/bin/ ./bin

CMD ["./bin/start"]

#CMD mix phx.server
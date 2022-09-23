FROM elixir as releaser

WORKDIR /app

COPY ./ .

RUN mix local.hex --force

RUN mix local.rebar --force

RUN mix deps.get

RUN mix deps.compile

WORKDIR /app/apps/server

RUN MIX_ENV=prod mix compile

RUN mix phx.digest

WORKDIR /app

RUN MIX_ENV=prod mix release

FROM elixir as final

EXPOSE 4000
ENV PORT=4000 
ENV MIX_ENV=prod 
ENV SHELL=/bin/bash

WORKDIR /app

COPY --from=releaser app/_build/prod/rel/src .

COPY --from=releaser app/ .

#WORKDIR /app/releases/0.1.0

#COPY --from=releaser app/releases/0.1.2/env.sh ./bin/

#CMD echo "$(ls)"

CMD ["./bin/src"]

#COPY --from=releaser app/ .

#CMD echo "$(ls)"
#CMD mix phx.server
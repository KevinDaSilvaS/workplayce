FROM elixir as releaser

WORKDIR /app

EXPOSE 4000

ENV PORT=4000 
ENV MIX_ENV=prod 

ENV SECRET_KEY_BASE=123

COPY ./apps ./apps
COPY ./config ./config
COPY ./mix.exs .
COPY ./.formatter.exs .

RUN mix local.hex --force

RUN mix local.rebar --force

RUN mix deps.get

RUN MIX_ENV=prod mix compile

RUN MIX_ENV=prod mix release

CMD _build/prod/rel/src/bin/src start

#CMD echo "$(ls)"
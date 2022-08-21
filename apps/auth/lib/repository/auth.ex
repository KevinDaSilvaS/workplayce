defmodule Auth.Repository.Auth do
  @table :auth
  @default_ttl 60

  use Agent

  defp timestamp, do: DateTime.to_unix(DateTime.utc_now())

  def start_link(_) do
    :ets.new(@table, [:set, :public, :named_table])
    Agent.start_link(fn -> :ok end, name: __MODULE__)
  rescue
    ArgumentError -> {:error, :already_started}
  end

  def get_auth(key, ttl \\ @default_ttl) do
    case :ets.lookup(@table, key) do
      [{^key, value, ts}] ->
        if (timestamp() - ts) <= ttl do
          value
        end

      _else ->
        nil
    end
  end

  def insert_auth(value) do
    key = :crypto.strong_rand_bytes(80) |> Base.encode64()

    true = :ets.insert(@table, {key, value, timestamp()})
    %{"token_id" => key}
  end
end

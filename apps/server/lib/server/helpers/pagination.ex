defmodule Server.Helpers.Pagination do
  @default_page "1"
  @default_limit "10"

  def set(opts) do
    try do
      limit = Map.get(opts, "limit", @default_limit) |> String.to_integer()

      page =
        Map.get(opts, "page", @default_page)
        |> String.to_integer()
        |> set_page()

      {limit, page}
    rescue
      _ ->
        limit = @default_limit |> String.to_integer()
        page = @default_page |> String.to_integer()
        {limit, page}
    end
  end

  defp set_page(page) when page > 0 do
    page
  end

  defp set_page(_), do: @default_page |> String.to_integer()
end

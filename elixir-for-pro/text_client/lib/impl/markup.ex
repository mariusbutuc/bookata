defmodule TextClient.Impl.Markup do
  @doc """
  Sets foreground color from a CSS short hex code format.

  ## Examples

    iex> Markup.color("#1bb")
    "\e[38;5;44m"
  """
  @spec color(String.t()) :: String.t()
  def color(hex) when hex |> is_binary() do
    color_components =
      hex
      |> extract_rgb(String.length(hex))
      |> Enum.map(fn hex -> String.to_integer(hex, 16) end)
      |> Enum.map(&base_255_to_5/1)

    apply(IO.ANSI, :color, color_components)
  end

  defdelegate reset(), to: IO.ANSI

  defp extract_rgb(hex, _length = 4) do
    hex
    |> String.trim("#")
    |> String.split("", trim: true)
    |> Enum.map(&String.upcase/1)
    |> short_to_long_hex()
  end

  defp short_to_long_hex(hex = [_R, _G, _B]), do: Enum.map(hex, fn x -> "#{x}#{x}" end)

  defp base_255_to_5(base_255), do: round(base_255 * 5 / 255)
end

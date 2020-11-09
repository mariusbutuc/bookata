defmodule Servy.Parser do
  @moduledoc """
  Parses HTTP requests.
  """

  alias Servy.Conv

  @doc """
  Transform a HTTP request string into a map.
  """
  def parse(request) do
    [method, path, _] =
      request
      |> String.split("\n")
      |> List.first()
      |> String.split()

    %Conv{
      method: method,
      path: path
    }
  end
end
